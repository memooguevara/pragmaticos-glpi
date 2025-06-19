FROM node:22-alpine3.22 AS node
FROM composer:2.8.4 AS composer
FROM alpine:3.22.0 AS base

RUN adduser -u 82 -D -S -G www-data www-data

RUN apk add --update --no-cache \
  bash \
  curl \
  git \
  vim

RUN apk add --no-cache \
  ca-certificates \
  openssl \
  gettext \
  php82 \
  php82-fpm \
  php82-bcmath \
  php82-bz2 \
  php82-ctype \
  php82-curl \
  php82-dom \
  php82-exif \
  php82-fileinfo \
  php82-gd \
  php82-iconv \
  php82-intl \
  php82-json \
  php82-ldap \
  php82-mbstring \
  php82-mysqli \
  php82-opcache \
  php82-openssl \
  php82-phar \
  php82-session \
  php82-simplexml \
  php82-sodium \
  php82-tokenizer \
  php82-xml \
  php82-xmlreader \
  php82-xmlwriter \
  php82-zip \
  && ln -s /usr/bin/php82 /usr/bin/php \
  && ln -s /usr/sbin/php-fpm82 /usr/bin/php-fpm

RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

WORKDIR /var/www/html
# COPY . .

# RUN chmod -R 777 /var/www/html/files /var/www/html/config /var/www/html/marketplace
COPY .docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm", "-F"]

FROM base AS prod

# RUN composer install --no-dev --no-interaction --optimize-autoloader
# RUN npm install --no-audit --no-fund --omit=dev \
#   && npm cache clean --force

FROM base AS dev

# RUN php bin/console dependencies install
