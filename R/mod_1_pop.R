#' @importFrom dygraphs dygraphOutput renderDygraph
mod_popuui <- function(id){
  ns <- NS(id)
  tagList(
    shinyalert::useShinyalert(),
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
#' @importFrom dygraphs dygraph

mod_popu <- function(input, output, session){

  ns <- session$ns
  choice <- reactiveValues(prenom = "Colin")
  observeEvent(input$go, {
    if (input$choix %in% prenomsapp::prenoms_uniques){
      choice$prenom <- input$choix
    } else {
      shinyalert::shinyalert("Prénom introuvable", "Désolé, le prénom n'est pas dans la base.", type = "error")
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
