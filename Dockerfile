FROM ubuntu:14.04

MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install python-software-properties -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:opencpu/opencpu-1.5 -y
RUN apt-get update -y
RUN apt-get install opencpu -y
RUN apt-get install opencpu-cache -y
RUN apt-get install opencpu-full -y
RUN service opencpu start
RUN service opencpu-cache start
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::install_github('phylotastic/datelife')"
RUN Rscript -e "devtools::install_github('phylotastic/datelifeweb')"
