FROM php:7.2-fpm-alpine

LABEL "com.example.vendor"="etable.gr"
LABEL maintainer="Desyllas Dimitrios <d.desyllas@e-table.gr> <pcmagas@disroot.org>"

ENV PHP_CONF_DIR="$PHP_INI_DIR/conf.d" \
    PHP_SETTINGS="$PHP_INI_DIR/php.ini"\
    FPM_CONF_DIR="/usr/local/etc/php-fpm.d"

RUN apk add --update libzip-dev libmcrypt-dev libpng-dev libjpeg-turbo-dev libxml2-dev icu-dev postgresql-dev curl-dev libmemcached-dev &&\
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted gnu-libiconv &&\
    apk add --update --virtual build-dependencies build-base gcc wget autoconf &&\    
    docker-php-ext-install bcmath &&\
    docker-php-ext-install opcache && \
    docker-php-ext-install pdo pdo_pgsql pgsql && \
    docker-php-ext-install sockets &&\
    docker-php-ext-install intl && \
    docker-php-ext-install gd && \
    docker-php-ext-install soap && \
    docker-php-ext-install curl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install intl &&\
    docker-php-ext-install pcntl &&\
    docker-php-ext-install zip &&\
    docker-php-ext-install xml &&\
    docker-php-ext-install simplexml &&\
    pecl install memcached &&\
    docker-php-ext-enable memcached &&\
    apk del build-dependencies &&\
    echo "Configuring php" &&\
    touch ${PHP_SETTINGS} &&\
    rm -rf /var/cache/apk/*

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so

# For faster Re-Builds

RUN mv "$PHP_INI_DIR/php.ini-production" ${PHP_SETTINGS} &&\
    sed -i "s/max_execution_time = .*/max_execution_time = 45/" ${PHP_SETTINGS} &&\
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 20M/" ${PHP_SETTINGS} &&\
    sed -i "s/post_max_size = .*/post_max_size = 64M/" ${PHP_SETTINGS} &&\
    sed -i "s/error_reporting = .*/error_reporting = -1 /" ${PHP_SETTINGS} &&\
    sed -i "s/display_errors = .*/display_errors = On/" ${PHP_SETTINGS} &&\
    sed -i "s/cgi.fix_pathinfo = .*/cgi.fix_pathinfo = 1/" ${PHP_SETTINGS} &&\
    sed -i "s/allow_url_include = .*/allow_url_include = On/" ${PHP_SETTINGS} &&\
    sed -i "s/expose_php = .*/expose_php = Off/" ${PHP_SETTINGS} &&\
    sed -i "s/;date.timezone =/date.timezone = \"Europe\/Athens\"/" ${PHP_SETTINGS} &&\
    sed -i "s/memory_limit = .*/memory_limit = 256M/" ${PHP_SETTINGS}

RUN echo "Installing composer \n" &&\
    php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" &&\
    php /tmp/composer-setup.php --install-dir=/bin --filename=composer &&\
    rm -rf /tmp/cpmposer-setup.php &&\
    chmod +x /bin/composer