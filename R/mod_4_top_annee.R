#' @importFrom plotly plotlyOutput
#' @importFrom shiny NS tagList h3 includeScript selectInput tagAppendAttributes checkboxInput tags
mod_mod_top_anneeuiui <- function(id) {
  ns <- NS(id)
  tagList(
    tagList(
      sk_col(
        ns("Choix"),
        width = 3,
        h3("Select a year"),
        includeScript(system.file("www/sic.js", package = "prenomsapp")),
        selectInput(ns("choix"), "Year:", choices = 1900:2017, selected = 1900),
        # browser(),
        tagAppendAttributes(checkboxInput(ns("dep"), "Filter by department?", FALSE),
          onclick = glue('showIfChecked("{ns("dep")}", "#{ns("depchoicediv")}")')
        ),
        tags$div(
          id = ns("depchoicediv"),
          selectInput(ns("depchoice"), "Department", choices = prenoms::departements$code_insee)
        ),
        tagAppendAttributes(checkboxInput(ns("sexe"), "Filter by sex?", FALSE),
          onclick = glue('showIfChecked("{ns("sexe")}", "#{ns("sexchoicediv")}")')
        ),
        tags$div(
          id = ns("sexchoicediv"),
          selectInput(ns("sexchoice"), "Sex", choices = c("M", "F"))
        ),
        tags$script(glue("$('#{ns('depchoicediv')}').hide();")),
        tags$script(glue("$('#{ns('sexchoicediv')}').hide();"))
      ),
      sk_col(
        ns("Output"),
        width = 9,
        plotlyOutput(ns("dynaissance"))
      )
    )
  )
}

#' @importFrom dplyr filter group_by summarise top_n arrange mutate
#' @importFrom ggplot2 ggplot aes geom_col coord_flip labs theme_minimal
#' @importFrom plotly ggplotly renderPlotly
mod_mod_top_anneeui <- function(input, output, session) {
  ns <- session$ns

  output$dynaissance <- renderPlotly({
    f <- prenoms::prenoms %>%
      filter(year == input$choix)
    if (input$dep) {
      f <- f %>%
        filter(dpt == input$depchoice)
    }
    if (input$sexe) {
      f <- f %>%
        filter(sex == input$sexchoice)
    }

    res <- f %>%
      group_by(year, name) %>%
      summarise(total = sum(n)) %>%
      top_n(10, total) %>%
      arrange(desc(total)) %>%
      mutate(name = reorder(name, total)) %>%
      ggplot(aes(name, total)) +
      geom_col(fill = "#4ba5a5") +
      coord_flip() +
      labs(x = "Nom") +
      theme_minimal()
    ggplotly(res)
  })
}
