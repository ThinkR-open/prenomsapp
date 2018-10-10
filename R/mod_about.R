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

mod_about <- function(input, output, session){
  ns <- session$ns
}
