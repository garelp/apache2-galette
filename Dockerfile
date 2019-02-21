FROM ubuntu:16.04

MAINTAINER Pierre Garel <garelp@toplite.org>

LABEL version="1.1.5"
LABEL description="Apache 2 / PHP / Galette"

RUN apt-get -y update && apt-get install -y \
apache2 \
php \
libapache2-mod-php \
php-gd \
php-json \
php-tidy \
php-curl \
php-gettext \
php-mysql \
php-mcrypt \
php-mbstring \
mcrypt \
wget

ENV GALETTE_VERSION 0.9.2.1

RUN cd /usr/src; wget http://download.tuxfamily.org/galette/galette-${GALETTE_VERSION}.tar.bz2
RUN cd /usr/src; tar jxvf galette-${GALETTE_VERSION}.tar.bz2; mv galette-${GALETTE_VERSION}/galette . ; rm galette-${GALETTE_VERSION}.tar.bz2
RUN chown -R www-data:www-data /usr/src/galette

# on veut une machine de dev qui affiche toutes les erreurs PHP
RUN sed -i -e 's/^error_reporting\s*=.*/error_reporting = E_ALL/' /etc/php/7.0/apache2/php.ini
RUN sed -i -e 's/^display_errors\s*=.*/display_errors = On/' /etc/php/7.0/apache2/php.ini

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# commandes à exécuter au démarrage de l'instance de l'image
# ici on démarrera Apache
CMD ["/usr/sbin/apache2ctl","-DFOREGROUND"]