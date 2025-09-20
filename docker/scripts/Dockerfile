FROM php:8.2.27

# نصب اکستنشن‌های MySQL و PDO
RUN docker-php-ext-install mysqli pdo pdo_mysql

# نصب اکستنشن‌های PostgreSQL و PDO_PgSQL
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_pgsql pgsql

# فعال‌سازی mod_rewrite
RUN a2enmod rewrite

# کپی php.ini سفارشی
COPY ./public_html/ini/php.ini /usr/local/etc/php/conf.d/php.ini
