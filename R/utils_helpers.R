# This interpolates the values into the markdown
#
# NOTE: the placeholders as written in the markdown are £> and <£
# When glue gets these it will be in HTML form, thus why different in this function
include_dynamic_md <- function(md_path) {
  HTML(
    glue::glue(
      shiny::includeMarkdown(md_path),
      .open = "\u00A3&gt;",
      .close = "&lt;\u00A3"
    )
  )
}
