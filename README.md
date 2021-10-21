# Welcome to DateLife's docker GitHub repository!

![Docker Pulls](https://img.shields.io/docker/pulls/lunasare/datelife?color=green)
<!--![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bomeara/datelife)-->
![Docker Automated build](https://img.shields.io/docker/automated/lunasare/datelife?color=green)
[![NSF-1458603](https://img.shields.io/badge/NSF-1458603-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458603)
[![NSF-0905606](https://img.shields.io/badge/NSF-0905606-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=0905606)
[![NSF-1458572](https://img.shields.io/badge/NSF-1458572-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458572)

`datelife` is a software that gets all available information on time of divergence of a group of lineages, and uses this information to date a phylogenetic tree.
`datelife` functionalities can be accessed via its [R package](https://github.com/phylotastic/datelife), or through its [website application]().
`datelife`'s webiste app [is constructed with R shiny](https://github.com/phylotastic/datelifeweb) and is containerized with [Docker](https://www.docker.com/?utm_source=google&utm_medium=cpc&utm_campaign=dockerhomepage&utm_content=namer&utm_term=dockerhomepage&utm_budget=growth&gclid=CjwKCAjw7--KBhAMEiwAxfpkWMXM6XbTANoSspqojqsXX7dBeTm13Yc7lwzn8kz7iAWAT_m0fEo9MRoCq9MQAvD_BwE), i.e. "dockerized", as [explained here](https://www.r-bloggers.com/2021/05/dockerizing-shiny-applications/). This repository hosts the instructions for  "dockerizing" `datelife`, which we whipped up by following diverse [valuable resources](#resources). The `datelife` docker allows anyone to set up their own server for the `datelife` webb app anywhere.
There are a few alternative ways to do this. For all of them you require [Docker Desktop installed](https://www.docker.com/products/docker-desktop). Next you can find instructions on:

[1. Setting up a prebuilt `datelife` image](#1-using-a-prebuilt-datelife-docker-image)

[2. Building a local `datelife` image on your own](#2-building-your-own-datelife-docker-image)

[3. Running multiple instances of the `datelife` shiny app](#3-running-multiple-instances)

[4. Using swarm](#4-swarm)
<br><br>

## 1. Using a prebuilt DateLife docker image

Ideally, the `datelife` docker image automatically builds and uploads to [bomeara/datelife's Docker Hub (the docker cloud)](https://hub.docker.com/r/bomeara/datelife/dockerfile) with pushes to [this repository (the GitHub phylotastic/datelifedocker repo)](https://github.com/phylotastic/datelifedocker). Automatic docker builds are not working for the moment (last updated Oct 5 2021), so the latest, locally built, manually uploaded `datelife` docker image is found at [lunasare/datelife's Docker Hub](https://hub.docker.com/repository/docker/lunasare/datelife).

<!-- Look at this for list styling: https://gist.github.com/bertobox/3503850#gistcomment-1213320 -->

<ul style="list-style-type:none;">
  <li> 1.1. To download the prebuilt <code>datelife</code> docker image from Docker Hub you need <a href="https://www.docker.com/products/docker-desktop">Docker desktop installed</a>. Then, from terminal use the <code>docker pull</code> command:
  </li><br>

```shell
    # docker pull bomeara/datelife
    docker pull lunasare/datelife
```

  <li> 1.2. Now, you can start the image using <code>docker run</code>. You can do this in "bash mode" so you can look around (i.e., in the /srv dir for the shiny app):
  </li><br>

```shell
    # docker run -t -i -p 80:3838 bomeara/datelife sh -c '/bin/bash'
    docker run -t -i -p 80:3838 lunasare/datelife sh -c '/bin/bash'
```

Once you've finished looking around, just type `exit` and you will be logged out.

  <li> 1.3. To start the image just in serve mode, do:
  </li><br>

```shell
    # docker run -t -i -d -p 80:3838 bomeara/datelife
    docker run -t -i -d -p 80:3838 lunasare/datelife
```

Go to http://localhost on any browser to checkout your Datelife website and shiny app running.

Argument `-d` is optional, it stands for `--detach`, allowing you to keep on using your terminal while the DateLife website is being served.

</ul>

## 2. Building your own DateLife docker image

This is very useful for debugging. If you tried setting up a prebuilt docker image and it fails, this is the way to go.

<ul style="list-style-type:none;">
  <li> 2.1. Make sure you have <a href="https://www.docker.com/products/docker-desktop">Docker desktop installed</a>. Then, download the <a href="https://github.com/phylotastic/datelifedocker">datelifedocker repository</a> to your computer. One way is to type from the terminal:
  </li><br>

```shell
    git clone https://github.com/phylotastic/datelifedocker.git
```

  <li> 2.2. Change directories to your newly created datelifedocker directory using <code>cd</code>, and build the DateLife docker image with:
  </li><br>

```shell
    docker build -t datelife .
```

To build with no cache type `docker build -t datelife --no-cache .`

  <li> 2.3 Now you can start the DateLife server from your newly created docker image with:
  </li><br>

```shell
    docker run -t -i -p 80:3838 datelife
```

Go to http://localhost on any browser to checkout your Datelife shiny app running.

To stop serving, type `Ctrl + c` or `exit`

  <li> 2.4. To explore the contents of the DateLife docker image on terminal, you can do:
  </li><br>

```shell
docker run -t -i datelife sh -c '/bin/bash'
```

If you want to explore a particular container, first list them all with `docker container ls`, and identify the `container-name` of the one you are interested in.

Then restart your container and execute it with:

```shell
docker container restart <container-name>
docker exec -it <container-name> sh -c '/bin/bash'
```

For more tips see [how-do-i-get-into-a-docker-containers-shell](https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell)
and [15-docker-commands-you-should-know](https://towardsdatascience.com/15-docker-commands-you-should-know-970ea5203421).

  <li> 2.5. After building and making changes, you can push (if you have permissions) the new <code>datelife</code> docker image to docker hub with:
  </li><br>

```shell
    # docker tag datelife bomeara/datelife
    docker tag datelife lunasare/datelife
    docker login
    # docker push bomeara/datelife
    docker push lunasare/datelife
```
</ul>

## 3. Running multiple instances

You can run multiple shiny app instances with:

```shell
    docker-compose up -d --scale datelife=10 # for ten instances
```

## 4. Swarm

<ul style="list-style-type:none;">
  <li> 4.1. Go to node where swarm is being managed. You can change the number of workers in replicas in the <code>docker-compose-swarm.yml</code> file.
  </li><br>

```shell
    sudo docker stack deploy --compose-file docker-compose-swarm.yml datelife
```

  <li> 4.2. See how it's doing with
  </li><br>

```shell
    sudo docker stack services datelife
```

  <li> 4.3. And stop it with
  </li><br>

```shell
    sudo docker stack rm datelife
```

For domain, *, @, www all resolve to `datelife19.campus.utk.edu.` (yes, with a period after edu) using CNAME

</ul>

## Resources

- https://www.r-bloggers.com/2021/05/dockerizing-shiny-applications/
- https://github.com/flaviobarros/shiny-wordcloud/blob/master/Dockerfile
- https://www.statworx.com/at/blog/how-to-dockerize-shinyapps/
- https://www.youtube.com/watch?v=ARd5IldVFUs
- https://hub.docker.com/u/rocker
- https://www.dabbleofdevops.com/blog/deploy-rshiny-with-the-rocker-shiny-docker-image
- https://blog.sellorm.com/2021/04/25/shiny-app-in-docker/
- https://juanitorduz.github.io/dockerize-a-shinyapp/
- https://bhoom.wordpress.com/2020/06/18/using-multiple-r-versions-with-docker-rocker-rstudio-project/
- https://githubmemory.com/repo/rocker-org/shiny/issues/92
- https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell


## Docker software info

<details>
<summary>Docker software version info for locally built <code>datelife</code> image.
<br> Obtained with <code>docker version</code> command.</summary>


```shell
Client: Docker Engine - Community
 Cloud integration: 1.0.7
 Version:           20.10.2
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        2291f61
 Built:             Mon Dec 28 16:12:42 2020
 OS/Arch:           darwin/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.2
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       8891c58
  Built:            Mon Dec 28 16:15:28 2020
  OS/Arch:          linux/amd64
  Experimental:     true
 containerd:
  Version:          1.4.3
  GitCommit:        269548fa27e0089a8b8278fc4fc781d7f65a939b
 runc:
  Version:          1.0.0-rc92
  GitCommit:        ff819c7e9184c13b7c2607fe6c30ae19403a7aff
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

</details>
