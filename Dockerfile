FROM nginx:stable-alpine
MAINTAINER Jean-Paul Ladage <j.ladage@zestsoftware.nl>

# We reuse the nginx-proxy container and configure each site
# separately. Within docker each container will run on it's
# internal IP. The Rancher HA cluster will map requests to internal IPs.
#  

# The following environment variables are required to configure the reverse
# proxy
# ENV DOMAIN_NAME zestsoftware.nl
# ENV DOMAIN_ALIASES zest.nu zestsoftware.eu
# ENV BACKEND 127.0.0.1
# ENV BACKEND_PORT 8080
# ENV SITE_ID Zest

COPY defaults.conf /etc/nginx/conf.d/defaults.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY redirects.conf /etc/nginx/redirects.conf

# Service configuration using the entrypoint.
# We replace the environment variables in the nginx.conf and start nginx.
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

