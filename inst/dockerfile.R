library(dockerfiler)
dck <- Dockerfile$new()
dck$RUN(r("install.packages('remotes')"))
dck$RUN(r("remotes::install.github('ThinkR-open/prenomsapp')"))
