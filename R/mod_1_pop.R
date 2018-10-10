#' @importFrom dygraphs dygraphOutput renderDygraph
#' @importFrom shiny h3 tagList NS textInput actionButton
#' @importFrom shinyalert useShinyalert
#' @importFrom skeleton sk_col
mod_popuui <- function(id){
  ns <- NS(id)
  tagList(
    useShinyalert(),
    sk_col(
      ns("one_col"),
      width = 3,
      h3("Select a name"),
      textInput(ns("choix"), "Name",
                value = "Colin"),
      actionButton(ns("go"), "Render")
    ),
    sk_col(
      ns("one_col"),
      width = 9,
      dygraphOutput(ns("dy"))
    )
    )
}

#' @importFrom dplyr group_by summarise filter
#' @importFrom tidyr spread
#' @importFrom dygraphs dygraph renderDygraph
#' @importFrom shiny reactiveValues observeEvent
#' @importFrom shinyalert shinyalert

mod_popu <- function(input, output, session){

  ns <- session$ns
  choice <- reactiveValues(prenom = "Colin")
  observeEvent(input$go, {
    if (input$choix %in% prenomsapp::prenoms_uniques){
      choice$prenom <- input$choix
    } else {
      shinyalert("Name not found",
                 "Sorry, this name is not in the database :/", type = "error")
    }
  })

  output$dy <- renderDygraph({

    prenoms::prenoms %>%
        filter(name ==  choice$prenom) %>%
        group_by(year,name) %>%
        summarise(total = sum(n))%>%
        spread(key = name,value =total) %>%
        dygraph()
  })

}
