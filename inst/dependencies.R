# Remotes ----
install.packages("remotes")
remotes::install_github('Thinkr-open/prenoms')
remotes::install_github('ColinFay/skeleton')
# Attachments ----
to_install <- c("dplyr", "DT", "dygraphs", "ggplot2", "glue", "magrittr", "plotly", "shiny", "shinyalert", "tidyr")
  for (i in to_install) {
    message(paste("looking for ", i))
    if (!requireNamespace(i)) {
      message(paste("     installing", i))
      install.packages(i)
    }

  }