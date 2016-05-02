# Nginx Proxy Plone

This container runs a nginx:stable-apline image with a reverse proxy to a Plone
or Varnish container.

## Features

- Handles robots.txt for all extra domains to block crawlers.
- Redirect www.domain.com to domain.com 
- Redirect attempts to login to the cms. environment.
- Rewrites the URL to VirtualHostMonster format.
- Reverse proxies requests to http://BACKEND:BACKEND_PORT/VirtualHostbase... 

## Usage

This container expects that a named Plone instance is already running.

### Start a single Nginx server

This will download and start the latest nginx-proxy container, based on
[Alpine](http://www.alpinelinux.org/).

```console
$ docker run -p 80:80 -e DOMAIN_NAME=mydomain.com \
                      -e BACKEND=plone-container-name \
                      -e BACKEND_PORT="8080" \
                      docker1.zestsoftware.nl/zestadmin/zest-nginx
```

This image includes `EXPOSE 80` (the default HTTP port). When DNS is setup to
point DOMAIN_NAME to the docker machine IP, you can view your Plone Site at
http://DOMAIN_NAME:80

### Setup in Rancher

In Rancher you can define a stack with a Plone service and then trust on
service name resolution by using the service name in the BACKEND variable.
e.g. with a service named plone-instance, define a environment variable
BACKEND=plone-instance.

For basic hosting use can run this image as is. More advanced setups require
building your own image to extend this one.


## Building you own image

If you need SSL or a more advanced nginx configuration, like a list of
redirects, you should build your own image.

In this image we setup some server defaults for proxying, request size, security
headers, etc which are found in `defaults.conf`

Our server config is stored in `nginx.conf` and replaces the
`/etc/nginx/conf.d/default.conf` of the official `nginx` image.

The configuration based on environment variables is done in the entrypoint.
In docker-entrypoint.sh you note a simple sed of all variables.

To support dynamic configuration by Rancher or other orchestration tool when
creating new containers you should preserve the BACKEND variable.


- Create a Dockerfile:

  ```FROM docker1.zestsoftware:5000/zestadmin/zest-nginx:latest
  COPY nginx.conf /etc/nginx/conf.d/default.conf
  COPY redirects.conf /etc/nginx/redirects.conf
  ```

- Create your custom redirects.conf and nginx.conf by copying them from this
  image.

- Build your own image:

  ```docker build -t zest-nginx-DOMAIN_NAME .```

Now you can run your own image or push it to a registry.


## TODO

- SSL configuration
