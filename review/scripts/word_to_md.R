library(officer)
library(purrr)
library(dplyr)
library(tidyr)
library(xml2)

# Setup -------------------------------------------------------------------

md_dir     <- "inst/app/www/assets/markdown" # Markdown dir
rv_dir     <- "review"                       # Review directory
docx_file  <- "review.docx"                  # Input Word doc
md_out_dir <- "review/temp"                  # Output markdown dir


# Get Word doc contents ---------------------------------------------------

doc <- read_docx(file.path(rv_dir, docx_file))
doc_df <- docx_summary(doc)


# Get style data ----------------------------------------------------------

# We need to create maps for each type of styling or hyperlink.
# These will be applied to the markdown generated from the Word doc
style_map <- function(doc, t1, t2 = NULL, t3 = NULL, val3 = NULL, t4 = NULL, val4 = NULL) {
  smap         <- list()
  num_blank    <- 0
  num_elements <- length(doc)
  
  for (i in 1:num_elements) {
    doc$officer_cursor$which <- i
    num_chars <- 0
    parent <- docx_current_block_xml(doc)
    first_children <- xml_children(parent)
    if(xml_text(parent) == "") num_blank <- num_blank + 1
    for (first_child in first_children) {
      match_found <- FALSE
      num_chars <- num_chars + nchar(xml_text(first_child))
      if (!xml_name(first_child) == t1) next
      if (!is.null(t2)) {
        second_children <- xml_children(first_child)
        for (second_child in second_children) {
          if (!xml_name(second_child) == t2) next
          if (!is.null(t3)) {
            third_children <- xml_children(second_child)
            for (third_child in third_children) {
              if (!xml_name(third_child) == t3) next
              if (!is.null(val3) && is.na(xml_attr(third_child, "val"))) next
              if (!is.null(val3) && xml_attr(third_child, "val") != val3) next
              if (!is.null(t4)) {
                fourth_children <- xml_children(third_child)
                for (fourth_child in fourth_children) {
                  if (!xml_name(fourth_child) == t4) next
                  if (!is.null(val4) && is.na(xml_attr(fourth_child, "val"))) next
                  if (xml_attr(fourth_child, "val") != val4) next
                  match_found <- TRUE
                }
              } else match_found <- TRUE
            }
          } else match_found <- TRUE
        }
      } else match_found <- TRUE
      
      if (match_found) {
        style_data <- list(
          num_chars - nchar(xml_text(first_child)) + 1,
          num_chars
        )
        xml_attr_names <- xml_attrs(first_child) %>% names()
        if (length(xml_attr_names) & "id" %in% xml_attr_names) {
          style_data <- c(style_data, list(xml_attrs(first_child)[["id"]]))
        }
        if (length(xml_attr_names) & "anchor" %in% xml_attr_names) {
          style_data <- c(style_data, list(xml_attrs(first_child)[["anchor"]]))
        }
        if (as.character(i - num_blank) %in% names(smap)) {
          prev_index <- length(smap[[as.character(i - num_blank)]])
          new_index <- prev_index + 1
          if (style_data[[1]] == 
                smap[[as.character(i - num_blank)]][[prev_index]][[2]] + 1) {
            smap[[as.character(i - num_blank)]][[prev_index]][[2]] <- style_data[[2]]
          } else {
            smap[[as.character(i - num_blank)]][[new_index]] <- style_data
          }
        } else {
          smap[[as.character(i - num_blank)]] <- list(
            `1` = style_data
          )
        }
      }
    }
  }
  
  smap %>% map(unique)
}

maps <- list(
  bold_map = style_map(doc, "r", "rPr", "b"),
  ital_map = style_map(doc, "r", "rPr", "i"),
  hypl_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "Hyperlink"),
  code_map = style_map(doc, "r", "rPr", "rStyle", "VerbatimChar"),
  chyp_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "VerbatimChar")
)


# Compute file breakpoints ------------------------------------------------

# This will find the rows to use for each md file
breaks <- doc_df %>%
  filter(startsWith(text, md_dir)) %>%
  mutate(
    md_file = text,
    begin   = doc_index + 1,
    end     = lead(doc_index) - 1,
    .keep   = "none"
  ) %>%
  replace_na(list(end = nrow(doc_df)))


# Create markdown files ---------------------------------------------------

