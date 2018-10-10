#' @importFrom shiny callModule

app_server <- function(input, output,session) {

  if ( app_prod() ){message("prod mode")}else{message("dev mode")}

  callModule(mod_popu, "mod_popuui")

  callModule(mod_naissance, "mod_naissanceui")

  callModule(mod_departement, "mod_departementui")

  callModule(mod_mod_top_anneeui, "mod_mod_top_anneeuiui")

  callModule(mod_table, "mod_tableui")
}
