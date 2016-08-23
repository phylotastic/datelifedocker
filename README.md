# datelifedocker
Dockerfile to set up DateLife server.

Go to datelifedocker directory

`sudo docker build --no-cache -t datelife .`

Once built, do

`docker run -p 80:80 -p 8004:8004 -p 443:443`

You'll get something like

```
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
OpenCPU Cloud Server Enabled.

  Hostname guess:
  http://160.36.155.225/ocpu
  https://160.36.155.225/ocpu
```

If you then go to: `http://160.36.155.225/ocpu/library/datelifeweb/www/` you'll open datelife's website.
