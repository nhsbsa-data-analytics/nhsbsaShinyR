#' Generate a initial Word doc to write draft text in
#'
#' The `\{officer\}` package works best with a Word document generated from
#' Rmarkdown. This is just a wrapper around `rmarkdown::render` to do that, with
#' default arguments matching our package conventions.
#'
#' @param rv_dir Review directory
#' @param docx_file Output Word document file name
#' @param styles_rmd Path to Rmarkdown that creates Word template
#'
#' @return Path to the generated Word document
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' gen_template_doc()
#'
#' # May be times when you want to use outside of the usual use case, e.g.
#' # generate Word doc for adhoc purposes
#' gen_template_doc(
#'   "C:/Users/CYPHER/Downloads",
#'   "adhoc.docx"
#' )}
gen_template_doc <- function(rv_dir = "inst/review",
                             docx_file = "review.docx",
                             styles_rmd = system.file(
                               "review", "styles", "draft-styles.rmd",
                               package = "nhsbsaShinyR"
                             )) {
  rmarkdown::render(
    styles_rmd,
    output_dir = rv_dir,
    output_file = docx_file,
    quiet = TRUE
  )
}


#' Generate Word doc from markdown files
#'
#' All markdown files in a folder can be used to generate a Word document. The
#' main use case is for use in reviewing often changing text when writing final
#' output of initiatives. It can be used standalone for adhoc purposes.
#'
#' @param md_dir Markdown directory
#' @param rv_dir Review directory
#' @param docx_file Output Word document file name
#' @param styles_rmd Path to Rmarkdown that creates Word template
#'
#' @return Path of generated Word doc
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' md_to_word()
#'
#' # May be times when you want to use outside of the usual use case, e.g.
#' # generate Word doc for adhoc purposes
#' md_to_word(
#'   "my/adhoc/markdown",
#'   "C:/Users/CYPHER/Downloads",
#'   "adhoc.docx"
#' )}
md_to_word <- function(md_dir = "inst/app/www/assets/markdown",
                       rv_dir = "inst/review",
                       docx_file = "review.docx",
                       styles_rmd = system.file(
                         "review", "styles", "draft-styles.rmd",
                         package = "nhsbsaShinyR"
                       )) {
  styles_doc <- gen_template_doc(
    rv_dir = tempdir(),
    docx_file = tempfile(),
    styles_rmd = styles_rmd
  )

  # Get paths of md files
  md_files <- Sys.glob(file.path(md_dir, "*.md"))

  # Combine them into one rmarkdown file
  all_md <- purrr::map(md_files, readLines) # List of md content

  # Keep only parent folder and file name
  md_files <- file.path(
    rev(strsplit(dirname(md_files), "/")[[1]])[[1]],
    basename(md_files)
  )

  all_md <- purrr::map2(all_md, md_files, \(x, y) c(y, "", x, "")) # Add file marker
  all_md <- purrr::reduce(all_md, c)                     # All content in one vector
  writeLines(all_md, file.path(tempdir(), "all_md.rmd"))

  # Check and rename if existing review.docx is present
  docx_path <- file.path(rv_dir, docx_file)
  if (file.exists(docx_path)) {
    file.rename(docx_path, file.path(rv_dir, paste0("prev-", docx_file)))
  }

  # Create Word document
  rmarkdown::render(
    file.path(tempdir(), "all_md.rmd"),
    officedown::rdocx_document(
      reference_docx = styles_doc,
      toc = FALSE,
      number_sections = FALSE
    ),
    output_dir = rv_dir,
    output_file = docx_file,
    quiet = TRUE
  )

  # Return path of generated Word doc invisibly
  invisible(docx_path)
}


