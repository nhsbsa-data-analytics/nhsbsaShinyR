test_that("md_to_word generates expected Word doc", {
  throwaway <- withr::local_tempdir(pattern = "throwaway")
  
  md_dir <- file.path(throwaway, "markdown")
  dir.create(md_dir)
  
  md_lines <- c(
    "# H1  ",
    "## H2  ",
    "### H3  ",
    "#### H4  ",
    "__bold text__  ",
    "_italicized text_  ",
    "1. First item  ",
    "2. Second item  ",
    "3. Third item  ",
    "- First item  ",
    "- Second item  ",
    "- Third item  ",
    "Here is some inline ````code````.  ",
    "[Markdown Guide](https://www.markdownguide.org)  ",
    "[````{nhsbsaShinyR}````](https://github.com/nhsbsa-data-analytics/nhsbsaShinyR)  "
  )
  
  md_file1 <- writeLines(
    md_lines,
    file.path(md_dir, "01_md_file.md")
  )
  
  md_file2 <- writeLines(
    md_lines,
    file.path(md_dir, "02_md_file.md")
  )
  
  rv_dir <- file.path(throwaway, "review")
  
  docx_file <- "review.docx"
  
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
  
  docx_path <- file.path(rv_dir, docx_file)
  
  # Need to use same created/modified date each run, or output doc will not
  # match snapshot
  docx <- officer::read_docx(docx_path)
  
  props_file <- file.path(
    docx$package_dir,
    "docProps",
    "core.xml"
  ) 
  props_xml <- xml2::read_xml(props_file)
  props_xml <-  xml2::xml_find_all(
    props_xml,
    "//*[starts-with(name(), 'dcterms')]"
  )
  xml2::xml_text(props_xml) <- c("2023-11-07T16:07:06Z")
  
  xml2::write_xml(
    xml2::xml_root(props_xml),
    file.path(
      docx$package_dir,
      "docProps",
      "core.xml"
    )
  )
  
  tryCatch(
    expect_snapshot_file(docx_path),
    error = \(e) {
      cat("\n\n", waldo::compare(
        officer::read_docx("_snaps/utils-review/review.docx"),
        officer::read_docx("_snaps/utils-review/review.new.docx")
      ), sep = "\n")
    }
  )
})
