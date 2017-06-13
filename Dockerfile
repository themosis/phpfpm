FROM php:fpm

RUN apt-get update && apt-get install -y \
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
    && docker-php-ext-install -j$(nproc) bcmath ctype dom iconv mbstring mcrypt mysqli pdo_mysql soap xml xmlrpc sockets \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl channel-update pecl.php.net

RUN pecl install imagick \
    && docker-php-ext-enable imagick

EXPOSE 9000

CMD ["php-fpm"]