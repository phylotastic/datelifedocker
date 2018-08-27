FROM rocker/shiny

# Guided by Shiny tutorials and https://github.com/flaviobarros/shiny-wordcloud/blob/master/Dockerfile


MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN \
apt-get update && \
apt-get -y dist-upgrade && \
apt-get install -y apt-utils

RUN \
apt-get install -y r-api-3.5 && \
apt-get install -y software-properties-common && \
apt-get install -y libssl-dev  && \
apt-get install -y libxml2-dev && \
apt-get install -y lib32z1-dev && \
apt-get install -y libblas-dev && \
apt-get install -y liblapack-dev && \
apt-get install -y libprotobuf-dev && \
apt-get install -y protobuf-compiler && \
apt-get install -y php libapache2-mod-php php-cli && \
apt-get install -y git-core && \
apt-get install -y wget

RUN apt-get install -y libssh2-1-dev

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile

RUN Rscript -e "install.packages(rownames(installed.packages()))"

RUN Rscript -e "update.packages(ask=FALSE)"

RUN Rscript -e "install.packages('digest', type='source')"

RUN Rscript -e "install.packages('memoise', type='source')"


RUN Rscript -e "install.packages('devtools')"

RUN Rscript -e "install.packages('shinycssloaders')"

RUN Rscript -e "install.packages('strap')"
RUN Rscript -e "install.packages('jsonlite')"
# RUN Rscript -e "devtools::install_github('fmichonneau/phylobase')"  # regular install.packages command not working with phylobase; tried type = "source" and did not work either
RUN Rscript -e "install.packages('rentrez', type='source')"
RUN Rscript -e "install.packages(c('bold', 'rotl', 'knitcitations'), type='source')"
RUN Rscript -e "devtools::install_github('fmichonneau/phyloch')"


RUN mkdir /usr/local/pathd8download && \
wget http://www2.math.su.se/PATHd8/PATHd8.zip -O /usr/local/pathd8download/PATHd8.zip && \
cd /usr/local/pathd8download && \
unzip /usr/local/pathd8download/PATHd8.zip && \
cc PATHd8.c -O3 -lm -o PATHd8 && \
cp PATHd8 /usr/local/bin/PATHd8

RUN apt-get install -y mrbayes

RUN Rscript -e "devtools::install_github('phylotastic/rphylotastic')"

RUN Rscript -e "install.packages('bayou')"

RUN Rscript -e "devtools::install_github('phylotastic/datelife')"


RUN \
cd /srv && \
rm -r /srv/shiny-server/* && \
git clone https://github.com/phylotastic/datelifeweb.git && \
mv /srv/datelifeweb/* /srv/shiny-server/

COPY shiny-server.conf /etc/init/shiny-server.conf

EXPOSE 80

CMD ["/usr/bin/shiny-server.sh"]
