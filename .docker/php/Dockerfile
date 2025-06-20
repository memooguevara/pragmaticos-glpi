FROM composer:2.8.4 AS composer
FROM node:22-alpine3.22 AS node
FROM alpine:3.22.0 AS base

RUN apk add --update --no-cache \
  bash \
  curl \
  git \
  vim

RUN apk add --no-cache \
  ca-certificates \
  openssl \
  gettext \
  patch \
  zip \
  unzip \
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
  && ln -s /usr/sbin/php-fpm82 /usr/bin/php-fpm \
  && rm -rf /var/cache/apk/*

#RUN adduser -u 82 -D -S -G www-data www-data

RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php82/php-fpm.d/www.conf
# && sed -i 's/^user = .*/user = www-data/' /etc/php82/php-fpm.d/www.conf \
# && sed -i 's/^group = .*/group = www-data/' /etc/php82/php-fpm.d/www.conf \
# && mkdir -p /var/log/php82 \
# && touch /var/log/php82/error.log \
# && chown -R www-data:www-data /var/log/php82

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=node /usr/local/include/node /usr/local/include/node
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
 && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

COPY ./.docker/php/php.ini /etc/php82/conf.d/zz_app.ini

WORKDIR /var/www/html

#COPY . .

#RUN chmod -R 777 files config marketplace
#RUN chown -R www-data:www-data files config marketplace \
# && chmod -R 755 files config marketplace
#COPY .docker/php/entrypoint.sh /usr/local/bin/entrypoint.sh
#RUN chmod +x /usr/local/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]

#RUN php bin/console dependencies install

#USER www-data
CMD ["php-fpm", "-F"]

EXPOSE 9000
