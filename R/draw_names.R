#' @importFrom dplyr group_by summarise filter
#' @importFrom tidyr spread
#' @importFrom dygraphs dygraph

draw_names <- function(names){
  prenoms::prenoms %>%
    group_by(year,name) %>%
    summarise(total = sum(n))    %>%
    filter(name %in% names) %>%
    spread(key = name,value =total)

}
