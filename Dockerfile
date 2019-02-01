FROM php:7.2

MAINTAINER Remo Liebi <rl@kreatif.ch>

RUN apt-get update -q && \
    apt-get -yqq install \
        openssh-client \
        git \
        libmcrypt-dev \
        libpq-dev \
        libcurl4-gnutls-dev \
        libicu-dev libvpx-dev libjpeg-dev \
        libpng-dev libxpm-dev zlib1g-dev \
        libfreetype6-dev libxml2-dev \
        libexpat1-dev libbz2-dev libgmp3-dev \
        libldap2-dev unixodbc-dev libsqlite3-dev \
        libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev \
    && apt-get autoclean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring pdo_mysql curl json intl gd xml zip bz2 opcache exif mysqli sysvsem

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
        && chmod +x /usr/local/bin/composer
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# RUN chmod -R 600 /root/.ssh/*
# RUN chown -R root:root /root/.ssh
