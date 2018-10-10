#' run the Shiny Application
#'
#'
#' @export
#' @importFrom shiny shinyApp
#' @import promises
#' @import future
#'
#' @examples
#'
#' if (interactive()) {
#'
#'   run_app()
#'
#' }
#'
run_app <- function() {
  plan(multiprocess)
  shinyApp(ui = app_ui(), server = app_server)
}
