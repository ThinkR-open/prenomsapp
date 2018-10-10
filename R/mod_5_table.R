#' @importFrom DT DTOutput
#' @importFrom shiny NS tagList h3 includeScript selectInput tagAppendAttributes checkboxInput tags

mod_tableui <- function(id){
  ns <- NS(id)
  tagList(
    sk_col(
      ns("Choix"),
      width = 3,
      h3("Select a Name"),
      includeScript(system.file("www/sic.js", package = "prenomsapp")),
      textInput(ns("choix"), "Name:", value = "Colin"),
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
      DTOutput(ns("dynaissance"))
    )
    )
}

#' @importFrom DT renderDT datatable
#' @importFrom dplyr filter group_by arrange

mod_table <- function(input, output, session){
  ns <- session$ns
  output$dynaissance <- renderDT({
    f <- prenoms::prenoms %>%
      filter(name == input$choix)
    if (input$dep) {
      f <- f %>%
        filter(dpt == input$depchoice)
    }
    if (input$sexe) {
      f <- f %>%
        filter(sex == input$sexchoice)
    }

    f %>%
      group_by(year, name) %>%
      summarise(total = sum(n)) %>%
      arrange(year) %>%
      DT::datatable()
  })
}

