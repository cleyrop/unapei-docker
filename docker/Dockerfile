FROM php:8.1.4-apache-bullseye
#https://github.com/docker-library/php/blob/af4cd1a2184cb2026431cddb5377391d19728fd4/8.1/bullseye/apache/Dockerfile

RUN apt-get update -qq && apt-get install -yqq  --no-install-recommends \
        git unzip libssh2-1-dev libssh2-1 libpng-dev net-tools iputils-ping \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://pecl.php.net/get/ssh2-1.3.1.tgz -o ssh2.tgz \
    && pecl install ssh2 ssh2.tgz \
    && docker-php-ext-enable ssh2 \
    && rm -rf ssh2.tgz \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && chown www-data:www-data /var/www 
#    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

ADD resources/versions.sh /usr/local/bin/versions.sh

ADD resources/conf.d/allow-url-open.ini /usr/local/etc/php/conf.d/allow-url-open.ini
ADD resources/conf.d/docker-php-memlimit.ini /usr/local/etc/php/conf.d/docker-php-memlimit.ini
ADD resources/conf.d/max-execution-time-php.ini /usr/local/etc/php/conf.d/max-execution-time-php.ini
ADD resources/conf.d/max-input-time-php.ini /usr/local/etc/php/conf.d/max-input-time-php.ini
ADD resources/conf.d/max-input-vars-php.ini /usr/local/etc/php/conf.d/max-input-vars-php.ini
ADD resources/conf.d/memory-limit-php.ini /usr/local/etc/php/conf.d/memory-limit-php.ini
ADD resources/conf.d/upload-max-filesize-php.ini /usr/local/etc/php/conf.d/upload-max-filesize-php.ini

ADD resources/composer.json /var/www/html/composer.json
RUN chown www-data:www-data /var/www/html/composer.json

USER www-data

RUN mkdir -p /var/www/.ssh \
    && composer install \
    && composer update

STOPSIGNAL SIGTERM

ADD resources/entrypoint /entrypoint
ENTRYPOINT [ "/entrypoint" ]
