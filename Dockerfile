FROM php:7.4-apache

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Configurar e instalar extensiones de PHP (mysqli es vital para software legacy)
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql zip

# Habilitar reescritura de URLs en Apache
RUN a2enmod rewrite

# Asignar permisos correctos
RUN chown -R www-data:www-data /var/www/html
