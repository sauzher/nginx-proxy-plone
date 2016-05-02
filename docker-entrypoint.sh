#!/bin/sh
set -e

# replace the server DOMAIN_NAME
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/conf.d/default.conf
sed -i "s/DOMAIN_NAME/${DOMAIN_NAME}/g" /etc/nginx/redirects.conf
sed -i "s/ALIASES/${ALIASES}/g" /etc/nginx/conf.d/default.conf
sed -i "s/BACKEND/${BACKEND}/" /etc/nginx/conf.d/default.conf
sed -i "s/BACKEND_PORT/${BACKEND_PORT}/" /etc/nginx/conf.d/default.conf
sed -i "s/SITE_ID/${SITE_ID}/" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"