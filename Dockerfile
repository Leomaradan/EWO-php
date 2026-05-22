FROM php:8.3-apache

# PHP
RUN apt-get update && apt-get upgrade
RUN apt-get install -y zlib1g-dev libwebp-dev libpng-dev && docker-php-ext-install gd pdo pdo_mysql mysqli 
RUN apt-get install libzip-dev -y && docker-php-ext-install zip
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Apache
RUN a2enmod rewrite
RUN service apache2 restart

#RUN chmod 777 -R /var/www/html/template/themes/

EXPOSE 80