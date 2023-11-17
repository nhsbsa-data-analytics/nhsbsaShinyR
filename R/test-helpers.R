local_create_md <- function(temp_dir = tempdir(), env = parent.frame()) {
  md_dir <- file.path(temp_dir, "markdown")
  dir.create(md_dir, showWarnings = FALSE)
  withr::defer(unlink(temp_dir), envir = env)
  
  md_lines <- c(
    "# H1",
    "## H2",
    "### H3",
    "#### H4",
    "__bold text__",
    "",
    "_italicized text_",
    "",
    "Numbered list",
    "",
    "1. First item",
    "2. Second item",
    "3. Third item",
    "",
    "Bulleted list",
    "",
    "- First item",
    "- Second item",
    "- Third item",
    "",
    "Here is some inline ````code````.",
    "",
    "[Markdown Guide](https://www.markdownguide.org)",
    "",
    "[````{nhsbsaShinyR}````](https://github.com/nhsbsa-data-analytics/nhsbsaShinyR)"
  )
  
  writeLines(
    md_lines,
    file.path(md_dir, "01_md_file.md")
  )
  
  writeLines(
    md_lines,
    file.path(md_dir, "02_md_file.md")
  )
  
  md_dir
}


local_create_word_doc <- function(temp_dir = tempdir(), md_dir, rv_dir, docx_file,
                                  env = parent.frame()) {
  withr::defer(unlink(temp_dir), envir = env)
  
  styles_rmd <- system.file(
    "review", "styles", "draft-styles.rmd",
    package = "nhsbsaShinyR"
  )
  
  docx_path <- md_to_word(
    md_dir = md_dir,
    rv_dir = rv_dir,
    docx_file = docx_file,
    styles_rmd = styles_rmd
  )
  
  docx_path
}
