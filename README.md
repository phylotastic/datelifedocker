# datelifedocker
Dockerfile to set up DateLife server.

Go to datelifedocker directory

`sudo docker build --no-cache -t datelife .`

Then start

`docker run -t -i -p 80:3838 datelife`



And go to http://localhost

Doing


`docker run -t -i -p 80:38383 datelife sh -c '/bin/bash'`

Will let you log into the server so you can look around (i.e., in the /srv dir).
