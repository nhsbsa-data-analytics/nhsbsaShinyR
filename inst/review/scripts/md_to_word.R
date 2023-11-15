library(rmarkdown)
library(officedown)
library(purrr)

# Setup -------------------------------------------------------------------

md_dir     <- "inst/app/www/assets/markdown"     # Markdown dir
rv_dir     <- "review"                           # Review directory
rmd_file   <- "all_md.rmd"                       # Output rmarkdown
docx_file  <- "review.docx"                      # Output Word doc
styles_dir <- "review/styles"                    # Styles dir
styles_rmd <- "draft-styles.rmd"                 # Creates Word template
styles_doc <- "draft-styles.docx"                # Word template

render(
  file.path(styles_dir, styles_rmd),
  output_dir = styles_dir,
  output_file = styles_doc,
  quiet = TRUE
)


# Create rmarkdown --------------------------------------------------------

# Get relative path of md files
md_files <- Sys.glob(file.path(md_dir, "*.md"))

# Combine them into one rmarkdown file
all_md <- map(md_files, readLines) # List of md content
all_md <- map2(all_md, md_files, \(x, y) c(y, "", x, "")) # Add marker to md file
all_md <- reduce(all_md, c)                               # All content in one vector

writeLines(all_md, file.path(rv_dir, rmd_file))


# Create Word document ----------------------------------------------------

render(
  file.path(rv_dir, rmd_file),
  rdocx_document(
    reference_docx = file.path(styles_dir, styles_doc),
    toc = FALSE,
    number_sections = FALSE
  ),
  output_dir = rv_dir,
  output_file = docx_file,
  quiet = TRUE
)


# Tidy up -----------------------------------------------------------------

unlink(file.path(styles_dir, styles_doc)) # Delete style doc
unlink(file.path(rv_dir, rmd_file))       # Delete combined rmd
