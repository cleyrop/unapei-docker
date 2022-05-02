FROM php:7.4.21-apache-buster
#https://github.com/docker-library/php/blob/af4cd1a2184cb2026431cddb5377391d19728fd4/8.1/bullseye/apache/Dockerfile

RUN apt-get update -qq && apt-get install -yqq  --no-install-recommends \
        git libzip-dev zip unzip libssh2-1-dev libssh2-1 net-tools iputils-ping tree nano \
        libpng-dev \
        zlib1g-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxpm-dev \
        libfreetype6-dev \
        libexif-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && curl https://pecl.php.net/get/ssh2-1.3.1.tgz -o ssh2.tgz \
    && pecl install ssh2 ssh2.tgz \
    && docker-php-ext-enable ssh2 \
    && rm -rf ssh2.tgz \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-xpm --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) exif \
    && docker-php-ext-install -j$(nproc) gettext \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && sed -i 's:DocumentRoot /var/www/html:DocumentRoot /var/www/web:g' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's:DocumentRoot /var/www/html:DocumentRoot /var/www/web:g' /etc/apache2/sites-available/default-ssl.conf \
    && sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf \
    && sed -i 's/Listen 80$/Listen 8080/g' /etc/apache2/ports.conf \
    && sed -i 's/<VirtualHost _default_:443>/<VirtualHost _default_:8443>/g' /etc/apache2/sites-available/default-ssl.conf \
    && sed -i 's/Listen 443$/Listen 8443/g' /etc/apache2/ports.conf \
    && a2enmod rewrite

ADD resources/versions.sh /usr/local/bin/versions.sh
ADD resources/conf.d/ /usr/local/etc/php/conf.d/
ADD resources/www/ /var/www-bak/
ADD resources/sites/ /var/www-bak/web/sites/

RUN chown -R www-data:www-data /var/www \
    && chown -R www-data:www-data /var/www-bak \
    && chmod +x /usr/local/bin/versions.sh

USER www-data

WORKDIR /var/www

STOPSIGNAL SIGTERM

ADD resources/entrypoint /entrypoint
ENTRYPOINT [ "/entrypoint" ]
