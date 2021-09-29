# Get a shiny server

FROM rocker/shiny:4.1.0

# Specifying "latest" on version did not work (it kept loading a very old R version). I had to specify the R version using
# its number. E.g., rocker/shiny:latest -> rocker/shiny:4.1.0
# Guided by Shiny tutorials and https://github.com/flaviobarros/shiny-wordcloud/blob/master/Dockerfile
# Other resources https://www.statworx.com/at/blog/how-to-dockerize-shinyapps/

MAINTAINER Luna Sare <sanchez.reyes.luna@gmail.com>

# Install system libraries of general use

RUN apt-get update && apt-get -y dist-upgrade

RUN apt-get install -y apt-utils \
                       software-properties-common \
                       libssl-dev \
                       libxml2-dev \
                       lib32z1-dev \
                       libblas-dev \
                       liblapack-dev \
                       libprotobuf-dev \
                       protobuf-compiler \
                       php libapache2-mod-php php-cli \
                       git-core \
                       curl \
                       wget \
                       libmagick++-dev libmagickcore-dev libmagickwand-dev \
                       libssh2-1-dev

RUN R -e "R.Version()"

# git lfs, from https://github.com/git-lfs/git-lfs/wiki/Installation and debugging the libssh2-1-dev install first.
RUN apt install -y libssh-4 libssh-dev libssh2-1 libssh2-1-dev

RUN apt-get update && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*

# Install packages needed for your shiny app to run

RUN R -e "update.packages(ask=FALSE)"
RUN R -e "install.packages('rcmdcheck')"
RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('shinycssloaders')"
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('lubridate', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('magrittr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('glue', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DT', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('plotly', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('strap')"
RUN R -e "install.packages('jsonlite')"
RUN R -e "install.packages('rentrez', type='source')"
RUN R -e "install.packages(c('bold', 'rotl', 'knitcitations'), type='source')"
RUN R -e "install.packages('stringr')"
RUN R -e "install.packages('future')"
RUN R -e "install.packages('phangorn')"
RUN R -e "install.packages('latticeExtra')"
RUN R -e "install.packages('Hmisc')"
RUN R -e "devtools::install_github('fmichonneau/phylobase')"  # regular install.packages command not working with phylobase; tried type = "source" and did not work either
RUN R -e "devtools::install_github('fmichonneau/phyloch')"
RUN R -e "devtools::install_github('phylotastic/rphylotastic')"


# Installing datelife from GitHub
# RUN R -e "devtools::install_github('phylotastic/datelife')"

# Installing datelife locally from a development branch
RUN pwd && \
    git clone https://github.com/phylotastic/datelife.git  && \
    cd datelife && \
    pwd && \
    git checkout datelife-plots  && \
    R -e "devtools::install('.')"

# Installing PATHd8

RUN mkdir /usr/local/pathd8download && \
  wget http://www2.math.su.se/PATHd8/PATHd8.zip -O /usr/local/pathd8download/PATHd8.zip && \
  cd /usr/local/pathd8download && \
  unzip /usr/local/pathd8download/PATHd8.zip && \
  cc PATHd8.c -O3 -lm -o PATHd8 && \
  cp PATHd8 /usr/local/bin/PATHd8

# Installing mrBayes

RUN apt-get update && \
    apt-get install -y mrbayes


# Copying the datelifeweb shiny app to the docker image so it can be served

RUN \
  cd /srv && \
  rm -r /srv/shiny-server/* && \
  git clone https://github.com/phylotastic/datelifeweb.git && \
  mv /srv/datelifeweb/* /srv/shiny-server/

COPY shiny-server.conf /etc/init/shiny-server.conf

EXPOSE 80

CMD ["/usr/bin/shiny-server.sh"]
