#!/bin/sh
set -e

# replace the server DOMAIN_NAME
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/redirects.conf
sed -i "s/DOMAIN_ALIASES/${DOMAIN_ALIASES}/g" /etc/nginx/conf.d/default.conf
sed -i "s/BACKEND_HOST/${BACKEND}/g" /etc/nginx/conf.d/default.conf
sed -i "s/BACKEND_PORT/${BACKEND_PORT}/g" /etc/nginx/conf.d/default.conf
sed -i "s/SITE_ID/${SITE_ID}/g" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"