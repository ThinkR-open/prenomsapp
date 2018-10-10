#' @importFrom shiny includeMarkdown tagList
#' @importFrom skeleton sk_col
mod_aboutui <- function(id){
  ns <- NS(id)
  tagList(
    sk_col(
      ns("About"), width = 6,
      includeMarkdown(
        system.file("www/about.md", package = "prenomsapp")
      )
      ),
    sk_col(
      ns("Links"), width = 6,
      includeMarkdown(
        system.file("www/links.md", package = "prenomsapp")
      )
      )
    )
}
