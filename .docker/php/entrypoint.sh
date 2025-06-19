#!/bin/bash

chmod -R 777 /var/www/html/files /var/www/html/config /var/www/html/marketplace

exec "$@"
