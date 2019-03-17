# datelifedocker

Instructions to set up DateLife server. Note that docker hub automatically rebuilds the bomeara/datelife image with pushes to phylotastic/datelifedocker, so this typically won't be needed, but can help with debugging.

Download datelifedocker.

Go to datelifedocker directory and write

`docker build -t datelife .`

To build with no cache

`docker build -t datelife --no-cache .`

Then start the server with

`docker run -t -i -p 80:3838 datelife`

After building, you can push to docker hub

`docker tag datelife bomeara/datelife`

`docker login`

`docker push bomeara/datelife`

and then other machines can download it as is to run:

`docker pull bomeara/datelife`

And run it as

`docker run -t -i -p 80:3838 bomeara/datelife`

Now, go to http://localhost on any browser to watch the server running

Doing

`docker run -t -i -p 80:3838 bomeara/datelife sh -c '/bin/bash'`

Will log you into the server so you can look around (i.e., in the /srv dir).

Once you've finished looking around, just type `exit` and you will be logged out.

You can run multiple instances using

`docker-compose up -d --scale datelife=10` for ten instances

## Swarm

Go to node where swarm is being managed. You can change the number of workers in replicas in docker-compose-swarm.yml

`sudo docker stack deploy --compose-file docker-compose-swarm.yml datelife`

See how it's doing with

`sudo docker stack services datelife`

And stop it with

`sudo docker stack rm datelife`

For domain, *, @, www all resolve to `datelife19.campus.utk.edu.` (yes, with a period after edu) using CNAME
