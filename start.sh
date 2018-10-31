#!/bin/bash

/usr/bin/supervisord -c /etc/supervisord.conf

/usr/local/nginx/sbin/nginx -g 'daemon off;'