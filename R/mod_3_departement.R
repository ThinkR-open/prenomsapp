#' @importFrom dygraphs dygraphOutput
#' @importFrom shiny tagList NS selectInput sliderInput checkboxInput
#' @importFrom shinyalert useShinyalert
#' @importFrom skeleton sk_col
#' @importFrom shiny NS tagList h3 selectInput sliderInput checkboxInput
mod_departementui <- function(id){
  ns <- NS(id)
    tagList(
      sk_col(
        ns("Choix"), width = 3,
        h3("Choose a department"),
        selectInput(ns("dep"), "Department", choices = prenoms::departements$code_insee),
        sliderInput(ns("choix"), "Dates :", value = c(1900, 2016), min = 1900, max = 2016),
        checkboxInput(ns("sexe"), "Group by sex?", FALSE)
      ),
      sk_col(
        ns("Output"), width = 9,
        dygraphOutput(ns("dy"))
      )
    )
  }

#' @importFrom dplyr summarise filter
#' @importFrom tidyr spread
#' @importFrom dygraphs renderDygraph dygraph
#' @importFrom dplyr filter group_by summarise
mod_departement <- function(input, output, session){
  ns <- session$ns

  output$dy <- renderDygraph({
    f <- prenoms::prenoms %>%
      filter(year >=  input$choix[1], year <= input$choix[2]) %>%
      filter(dpt == input$dep)
    if (input$sexe){
      f %>% group_by(year, sex) %>%
        summarise(total = sum(n)) %>%
        spread(key = sex, value =total) %>%
        dygraph()
    } else {
      f %>% group_by(year) %>%
        summarise(total = sum(n)) %>%
        dygraph()
    }

  })

}