#' Create a map of specific styles in a Word document
#'
#' The arguments provided act as filters and conditions. As the document XML is
#' parsed, elements not filtered out are those matching the desired style.
#'
#' @param doc An `officer` `docx` object
#' @param t1 First tag name
#' @param t2 Second tag name
#' @param t3 Third tag name
#' @param val3 Value of `val` attribute for third tag
#' @param t4 Fourth tag name
#' @param val4 Value of `val` attribute for fourth tag
#'
#' @return A named list of lists. Names correspond to lines in the document. The
#'   sub-lists contain the character indexes of the text with specific style.
#'   There can be multiple entries for a single line.
#'
#' @noRd
#'
#' @examples
#' doc <- officer::read_docx(
#'   system.file(
#'     "tests", "testthat", "review.docx",
#'     package = "nhsbsaShinyR"
#'   )
#' )
#' style_map(doc, "r", "rPr", "b") # bold text
#' style_map(doc, "r", "rPr", "i") # italics text
#' style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "Hyperlink") # hyperlinks
#' style_map(doc, "r", "rPr", "rStyle", "VerbatimChar") # monospace code
#' style_map(
#'   doc, "hyperlink", "r", "rPr", NULL, "rStyle", "VerbatimChar"
#' ) # monospace code hyperlinks
# Begin Exclude Linting
style_map <- function(doc, t1, t2 = NULL,
                      t3 = NULL, val3 = NULL,
                      t4 = NULL, val4 = NULL) {
  # End Exclude Linting
  smap         <- list()
  num_blank    <- 0

  for (i in seq_along(doc)) {
    doc$officer_cursor$which <- i
    num_chars <- 0
    parent <- officer::docx_current_block_xml(doc)
    first_children <- xml2::xml_children(parent)
    if (xml2::xml_text(parent) == "") num_blank <- num_blank + 1
    for (first_child in first_children) {
      match_found <- FALSE
      num_chars <- num_chars + nchar(xml2::xml_text(first_child))
      if (!xml2::xml_name(first_child) == t1) next
      if (!is.null(t2)) {
        second_children <- xml2::xml_children(first_child)
        for (second_child in second_children) {
          if (!xml2::xml_name(second_child) == t2) next
          if (!is.null(t3)) {
            third_children <- xml2::xml_children(second_child)
            for (third_child in third_children) {
              if (!xml2::xml_name(third_child) == t3) next
              if (!is.null(val3) && is.na(xml2::xml_attr(third_child, "val"))) next
              if (!is.null(val3) && xml2::xml_attr(third_child, "val") != val3) next
              if (!is.null(t4)) {
                fourth_children <- xml2::xml_children(third_child)
                for (fourth_child in fourth_children) {
                  if (!xml2::xml_name(fourth_child) == t4) next
                  if (!is.null(val4) && is.na(xml2::xml_attr(fourth_child, "val"))) next
                  if (xml2::xml_attr(fourth_child, "val") != val4) next
                  match_found <- TRUE
                }
              } else {
                match_found <- TRUE
              }
            }
          } else {
            match_found <- TRUE
          }
        }
      } else {
        match_found <- TRUE
      }

      if (match_found) {
        style_data <- list(
          num_chars - nchar(xml2::xml_text(first_child)) + 1,
          num_chars
        )
        xml_attr_names <- xml2::xml_attrs(first_child) %>% names()
        if (length(xml_attr_names) && "id" %in% xml_attr_names) {
          style_data <- c(style_data, list(xml2::xml_attrs(first_child)[["id"]]))
        }
        if (length(xml_attr_names) && "anchor" %in% xml_attr_names) {
          style_data <- c(style_data, list(xml2::xml_attrs(first_child)[["anchor"]]))
        }
        if (as.character(i - num_blank) %in% names(smap)) {
          prev_index <- length(smap[[as.character(i - num_blank)]])
          new_index <- prev_index + 1
          if (
              style_data[[1]] ==
                smap[[as.character(i - num_blank)]][[prev_index]][[2]] + 1) {
            smap[[as.character(i - num_blank)]][[prev_index]][[2]] <-
              style_data[[2]]
          } else {
            smap[[as.character(i - num_blank)]][[new_index]] <- style_data
          }
        } else {
          smap[[as.character(i - num_blank)]] <- list(`1` = style_data)
        }
      }
    }
  }

  smap %>% purrr::map(unique)
}


