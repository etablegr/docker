FROM php:7.0.8-fpm-alpine

LABEL "com.example.vendor"="etable.gr"
LABEL maintainer="Desyllas Dimitrios <d.desyllas@e-table.gr> <pcmagas@disroot.org>"

ENV PHP_CONF_DIR="$PHP_INI_DIR/conf.d" \
    PHP_SETTINGS="$PHP_INI_DIR/php.ini"\
    FPM_CONF_DIR="/usr/local/etc/php-fpm.d"

RUN apk add --update --virtual build-dependencies build-base gcc wget autoconf git &&\
    echo "Installing docker-provided modules" &&\
    echo "Install Mcrypt and mbstring" &&\
    apk add --update libmcrypt-dev &&\
    docker-php-ext-install mcrypt &&\
    docker-php-ext-install mbstring &&\
    echo "Install zip php extention" &&\
    apk add zlib-dev &&\
    docker-php-ext-install zip &&\
    echo "Install postgresql database requirements" &&\
    apk add postgresql-dev &&\
    docker-php-ext-install pdo pdo_pgsql pgsql &&\
    echo "Install mysql database requirements" &&\
    docker-php-ext-install pdo_mysql mysqli &&\
    apk add libxml2-dev curl-dev &&\
    docker-php-ext-install soap &&\
    echo "Install iconv" &&\
    apk add icu-dev &&\
    docker-php-ext-install iconv &&\
    echo "Install gd" &&\
    apk add libpng-dev libjpeg-turbo-dev &&\
    docker-php-ext-install gd &&\
    echo "Install miscellanous php extentions" &&\
    docker-php-ext-install calendar &&\
    docker-php-ext-install bcmath &&\
    docker-php-ext-install opcache &&\
    echo "Enable redis" &&\
    pecl install -o -f redis &&\  
    rm -rf /tmp/pear &&\
    docker-php-ext-enable redis &&\
    echo "Clean up" &&\
    apk del build-dependencies &&\
    rm -rf /var/cache/apk/* &&\
    rm -rf /tmp/*

RUN echo "Installed memcached" &&\
    apk add --update --virtual build-dependencies build-base gcc wget autoconf curl &&\
    apk add --update --no-cache libmemcached-dev cyrus-sasl-dev &&\
    curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
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
    && docker-php-ext-enable memcached \
    && apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*
# For faster Re-Builds

RUN echo "Configuring php" &&\
    touch ${PHP_SETTINGS} &&\
    sed -i "s/max_execution_time = .*/max_execution_time = 45/" ${PHP_SETTINGS} &&\
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 20M/" ${PHP_SETTINGS} &&\
    sed -i "s/post_max_size = .*/post_max_size = 64M/" ${PHP_SETTINGS} &&\
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& E_DEPRECATED /" ${PHP_SETTINGS} &&\
    sed -i "s/display_errors = .*/display_errors = On/" ${PHP_SETTINGS} &&\
    sed -i "s/cgi.fix_pathinfo = .*/cgi.fix_pathinfo = 1/" ${PHP_SETTINGS} &&\
    sed -i "s/allow_url_include = .*/allow_url_include = On/" ${PHP_SETTINGS} &&\
    sed -i "s/expose_php = .*/expose_php = Off/" ${PHP_SETTINGS} &&\
    sed -i "s/;date.timezone =/date.timezone = \"Europe\/Athens\"/" ${PHP_SETTINGS}

RUN echo "Installing composer \n" &&\
    php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" &&\
    php /tmp/composer-setup.php --install-dir=/bin --filename=composer &&\
    rm -rf /tmp/cpmposer-setup.php &&\
    chmod +x /bin/composer

ENTRYPOINT /bin/sh