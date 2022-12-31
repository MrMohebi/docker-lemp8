FROM composer as builder
WORKDIR /app/
COPY ./app/composer.* ./
RUN composer install --prefer-dist && composer dump-autoload

FROM php:8.1.2-fpm

RUN apt-get update -y && apt-get upgrade -y && apt-get install git libssl-dev -y
# Install unzip utility and 
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip
RUN docker-php-ext-install zip
RUN pecl install mongodb && docker-php-ext-enable mongodb
#RUN echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini

#RUN apt-get install php-mongodb
WORKDIR /var/www/html

COPY --from=builder /app/ ./
COPY ./app/ ./
