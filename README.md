# Welcome to DateLife's docker GitHub repository!

![Docker Pulls](https://img.shields.io/docker/pulls/bomeara/datelife?color=green)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bomeara/datelife)
![Docker Automated build](https://img.shields.io/docker/automated/bomeara/datelife?color=green)
[![NSF-1458603](https://img.shields.io/badge/NSF-1458603-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458603)
[![NSF-0905606](https://img.shields.io/badge/NSF-0905606-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=0905606)
[![NSF-1458572](https://img.shields.io/badge/NSF-1458572-white.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1458572)


## Setting up a DateLife server on a machine

### Using a prebuilt DateLife docker image

Ideally, docker hub automatically builds the DateLife docker image at [bomeara/datelife](https://hub.docker.com/r/bomeara/datelife/dockerfile) with pushes to the GitHub [phylotastic/datelifedocker repo](https://github.com/phylotastic/datelifedocker).

To get that prebuilt DateLife docker image you have to do a `docker pull`:

```shell
    docker pull bomeara/datelife
```

Now you can start the image using `docker run`, either in "bash mode" so you can look around (i.e., in the /srv dir):

```shell
    docker run -t -i -p 80:3838 bomeara/datelife sh -c '/bin/bash'
```

Or as a server with

```shell
    docker run -t -i -p 80:3838 datelife
```

Once you've finished looking around, just type `exit` and you will be logged out.

### Building your own DateLife docker image

This is very useful for debugging. If you tried setting up a prebuilt docker image and it fails, this is the way to go.

1. Install [docker-desktop](https://www.docker.com/products/docker-desktop)

2. Download datelifedocker to your computer. One way is to type from the terminal:

```shell
    git clone https://github.com/phylotastic/datelifedocker.git
```

3. `cd` to the datelifedocker directory and build the DateLife docker image with

```shell
    docker build -t datelife .
```

To build with no cache type `docker build -t datelife --no-cache .`

4. Now you can start the DateLife server from your newly created docker image with

```shell
    docker run -t -i -p 80:3838 datelife
```

Go to http://localhost on any browser to checkout your Datelife shiny app running.

To stop serving, type `Ctrl + c` or `exit`

5. To explore the contents of the DateLife docker image on terminal, first list all your docker containers with `docker container ls`, and get the name of your container.

Then

```shell

docker run -it datelife bash
docker container restart <container-name>

```

For more tips see [how-do-i-get-into-a-docker-containers-shell](https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell)

6. After building and making changes, you can push (if you have permissions) the new DateLife docker image to docker hub with:

```shell
    docker tag datelife bomeara/datelife
    docker login
    docker push bomeara/datelife
```

### Running multiple instances

You can run multiple shiny app instances with:

```shell
    docker-compose up -d --scale datelife=10 # for ten instances
```

### Swarm

Go to node where swarm is being managed. You can change the number of workers in replicas in docker-compose-swarm.yml

```shell
    sudo docker stack deploy --compose-file docker-compose-swarm.yml datelife
```

See how it's doing with

```shell
    sudo docker stack services datelife
```

And stop it with

```shell
    sudo docker stack rm datelife
```

For domain, *, @, www all resolve to `datelife19.campus.utk.edu.` (yes, with a period after edu) using CNAME

## Docker info

<details>
<summary>Docker version info. Obtained with <code>docker version</code> command.</summary>


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
