FROM ubuntu:14.04

MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

# Modified from Jeroen Ooms' opencpu/base dockerfile

# Install.
RUN \
  apt-get update && \
  apt-get -y dist-upgrade && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:opencpu/opencpu-1.6 && \
  apt-get update && \
  apt-get install -y opencpu && \
  apt-get install python-software-properties -y && \ #BCO here and below
  apt-get install libcairo2-dev -y && \
  apt-get install libxt-dev -y && \
  apt-get install libprotobuf-dev -y && \
  apt-get install protobuf-compiler -y && \
  echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
  Rscript -e "install.packages('devtools')" && \
  Rscript -e "devtools::install_github('phylotastic/datelife')" && \
  Rscript -e "devtools::install_github('phylotastic/datelifeweb')"

ADD server.conf /etc/opencpu/server.conf #BCO


# Apache ports #from Ooms
EXPOSE 80
EXPOSE 443
EXPOSE 8004

# Define default command.
CMD service opencpu restart && tail -F /var/log/opencpu/apache_access.log
