FROM php:8.1.2-fpm


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN apt-get update -y && apt-get upgrade -y && apt-get install git libssl-dev -y
# Install unzip utility and libs needed by zip PHP extension
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    unzip
RUN docker-php-ext-install zip
RUN pecl install mongodb && docker-php-ext-enable mongodb
#RUN echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini
#COPY --from=composer /usr/bin/composer /usr/bin/composer

#RUN apt-get install php-mongodb
WORKDIR /var/www/html


COPY ./app/ ./
RUN cd /var/www/html && composer install --prefer-dist && composer dump-autoload
