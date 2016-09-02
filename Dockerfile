FROM rocker/shiny

MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN \
apt-get update && \
apt-get -y dist-upgrade && \
apt-get install -y software-properties-common && \
apt-get install -y libssl-dev  && \
apt-get install -y libxml2-dev && \
apt-get install -y libprotobuf-dev && \
echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
Rscript -e "install.packages('devtools')" && \
Rscript -e "install.packages('strap')" && \
Rscript -e "devtools::install_github('phylotastic/datelife')" && \
Rscript -e "devtools::install_github('phylotastic/datelifeweb')"
