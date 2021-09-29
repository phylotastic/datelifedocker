# Welcome to DateLife's docker GitHub repository!

[![NSF-1458603](https://img.shields.io/badge/NSF-1458603-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458603)
[![NSF-0905606](https://img.shields.io/badge/NSF-0905606-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=0905606)
[![NSF-1458572](https://img.shields.io/badge/NSF-1458572-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458572)

Resources:

- https://www.statworx.com/at/blog/how-to-dockerize-shinyapps/
- https://www.youtube.com/watch?v=ARd5IldVFUs
- https://hub.docker.com/u/rocker
- https://juanitorduz.github.io/dockerize-a-shinyapp/
- https://bhoom.wordpress.com/2020/06/18/using-multiple-r-versions-with-docker-rocker-rstudio-project/
- https://githubmemory.com/repo/rocker-org/shiny/issues/92

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile


Next, you can find instructions to set up a DateLife server on your own computer.

Note: docker hub automatically rebuilds docker's [bomeara/datelife image](https://hub.docker.com/r/bomeara/datelife/dockerfile) with pushes to this GitHub's [phylotastic/datelifedocker repo](https://github.com/phylotastic/datelifedocker), so this typically won't be needed, but can help with debugging.

1. Install [docker-desktop](https://www.docker.com/products/docker-desktop)

2. Download datelifedocker to your computer. One way is to type from the terminal:

    git clone https://github.com/phylotastic/datelifedocker.git

3. `cd` to the datelifedocker directory and type

    docker build -t datelife .

To build with no cache type `docker build -t datelife --no-cache .`

4. Now you can start the server with

    docker run -t -i -p 80:3838 datelife`

And go to http://localhost on any browser to checkout your Datelife shiny app running

5. After building, you can push to docker hub

    docker tag datelife bomeara/datelife
    docker login
    docker push bomeara/datelife

and then other machines can download it _as is_ to serve DateLife!

    docker pull bomeara/datelife


**Note**: You can log into the server so you can look around (i.e., in the /srv dir).
Simply do:

    docker run -t -i -p 80:3838 bomeara/datelife sh -c '/bin/bash'

Once you've finished looking around, just type `exit` and you will be logged out.

**Tip**: You can run multiple shiny app instances with:

    docker-compose up -d --scale datelife=10 # for ten instances

## Swarm

Go to node where swarm is being managed. You can change the number of workers in replicas in docker-compose-swarm.yml

    sudo docker stack deploy --compose-file docker-compose-swarm.yml datelife

See how it's doing with

    sudo docker stack services datelife

And stop it with

    sudo docker stack rm datelife

For domain, *, @, www all resolve to `datelife19.campus.utk.edu.` (yes, with a period after edu) using CNAME
