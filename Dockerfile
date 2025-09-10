FROM php:8.2-apache

# Install dependensi yang dibutuhkan
RUN apt-get update && apt-get install -y \
    libpq-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-install pgsql pdo pdo_pgsql intl gd zip

# Enable Apache mods
RUN a2enmod rewrite

# Set direktori kerja
WORKDIR /var/www/html

# Download Moodle versi 5.0.1
RUN curl -L -o moodle.zip https://download.moodle.org/download.php/direct/stable500/moodle-${MOODLE_VERSION}.zip \
    && unzip moodle.zip -d /var/www/html/ \
    && mv /var/www/html/moodle/* /var/www/html/ \
    && rm -rf /var/www/html/moodle moodle.zip

# Set permission
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
