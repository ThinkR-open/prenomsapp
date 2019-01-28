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
      # selectInput(ns("choix"), "Name",
      #           selected = "Colin",choices = unique(prenoms::prenoms$name)),
      textInput(ns("choix"), "Name",
                value = "Colin"),


      tagAppendAttributes(checkboxInput(ns("dep"), "Filter by department?", FALSE),
                          onclick = glue('showIfChecked("{ns("dep")}", "#{ns("depchoicediv")}")')
      ),
      tags$div(
        id = ns("depchoicediv"),
        selectInput(ns("depchoice"), "Department", choices = prenoms::departements$code_insee)
      ),
      actionButton(ns("go"), "Render"),
      tags$script(glue("$('#{ns('depchoicediv')}').hide();"))
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
    if (capwords(input$choix) %in% prenomsapp::prenoms_uniques){
      choice$prenom <- capwords(input$choix)

    } else {
      shinyalert("Name not found",
                 "Sorry, this name is not in the database...", type = "error")
    }
  })

  base_prenom <- reactive({
    prenoms::prenoms %>%
      filter(name ==  capwords(choice$prenom))
    })

  output$dy <- renderDygraph({
    f <- base_prenom()

    if ( input$dep){
      f <- f %>% filter( dpt == input$depchoice)
      }
    validate(need(nrow(f) != 0,"No data for this department"))
    f %>%
        group_by(year,name) %>%
        summarise(total = sum(n))%>%
        spread(key = name,value =total) %>%
        dygraph()



  })

}
