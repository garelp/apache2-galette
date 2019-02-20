#!/bin/bash
set -e

if [ ! -e '/var/www/html/config/versions.inc.php' ]; then
	cp -pr /usr/src/galette/* /var/www/html
	rm -f /var/www/html/index.html
	chown -R www-data:www-data /var/www/html
fi

exec "$@"