# Iterate over the markdown filenames. The content for each file is transformed
# to apply styling and hyperlinks and then written to md_out_dir
pwalk(
  breaks,
  \(md_file, begin, end) {
    # Each file has content from row number start to end
    doc_df <- doc_df %>%
      filter(between(doc_index, begin, end))

    # Apply any bold styling
    for (row in intersect(names(maps$bold_map), begin:end)) {
      offset <- 0
      increment <- 4
      for (style_data in maps$bold_map[[row]]) {
        rownum <- as.integer(row)
        start  <- style_data[[1]] + offset
        stop   <- style_data[[2]] + offset

        bold_applied <- doc_df %>% 
          filter(doc_index == rownum) %>% 
          mutate(
            text = paste0(
              substr(text, 0, start - 1),
              "__",
              substr(text, start, stop),
              "__",
              substr(text, stop + 1, nchar(text))
            )
          ) %>% 
          pull(text)
        
        doc_df <- doc_df %>% 
          mutate(
            text = replace(
              text, 
              doc_index == rownum, 
              bold_applied
            )
          )
        
        # Add offsets to remaining maps
        for (m in 2:5) {
          if (row %in% names(maps[[m]])) {
            for (i in seq(length(maps[[m]][[row]]))) {
              if ((stop + offset) <= maps[[i]][[row]][[i]][[1]]) {
                maps[[m]][[row]][[i]][[1]] <<- maps[[m]][[row]][[i]][[1]] + increment
                maps[[m]][[row]][[i]][[2]] <<- maps[[m]][[row]][[i]][[2]] + increment
              }
            }
          }
        }
        
        offset <- offset + increment
      }
    }
    
    # Apply any italics styling
    for (row in intersect(names(maps$ital_map), begin:end)) {
      offset <- 0
      increment <- 2
      for (style_data in maps$ital_map[[row]]) {
        rownum <- as.integer(row)
        start  <- style_data[[1]] + offset
        stop   <- style_data[[2]] + offset
        
        ital_applied <- doc_df %>% 
          filter(doc_index == rownum) %>% 
          mutate(
            text = paste0(
              substr(text, 0, start - 1),
              "_",
              substr(text, start, stop),
              "_",
              substr(text, stop + 1, nchar(text))
            )
          ) %>% 
          pull(text)
        
        doc_df <- doc_df %>% 
          mutate(
            text = replace(
              text, 
              doc_index == rownum, 
              ital_applied
            )
          )
        
        # Add offsets to remaining maps
        for (m in 3:5) {
          if (row %in% names(maps[[m]])) {
            for (i in seq(length(maps[[m]][[row]]))) {
              if ((stop + offset) <= maps[[m]][[row]][[i]][[1]]) {
                maps[[m]][[row]][[i]][[1]] <<- maps[[m]][[row]][[i]][[1]] + increment
                maps[[m]][[row]][[i]][[2]] <<- maps[[m]][[row]][[i]][[2]] + increment
              }
            }
          }
        }
        
        offset <- offset + increment
      }
    }
    
    # Add any hyperlinks
    for (row in intersect(names(maps$hypl_map), begin:end)) {
      offset <- 0
      increment <- 4
      for (style_data in maps$hypl_map[[row]]) {
        rownum <- as.integer(row)
        start  <- style_data[[1]] + offset
        stop   <- style_data[[2]] + offset
        invisible(capture.output(
          url <- doc$
            doc_obj$
            relationship()$
            show() %>%
            as_tibble() %>%
            filter(id == style_data[[3]]) %>%
            pull(target)
        ))
        url <- if (length(style_data) == 4) {
          paste0(url, "#", style_data[[4]])
        } else {
          url
        }

        hypl_applied <- doc_df %>%
          filter(doc_index == rownum) %>%
          mutate(
            text = paste0(
              substr(text, 0, start - 1),
              "[",
              substr(text, start, stop),
              "](",
              url,
              ")",
              substr(text, stop + 1, nchar(text))
            )
          ) %>%
          pull(text)

        doc_df <- doc_df %>%
          mutate(
            text = replace(
              text,
              doc_index == rownum,
              hypl_applied
            )
          )
        
        # Add offsets to remaining maps
        for (m in 4:5) {
          if (row %in% names(maps[[m]])) {
            for (i in seq(length(maps[[m]][[row]]))) {
              if ((stop + offset) <= maps[[m]][[row]][[i]][[1]]) {
                maps[[m]][[row]][[i]][[1]] <<- maps[[m]][[row]][[i]][[1]] + increment + nchar(url)
                maps[[m]][[row]][[i]][[2]] <<- maps[[m]][[row]][[i]][[2]] + increment + nchar(url)
              }
            }
          }
        }
        
        offset <- offset + increment + nchar(url)
      }
    }
    
    # Apply any code (monospace font) styling
    for (row in intersect(names(maps$code_map), begin:end)) {
      offset <- 0
      increment <- 8
      for (style_data in maps$code_map[[row]]) {
        rownum <- as.integer(row)
        start  <- style_data[[1]] + offset
        stop   <- style_data[[2]] + offset
        
        code_applied <- doc_df %>% 
          filter(doc_index == rownum) %>% 
          mutate(
            text = paste0(
              substr(text, 0, start - 1),
              "````",
              substr(text, start, stop),
              "````",
              substr(text, stop + 1, nchar(text))
            )
          ) %>% 
          pull(text)
        
        doc_df <- doc_df %>% 
          mutate(
            text = replace(
              text, 
              doc_index == rownum, 
              code_applied
            )
          )
        
        # Add offsets to remaining maps
        for (m in 5:5) {
          if (row %in% names(maps[[m]])) {
            for (i in seq(length(maps[[m]][[row]]))) {
              if ((stop + offset) <= maps[[m]][[row]][[i]][[1]]) {
                maps[[m]][[row]][[i]][[1]] <<- maps[[m]][[row]][[i]][[1]] + increment
                maps[[m]][[row]][[i]][[2]] <<- maps[[m]][[row]][[i]][[2]] + increment
              }
            }
          }
        }
        
        offset <- offset + increment
      }
    }
    
    # Add any code (monospace font) hyperlinks
    for (row in intersect(names(maps$chyp_map), begin:end)) {
      offset <- 0
      increment <- 12
      for (style_data in maps$chyp_map[[row]]) {
        rownum <- as.integer(row)
        start  <- style_data[[1]] + offset
        stop   <- style_data[[2]] + offset
        invisible(capture.output(
          url <- doc$
            doc_obj$
            relationship()$
            show() %>%
            as_tibble() %>%
            filter(id == style_data[[3]]) %>%
            pull(target)
        ))

        chyp_applied <- doc_df %>%
          filter(doc_index == rownum) %>%
          mutate(
            text = paste0(
              substr(text, 0, start - 1),
              "[````",
              substr(text, start, stop),
              "````](",
              url,
              ")",
              substr(text, stop + 1, nchar(text))
            )
          ) %>%
          pull(text)

        doc_df <- doc_df %>%
          mutate(
            text = replace(
              text,
              doc_index == rownum,
              chyp_applied
            )
          )

        offset <- offset + increment + nchar(url)
      }
    }
    
    # Numbered lists need special treatment, the XML is very convoluted...
    numbering_xml <- file.path(
      doc$package_dir,
      "word",
      "numbering.xml"
    ) %>% read_xml()
    
    num_ids_alt_1 <- numbering_xml %>% 
      xml_find_all("//w:num[w:abstractNumId/@w:val='99411']") %>%
      xml_attr("numId") %>% 
      as.numeric()
    num_ids_alt_2 <- numbering_xml %>% 
      xml_find_all("//w:num[w:abstractNumId/@w:val='2']") %>%
      xml_attr("numId") %>% 
      as.numeric()
    num_ids <- c(num_ids_alt_1, num_ids_alt_2)
    
    # Add heading, bullet and list markup and find where to add blank lines
    doc_df <- doc_df %>%
      mutate(
        next_style = lead(style_name),
        blank_after = (
          (style_name != "Compact") |
            (style_name == "Compact" & lead(style_name) != "Compact")
        ) &
          (!is.na(lead(style_name))),
        style_name = case_when(
          num_id %in% num_ids ~ "Numbering",
          TRUE ~ style_name
        ),
        text = case_match(
          style_name,
          "Heading 2" ~ paste0("## ", text),
          "heading 2" ~ paste0("## ", text),
          "Heading 3" ~ paste0("### ", text),
          "heading 3" ~ paste0("### ", text),
          "Heading 4" ~ paste0("#### ", text),
          "heading 4" ~ paste0("#### ", text),
          "Compact"   ~ paste0("- ", text),
          .default    = text
        )
      ) %>%
      group_by(num_id) %>%
      mutate(
        text = case_match(
          style_name,
          "Numbering" ~ paste0(seq(n()), ". ", text),
          .default    = text
        )
      ) %>% 
      ungroup()

    # Get the element indices which need a blank line afterward
    needs_blank_after <- which(doc_df$blank_after) +
      seq_len(length(which(doc_df$blank_after))) - 1

    # Iterate over the indices and add a new blank row after each
    walk(needs_blank_after, \(x) doc_df <<- add_row(doc_df, text = "", .after = x))

    # Write the markdown file
    writeLines(doc_df$text, file.path(md_out_dir, basename(md_file)))
  }
)
