FROM php:7.3-apache

MAINTAINER Pierre Garel <garelp@toplite.org>, Jon Richter <jon@allmende.io>

LABEL version="1.2.0"
LABEL description="PHP 7.3 / Apache 2 / Galette 0.9.2.1"

RUN a2enmod rewrite
RUN apt-get -y update && apt-get install -y \
  wget \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libtidy-dev
RUN docker-php-ext-install -j$(nproc) tidy gettext intl mysqli pdo_mysql && \
  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
  docker-php-ext-install -j$(nproc) gd

ENV GALETTE_VERSION 0.9.2.1

RUN cd /usr/src; wget http://download.tuxfamily.org/galette/galette-${GALETTE_VERSION}.tar.bz2
RUN cd /usr/src; tar jxvf galette-${GALETTE_VERSION}.tar.bz2; mv galette-${GALETTE_VERSION}/galette/* /var/www/html/ ; rm galette-${GALETTE_VERSION}.tar.bz2
RUN chown -R www-data:www-data /var/www/html/

