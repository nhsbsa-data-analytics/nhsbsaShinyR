test_that("md_to_word generates expected Word doc", {
  docx_file <- "review.docx"
  md_dir <- local_create_md()
  rv_dir <- gsub("markdown", "review", md_dir)
  docx_path <- local_create_word_doc(
    md_dir = md_dir,
    rv_dir = rv_dir,
    docx_file = docx_file
  )

  # When run for first time, just save the generated Word doc for future use
  # Note the test will essentially be comparing this doc to itself on that first
  # run!
  if (!file.exists(docx_file)) file.copy(docx_path, docx_file)

  # Get docx objects for comparisons
  old <- officer::read_docx(docx_file)
  new <- officer::read_docx(docx_path)

  comp_structure <- waldo::compare(new, old)

  # Due to how officer::read_docx works, we expect there to always be
  # differences in the package_dir and doc_properties$data.
  # Also, when run on github CI, there are small differences in some of the
  # colours used in the Word doc styles.
  expected_differences <- ifelse(testthat:::on_ci(), 8, 2)

  # If unexpected number of diffs, print out the comparison for ease of seeing
  # where the fail is.
  if (length(comp_structure) > expected_differences) {
    cat("\n\n", comp_structure, sep = "\n")
  }

  expect_lte(length(comp_structure), expected_differences)

  # Since read_docx only has pointers to the actual text content, also need to
  # compare the content separately.
  expect_equal(officer::docx_summary(new), officer::docx_summary(old))
})


test_that("word_to_md generates expected markdown files", {
  docx_file <- "review.docx"
  md_dir <- local_create_md()
  rv_dir <- gsub("markdown", "review", md_dir)
  docx_path <- local_create_word_doc(
    md_dir = md_dir,
    rv_dir = rv_dir,
    docx_file = docx_file
  )

  word_to_md(
    rv_dir = rv_dir,
    docx_file = docx_file,
    md_out_dir = md_dir
  )

  expect_snapshot_file(file.path(md_dir, "01_md_file.md"))
  expect_snapshot_file(file.path(md_dir, "02_md_file.md"))
})


test_that("style_map generates expected maps", {
  docx_file <- "review.docx"
  md_dir <- local_create_md()
  rv_dir <- gsub("markdown", "review", md_dir)
  docx_path <- local_create_word_doc(
    md_dir = md_dir,
    rv_dir = rv_dir,
    docx_file = docx_file
  )
  doc <- officer::read_docx(docx_path)

  style_maps <- list(
    bold_map = style_map(doc, "r", "rPr", "b"),
    ital_map = style_map(doc, "r", "rPr", "i"),
    hypl_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "Hyperlink"),
    code_map = style_map(doc, "r", "rPr", "rStyle", "VerbatimChar"),
    chyp_map = style_map(doc, "hyperlink", "r", "rPr", NULL, "rStyle", "VerbatimChar")
  )

  expect_snapshot(style_maps)
})
