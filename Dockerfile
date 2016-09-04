FROM rocker/shiny

# Guided by Shiny tutorials and https://github.com/flaviobarros/shiny-wordcloud/blob/master/Dockerfile


MAINTAINER Brian O'Meara <omeara.brian@gmail.com>

RUN \
apt-get update && \
apt-get -y dist-upgrade && \
apt-get install -y software-properties-common && \
apt-get install -y libssl-dev  && \
apt-get install -y libxml2-dev && \
apt-get install -y libprotobuf-dev && \
apt-get install -y protobuf-compiler && \
apt-get install -y php5-common libapache2-mod-php5 php5-cli && \
apt-get install -y wget && \
echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile && \
Rscript -e "install.packages('devtools')" && \
Rscript -e "install.packages('strap')" && \
Rscript -e "devtools::install_github('phylotastic/datelife')" && \
mkdir /usr/local/pathd8download && \
wget http://www2.math.su.se/PATHd8/PATHd8.zip -O /usr/local/pathd8download/PATHd8.zip && \
cd /usr/local/pathd8download && \
unzip /usr/local/pathd8download/PATHd8.zip && \
cc PATHd8.c -O3 -lm -o PATHd8 && \
cp PATHd8 /usr/local/bin/PATHd8 && \
wget https://github.com/phylotastic/datelifeweb/archive/master.zip -O /srv/shiny-server/master.zip && \
unzip /srv/shiny-server/master.zip -d /srv/shiny-server/ && \
mv /srv/shiny-server/datelifeshiny-master/* /srv/shiny-server/ && \
rm /srv/shiny-server/master.zip

EXPOSE 80

CMD ["/usr/bin/shiny-server.sh"]
