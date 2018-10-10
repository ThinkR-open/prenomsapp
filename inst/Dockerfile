FROM rocker/tidyverse 
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("ThinkR-open/prenomsapp")'
EXPOSE 2811
COPY Rprofile.site /usr/local/lib/R/etc
CMD R -e 'prenomsapp::run_app()'
