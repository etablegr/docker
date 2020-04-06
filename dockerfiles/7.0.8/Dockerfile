# Forked and modified from https://hub.docker.com/r/supergramm/phpfpm-7.0.8/dockerfile
FROM php:7.0.8-fpm

MAINTAINER supergramm/phpfpm7
MAINTAINER Desyllas Dimitrios <d.desyllas@e-table.gr><pcmagas@disroot.org>

ENV PHP_INI="/usr/local/etc/php/php.ini" \
    FPM_CONF="/usr/local/etc/php-fpm.d/www.conf"

RUN echo "Europe/Athens" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata

RUN buildDeps=" \
        zlib1g-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libzip-dev \
        libpq-dev \
        libxml2-dev \
        libpng12-dev \
        git  \
        unzip \
        "; \
        set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
   && pecl install redis \
    && docker-php-ext-install \
        mcrypt \
        mbstring \
        iconv \
        bcmath \
        opcache \
        mysqli \
        pgsql \
        zip \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        calendar \
        soap \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable redis

# Install memcached extension for php 7
RUN curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
    && mkdir -p memcached \
    && tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && ( \
        cd memcached \
        && phpize \
        && ./configure \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r memcached \
    && rm /tmp/memcached.tar.gz \
    && docker-php-ext-enable memcached

RUN echo "Configure php-ini" \
    && echo "date.timezone = Europe/Athens" >> $PHP_INI \
    && echo "expose_php = Off" >> $PHP_INI \
    && echo "log_errors = On" >> $PHP_INI \
    && echo "error_reporting = E_ALL" >> $PHP_INI \
    && echo "max_execution_time = 300" >> ${PHP_INI} \    
    && echo "max_input_vars = 3000" >> ${PHP_INI} \
    && echo "request_terminate_timeout = 300" >> ${PHP_INI} \
    && echo "upload_max_filesize = 32M/" >> $PHP_INI \
    && echo "post_max_size=32M" >> ${PHP_INI}
    
WORKDIR /var/www

ENTRYPOINT php-fpm