#' Generate markdown files from Word doc
#'
#' A Word document can be used to generate multiple markdown files. The main use
#' case is for use in reviewing often changing text when writing final output of
#' initiatives. It can be used standalone for adhoc purposes.
#'
#' @param md_flag How markdown file is flagged in Word doc; lines starting with
#'   this will be taken as flags to assign following content to a markdown file
#'   with name as everything after this
#' @param rv_dir Review directory
#' @param docx_file Output Word document file name
#' @param md_out_dir Output folder for markdown files
#' @param first_run_snaps Should snapshot files be generated if there are none?
#'
#' @return Nothing, used for side effects only
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' word_to_md()
#'
#' # May be times when you want to use outside of the usual use case, e.g.
#' # generate markdown for adhoc purposes
#' word_to_md(
#'   "my/adhoc/markdown",
#'   "C:/Users/CYPHER/Downloads",
#'   "adhoc.docx",
#'   "C:/Users/CYPHER/Downloads"
#' )}
# Begin Exclude Linting
word_to_md <- function(md_flag = "markdown/",
                       rv_dir = "inst/review",
                       docx_file = "review.docx",
                       md_out_dir = "inst/review/temp",
                       first_run_snaps = TRUE) {
  # End Exclude Linting
  doc <- officer::read_docx(file.path(rv_dir, docx_file))
  doc_df <- officer::docx_summary(doc)
  maps <- list(
    bold_map = style_map(doc, "r", "rPr", "b"),
    ital_map = style_map(doc, "r", "rPr", "i"),
    hypl_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "Hyperlink"),
    code_map = style_map(doc, "r", "rPr", "rStyle", "VerbatimChar"),
    chyp_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "VerbatimChar")
  )

  # This will find the rows to use for each md file
  breaks <- doc_df %>%
    dplyr::filter(startsWith(.data$text, md_flag)) %>%
    dplyr::mutate(
      md_file = .data$text,
      begin   = .data$doc_index + 1,
      end     = dplyr::lead(.data$doc_index) - 1,
      .keep   = "none"
    ) %>%
    tidyr::replace_na(list(end = nrow(doc_df)))

  # Iterate over the markdown filenames. The content for each file is transformed
  # to apply styling and hyperlinks and then written to md_out_dir
  purrr::pwalk(
    breaks,
    \(md_file, begin, end) {
      # Each file has content from row number start to end
      doc_df <- doc_df %>%
        dplyr::filter(dplyr::between(.data$doc_index, begin, end))

      # Apply any bold styling
      for (row in dplyr::intersect(names(maps$bold_map), begin:end)) {
        offset <- 0
        increment <- 4
        for (style_data in maps$bold_map[[row]]) {
          rownum <- as.integer(row)
          start  <- style_data[[1]] + offset
          stop   <- style_data[[2]] + offset

          bold_applied <- doc_df %>%
            dplyr::filter(.data$doc_index == rownum) %>%
            dplyr::mutate(
              text = paste0(
                substr(.data$text, 0, start - 1),
                "__",
                substr(.data$text, start, stop),
                "__",
                substr(.data$text, stop + 1, nchar(.data$text))
              )
            ) %>%
            dplyr::pull(.data$text)

          doc_df <- doc_df %>%
            dplyr::mutate(
              text = replace(
                .data$text,
                .data$doc_index == rownum,
                bold_applied
              )
            )

          # Add offsets to remaining maps
          for (m in 2:5) {
            if (row %in% names(maps[[m]])) {
              for (i in seq_along(maps[[m]][[row]])) {
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
      for (row in dplyr::intersect(names(maps$ital_map), begin:end)) {
        offset <- 0
        increment <- 2
        for (style_data in maps$ital_map[[row]]) {
          rownum <- as.integer(row)
          start  <- style_data[[1]] + offset
          stop   <- style_data[[2]] + offset

          ital_applied <- doc_df %>%
            dplyr::filter(.data$doc_index == rownum) %>%
            dplyr::mutate(
              text = paste0(
                substr(.data$text, 0, start - 1),
                "_",
                substr(.data$text, start, stop),
                "_",
                substr(.data$text, stop + 1, nchar(.data$text))
              )
            ) %>%
            dplyr::pull(.data$text)

          doc_df <- doc_df %>%
            dplyr::mutate(
              text = replace(
                .data$text,
                .data$doc_index == rownum,
                ital_applied
              )
            )

          # Add offsets to remaining maps
          for (m in 3:5) {
            if (row %in% names(maps[[m]])) {
              for (i in seq_along(maps[[m]][[row]])) {
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
      for (row in dplyr::intersect(names(maps$hypl_map), begin:end)) {
        offset <- 0
        increment <- 4
        for (style_data in maps$hypl_map[[row]]) {
          rownum <- as.integer(row)
          start  <- style_data[[1]] + offset
          stop   <- style_data[[2]] + offset
          invisible(
            utils::capture.output(
              url <- doc$
                doc_obj$
                relationship()$ # Exclude Linting
                show() %>%
                dplyr::as_tibble() %>%
                dplyr::filter(.data$id == style_data[[3]]) %>%
                dplyr::pull(.data$target)
            )
          )
          url <- if (length(style_data) == 4) {
            paste0(url, "#", style_data[[4]])
          } else {
            url
          }

          hypl_applied <- doc_df %>%
            dplyr::filter(.data$doc_index == rownum) %>%
            dplyr::mutate(
              text = paste0(
                substr(.data$text, 0, start - 1),
                "[",
                substr(.data$text, start, stop),
                "](",
                url,
                ")",
                substr(.data$text, stop + 1, nchar(.data$text))
              )
            ) %>%
            dplyr::pull(.data$text)

          doc_df <- doc_df %>%
            dplyr::mutate(
              text = replace(
                .data$text,
                .data$doc_index == rownum,
                hypl_applied
              )
            )

          # Add offsets to remaining maps
          for (m in 4:5) {
            if (row %in% names(maps[[m]])) {
              for (i in seq_along(maps[[m]][[row]])) {
                if ((stop + offset) <= maps[[m]][[row]][[i]][[1]]) {
                  maps[[m]][[row]][[i]][[1]] <<- maps[[m]][[row]][[i]][[1]] +
                    increment + nchar(url)
                  maps[[m]][[row]][[i]][[2]] <<- maps[[m]][[row]][[i]][[2]] +
                    increment + nchar(url)
                }
              }
            }
          }

          offset <- offset + increment + nchar(url)
        }
      }

      # Apply any code (monospace font) styling
      for (row in dplyr::intersect(names(maps$code_map), begin:end)) {
        offset <- 0
        increment <- 8
        for (style_data in maps$code_map[[row]]) {
          rownum <- as.integer(row)
          start  <- style_data[[1]] + offset
          stop   <- style_data[[2]] + offset

          code_applied <- doc_df %>%
            dplyr::filter(.data$doc_index == rownum) %>%
            dplyr::mutate(
              text = paste0(
                substr(.data$text, 0, start - 1),
                "````",
                substr(.data$text, start, stop),
                "````",
                substr(.data$text, stop + 1, nchar(.data$text))
              )
            ) %>%
            dplyr::pull(.data$text)

          doc_df <- doc_df %>%
            dplyr::mutate(
              text = replace(
                .data$text,
                .data$doc_index == rownum,
                code_applied
              )
            )

          # Add offsets to remaining maps
          for (m in 5:5) {
            if (row %in% names(maps[[m]])) {
              for (i in seq_along(maps[[m]][[row]])) {
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
      for (row in dplyr::intersect(names(maps$chyp_map), begin:end)) {
        offset <- 0
        increment <- 12
        for (style_data in maps$chyp_map[[row]]) {
          rownum <- as.integer(row)
          start  <- style_data[[1]] + offset
          stop   <- style_data[[2]] + offset
          invisible(
            utils::capture.output(
              url <- doc$
                doc_obj$
                relationship()$ # Exclude Linting
                show() %>%
                dplyr::as_tibble() %>%
                dplyr::filter(.data$id == style_data[[3]]) %>%
                dplyr::pull(.data$target)
            )
          )

          chyp_applied <- doc_df %>%
            dplyr::filter(.data$doc_index == rownum) %>%
            dplyr::mutate(
              text = paste0(
                substr(.data$text, 0, start - 1),
                "[````",
                substr(.data$text, start, stop),
                "````](",
                url,
                ")",
                substr(.data$text, stop + 1, nchar(.data$text))
              )
            ) %>%
            dplyr::pull(.data$text)

          doc_df <- doc_df %>%
            dplyr::mutate(
              text = replace(
                .data$text,
                .data$doc_index == rownum,
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
      ) %>% xml2::read_xml()

      num_ids_alt_1 <- numbering_xml %>%
        xml2::xml_find_all("//w:num[w:abstractNumId/@w:val='99411']") %>%
        xml2::xml_attr("numId") %>%
        as.numeric()
      num_ids_alt_2 <- numbering_xml %>%
        xml2::xml_find_all("//w:num[w:abstractNumId/@w:val='2']") %>%
        xml2::xml_attr("numId") %>%
        as.numeric()
      num_ids <- c(num_ids_alt_1, num_ids_alt_2)

      # Add heading, bullet and list markup and find where to add blank lines
      doc_df <- doc_df %>%
        dplyr::mutate(
          next_style = dplyr::lead(.data$style_name),
          blank_after = (
            (.data$style_name != "Compact") |
              (.data$style_name == "Compact" &
                 dplyr::lead(.data$style_name) != "Compact")
          ) & (!is.na(dplyr::lead(.data$style_name))),
          style_name = dplyr::case_when(
            .data$num_id %in% num_ids ~ "Numbering",
            TRUE ~ .data$style_name
          ),
          text = dplyr::case_match(
            .data$style_name,
            "Heading 1" ~ paste0("# ", .data$text),
            "heading 1" ~ paste0("# ", .data$text),
            "Heading 2" ~ paste0("## ", .data$text),
            "heading 2" ~ paste0("## ", .data$text),
            "Heading 3" ~ paste0("### ", .data$text),
            "heading 3" ~ paste0("### ", .data$text),
            "Heading 4" ~ paste0("#### ", .data$text),
            "heading 4" ~ paste0("#### ", .data$text),
            "Compact" ~ paste0("- ", .data$text),
            .default = .data$text
          )
        ) %>%
        dplyr::group_by(.data$num_id) %>%
        dplyr::mutate(
          text = dplyr::case_match(
            .data$style_name,
            "Numbering" ~ paste0(seq_len(dplyr::n()), ". ", .data$text),
            .default = .data$text
          )
        ) %>%
        dplyr::ungroup()

      # Get the element indices which need a blank line afterward
      needs_blank_after <- which(doc_df$blank_after) +
        seq_len(length(which(doc_df$blank_after))) - 1

      # Iterate over the indices and add a new blank row after each
      purrr::walk(
        needs_blank_after,
        \(x) doc_df <<- dplyr::add_row(doc_df, text = "", .after = x)
      )

      # Write the markdown file
      dir.create(md_out_dir, showWarnings = FALSE)
      writeLines(doc_df$text, file.path(md_out_dir, basename(md_file)))
    }
  )

  # Unless disabled, create initial snapshot files if there is no or an empty
  # _snaps dir
  if (first_run_snaps) {
    testthat::local_edition(3)
    if (file.exists(file.path(rv_dir, "_snaps"))) {
      if (!length(Sys.glob(file.path(rv_dir, "tests/_snaps/review_md", "*.md")))) {
        review_md_dir()
      } else {
        rlang::inform(c(
          paste0(
            "Snapshot folder ",
            file.path(rv_dir, "tests/_snaps/review_md"),
            " is not empty."
          ),
          i = "Aborting writing snapshot files"
        ))
      }

      return(invisible())
    }

    review_md_dir()
  }

  invisible()
}


#' Compare and create snapshot for a single markdown file
#'
#' Will announce intention to compare/create snapshots for each markdown file,
#' then do so.
#'
#' @param path The path of the markdown file
#' @param snaps_dir The path of the directory containing (or to create in) the
#'   _snaps directory
#'
#' @return Nothing, used for side-effects only
#' @export
#'
#' @examples
#' \dontrun{
#' review_md(
#'   path = "my/adhoc/markdown/md_file.md",
#'   snaps_dir = "C:/Users/CYPHER/Downloads"
#' )
#' )}
review_md <- function(path, snaps_dir = "inst/review/tests") {
  withr::local_options(list(warn = 1))

  snap_dir <- file.path(snaps_dir, "_snaps")
  snapshotter <- testthat::local_snapshotter(snap_dir = snap_dir)
  snapshotter$start_file("review_md", "test")

  name <- basename(path)
  lab <- rlang::quo_label(rlang::enquo(path))
  msg <- utils::capture.output({
    equal <- snapshotter$take_file_snapshot(
      name,
      path,
      file_equal = testthat::compare_file_text,
      variant = NULL,
      trace_env = rlang::caller_env()
    )
  },
  type = "message")
  if (!identical(msg, character(0))) {
    message(gsub("tests/testthat", snaps_dir, msg))
  }

  tryCatch({
    testthat::expect(
      equal,
      sprintf(
        "Snapshot of %s to \"%s\" has changed\n%s",
        lab,
        paste0(snap_dir, "/", name),
        "Run nhsbsaShinyR::review_md_diff() to review changes"
      )
    )
  },
  error = \(e) message(gsub("Error", "Warning", e)))

  snapshotter$end_file()

  invisible()
}


#' Compare and create snapshots for all markdown files in a directory
#'
#' Will announce intention to compare/create snapshots for each markdown file,
#' then do so.
#'
#' @param md_dir The path to the directory of markdown files
#' @param snaps_dir The path of the directory containing (or to create in) the
#'   _snaps directory
#'
#' @return Nothing, used for side-effects only
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' review_md_dir()
#'
#' # Can be paired with review_md_diff() for reviewing custom markdown
#' review_md_dir(
#'   md_dir = "my/adhoc/markdown",
#'   snaps_dir = "C:/Users/CYPHER/Downloads"
#' )
#'
#' review_md_diff(snaps_dir = "C:/Users/CYPHER/Downloads")
#' )}
review_md_dir <- function(md_dir = "inst/review/temp", snaps_dir = "inst/review/tests") {
  testthat::local_edition(3)

  md_files <- Sys.glob(file.path(md_dir, "*.md"))

  purrr::walk(
    md_files,
    \(x) {
      testthat::announce_snapshot_file(x)
    }
  )
  purrr::walk(
    md_files,
    \(x) {
      review_md(x, snaps_dir = snaps_dir)
    }
  )
  invisible()
}


#' Review changes to markdown files
#'
#' This is a customised combination of `testthat::snapshot_review` and the
#' unexported function `testthat:::review_app`. The purpose is to allow user to
#' see the changes made to markdown for the app, and then approve or reject
#' them. This is repeated, with changes to the markdown, until all changes are
#' accepted.
#'
#' @param snap_dir The name of the directory the snapshots are in
#' @param snaps_dir The path of the directory containing (or to create in) the
#'   _snaps directory
#'
#' @return Nothing, used for side-effects only
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' review_md_diff()
#'
#' # Can be paired with review_md_dir() for reviewing custom markdown
#' review_md_dir(
#'   md_dir = "my/adhoc/markdown",
#'   snaps_dir = "C:/Users/CYPHER/Downloads"
#' )
#'
#' review_md_diff(snaps_dir = "C:/Users/CYPHER/Downloads")
#' )}
review_md_diff <- function(snap_dir = "review_md/", snaps_dir = "inst/review/tests") {
  rlang::check_installed(c("shiny", "diffviewer"), "to use review_md_diff()")

  changed <- testthat:::snapshot_meta(snap_dir, snaps_dir)
  if (nrow(changed) == 0) {
    rlang::inform("No snapshots to update")
    return(invisible())
  }

  name <- changed$name
  old_path <- changed$cur
  new_path <- changed$new

  stopifnot(
    length(name) == length(old_path),
    length(old_path) == length(new_path)
  )

  n <- length(name)
  case_index <- stats::setNames(seq_along(name), name)
  handled <- rep(FALSE, n)

  ui <- shiny::fluidPage(
    style = "margin: 0.5em",
    shiny::fluidRow(
      style = "display: flex",
      shiny::div(
        style = "flex: 1 1",
        shiny::selectInput("cases", NULL, case_index, width = "100%")
      ),
      shiny::div(
        class = "btn-group", style = "margin-left: 1em; flex: 0 0 auto",
        shiny::actionButton("reject", "Reject", class = "btn-danger"),
        shiny::actionButton("skip", "Skip", class = "btn-warning"),
        shiny::actionButton("accept", "Accept", class = "btn-success")
      ),
      shiny::div(
        class = "btn-group", style = "margin-left: 1em; flex: 0 0 auto",
        shiny::actionButton("close", "Close", class = "btn-primary")
      )
    ),
    shiny::fluidRow(
      diffviewer::visual_diff_output("diff")
    )
  )
  server <- function(input, output, session) {
    i <- shiny::reactive(as.numeric(input$cases))
    output$diff <- diffviewer::visual_diff_render({
      diffviewer::visual_diff(old_path[[i()]], new_path[[i()]])
    })

    # Handle buttons - after clicking update move input$cases to next case,
    # and remove current case (for accept/reject). If no cases left, close app
    shiny::observeEvent(input$reject, {
      rlang::inform(paste0("Rejecting snapshot: '", new_path[[i()]], "'"))
      unlink(new_path[[i()]])
      update_cases()
    })
    shiny::observeEvent(input$accept, {
      rlang::inform(paste0("Accepting snapshot: '", old_path[[i()]], "'"))
      file.rename(new_path[[i()]], old_path[[i()]])
      update_cases()
    })
    shiny::observeEvent(input$skip, {
      i <- next_case()
      shiny::updateSelectInput(session, "cases", selected = i)
    })
    shiny::observeEvent(input$close, {
      rlang::inform("Review ended with changes still present")
      shiny::stopApp()
      return()
    })

    update_cases <- function() {
      handled[[i()]] <<- TRUE
      i <- next_case()

      shiny::updateSelectInput(
        session,
        "cases",
        choices = case_index[!handled],
        selected = i
      )
    }
    next_case <- function() {
      if (all(handled)) {
        rlang::inform("Review complete")
        shiny::stopApp()
        return()
      }

      # Find next case;
      remaining <- case_index[!handled]
      next_cases <- which(remaining > i())
      if (length(next_cases) == 0) remaining[[1]] else remaining[[next_cases[[1]]]]
    }
  }

  rlang::inform(c(
    "Starting Shiny app for snapshot review",
    i = "Use Ctrl + C to quit"
  ))
  shiny::runApp(
    shiny::shinyApp(ui, server),
    quiet = TRUE
  )

  invisible()
}


#' Move all markdown files from one directory to another
#'
#' Convenience function to quickly move all the reviewed new markdown files to
#' the app markdown folder.
#'
#' @param md_tmp_dir The path to the directory of reviewed markdown files
#' @param md_dir The path to the directory for markdown files used by app
#'
#' @return Nothing, used for side-effects only
#' @export
#'
#' @examples
#' \dontrun{
#' # For standard use case, default args are fine
#' update_md()
#'
#' # Unlikely needed, but can be used to move markdown files between any two folders
#' update_md(
#'   md_dir = "my/adhoc/markdown",
#'   snaps_dir = "my/final/markdown"
#' )}
update_md <- function(md_tmp_dir = "inst/review/temp",
                      md_dir = "inst/app/www/assets/markdown") {
  md_files <- Sys.glob(file.path(md_tmp_dir, "*.md"))
  file.rename(md_files, file.path(md_dir, basename(md_files)))

  invisible()
}
