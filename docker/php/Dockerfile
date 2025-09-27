ARG PHP_VERSION=""
FROM php:${PHP_VERSION:+${PHP_VERSION}-}fpm

# نصب کتابخانه‌های موردنیاز برای PostgreSQL و MySQL
#RUN  apt-get update && apt-get install -y \
#    libpq-dev \
#	nano \
#    && docker-php-ext-install \
#       pdo \
#       pdo_mysql \
#       mysqli \
#       pgsql \
#       pdo_pgsql \
#    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    libonig-dev \
    nano \
    unzip \
    && docker-php-ext-install \
    pdo_mysql \
    mysqli \
    pdo_pgsql \
    pgsql \
    && rm -rf /var/lib/apt/lists/*		

# کپی php.ini
COPY  ./ini/php.ini /usr/local/etc/php/conf.d/php.ini


 
