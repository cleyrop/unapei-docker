FROM php:8.1.4-apache-bullseye
#https://github.com/docker-library/php/blob/af4cd1a2184cb2026431cddb5377391d19728fd4/8.1/bullseye/apache/Dockerfile

RUN apt-get update -qq && apt-get install -yqq  --no-install-recommends \
        git unzip libssh2-1-dev libssh2-1 libpng-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://pecl.php.net/get/ssh2-1.3.1.tgz -o ssh2.tgz \
    && pecl install ssh2 ssh2.tgz \
    && docker-php-ext-enable ssh2 \
    && rm -rf ssh2.tgz \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && chown www-data:www-data /var/www

ADD resources/versions.sh /usr/local/bin/versions.sh
ADD resources/composer.json /var/www/composer.json
RUN chown www-data:www-data /var/www/composer.json

USER www-data

WORKDIR /var/www
RUN mkdir /var/www/.ssh \
    && composer install \
    && composer update

#RUN useradd -m codatalab \
#    && usermod -a -G www-data codatalab

WORKDIR /var/www/html

STOPSIGNAL SIGTERM

ADD resources/entrypoint /entrypoint
ENTRYPOINT [ "/entrypoint" ]
