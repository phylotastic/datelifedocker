FROM ubuntu:16.04

MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install python-software-properties -y
RUN apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:opencpu/opencpu-1.6 -y
RUN sudo apt-get update -y
RUN sudo apt-get install opencpu -y
RUN sudo apt-get install opencpu-cache -y
RUN sudo apt-get install opencpu-full -y
RUN sudo service opencpu start
RUN sudo service opencpu-cache start
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::install_github('phylotastic/datelife')"
RUN Rscript -e "devtools::install_github('phylotastic/datelifeweb')"
