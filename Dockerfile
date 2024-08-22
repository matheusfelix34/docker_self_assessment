FROM php:8.0


#depêndencias de sistema 
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    wget \
    libaio1 \
    libaio-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#depêndencias de php 
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd sockets

#instalação do comoposer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . .

RUN composer update
RUN composer install

EXPOSE 8000

#CMD php artisan serve --host=0.0.0.0 --port=8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]

