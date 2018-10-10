mod_naissanceui <- function(id){
  ns <- NS(id)
  tagList(
    sk_col(
      ns("Choix"), width = 3,
      h3("Choose a daterange"),
      sliderInput(ns("choix"), "Dates:", value = c(1900, 2016), min = 1900, max = 2016),
      checkboxInput(ns("sexe"), "Group by sex?", FALSE)
    ),
    sk_col(
      ns("Output"), width = 9,
      dygraphOutput(ns("dynaissance"))
    )
    )
  }

mod_naissance <- function(input, output, session){
  ns <- session$ns

  output$dynaissance <- renderDygraph({
    f <- prenoms::prenoms %>%
      filter(year >=  input$choix[1], year <= input$choix[2])
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
