
#' @importFrom shiny includeCSS tags
#' @importFrom skeleton sk_page sk_header sk_nav sk_nav_item sk_row
#' @importFrom glue glue
app_ui <- function() {
  sk_page(
    includeCSS(system.file("www/loader.css", package = "prenomsapp")),
    tags$style(".header { margin-top: 4em; }"),
    # Header
    sk_header(title = "Baby names in France - 1900:2016"),
    sk_nav(
      sk_nav_item("one", "Popularity over time"),
      sk_nav_item("two", "Birth"),
      sk_nav_item("three", "By department"),
      sk_nav_item("four", "Top Name"),
      sk_nav_item("about", "About")
    ),
    sk_row(
      "one",
      mod_popuui("mod_popuui")
      ),
    sk_row(
      "two",
      mod_naissanceui("mod_naissanceui")
    ),
    sk_row(
      "three",
      mod_departementui("mod_departementui")
    ),
    sk_row(
      "four",
      mod_mod_top_anneeuiui("mod_mod_top_anneeuiui")
    ),
    sk_row(
      "about",
      mod_aboutui("mod_aboutui")
    )
  )
}
