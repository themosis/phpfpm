FROM php:fpm

RUN apt-get update && apt-get install -y \
        wget \
        git \
        libjpeg-dev \
        libpng12-dev \
        libfreetype6-dev \
        libxml2-dev \
        libmcrypt-dev \
        mcrypt \
        libmagickwand-dev \
        libmagickcore-dev \
        imagemagick \
        ghostscript \
        libmemcached-dev \
        pkg-config \
        libssl-dev \
    && docker-php-ext-install -j$(nproc) bcmath ctype dom iconv mbstring mcrypt mysqli pdo_mysql soap xml xmlrpc sockets zip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl channel-update pecl.php.net

RUN pecl install imagick \
    && docker-php-ext-enable imagick

RUN pecl install memcached \
    && docker-php-ext-enable memcached

RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

RUN pecl install redis \
    && docker-php-ext-enable redis

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN wget -P /tmp https://phar.phpunit.de/phpunit.phar \
    && chmod +x /tmp/phpunit.phar \
    && mv /tmp/phpunit.phar /usr/local/bin/phpunit

RUN locale-gen fr_FR.UTF-8
ENV LANG fr_FR.UTF-8  
ENV LANGUAGE fr_FR:fr  
ENV LC_ALL fr_FR.UTF-8

EXPOSE 9000

CMD ["php-fpm"]