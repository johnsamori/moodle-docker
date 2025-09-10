FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    curl \
    libjpeg-dev \
    libpng-dev \
    libicu-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install pgsql pdo pdo_pgsql intl gd zip

WORKDIR /var/www/html

# Download Moodle
ARG MOODLE_VERSION
RUN curl -L -o moodle.zip https://download.moodle.org/download.php/direct/stable500/moodle-${MOODLE_VERSION}.zip \
    && unzip moodle.zip -d /var/www/html/ \
    && mv /var/www/html/moodle/* /var/www/html/ \
    && rm -rf /var/www/html/moodle moodle.zip

# Set permission
RUN chown -R www-data:www-data /var/www/html

CMD ["php-fpm"]
