# FROM wordpress:6.2.1-php8.1-fpm
FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-gd \
    php7.4-intl \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-xml \
    php7.4-zip \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create necessary directories
RUN mkdir -p /var/www/html /run/php
RUN chown -R www-data:www-data /var/www/html /run/php

RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    mv /tmp/wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    rm /tmp/wordpress.zip && rm -rf /tmp/wordpress

RUN touch /var/www/html/wp-content/debug.log

# Modify wp-config.php to enable WP_DEBUG
RUN echo "\n\
define( 'WP_DEBUG', true ); \n\
define( 'WP_DEBUG_LOG', true ); \n\
define( 'WP_DEBUG_DISPLAY', false ); \n\
" >> /var/www/html/wp-config-sample.php

COPY ./tools/tools.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/tools.sh

# Set working directory
WORKDIR /var/www/html

# RUN mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# RUN chown www-data:www-data /var/www/html/wp-config-sample.php && \
#     mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM

ENTRYPOINT ["/usr/local/bin/tools.sh"]
# CMD ["php-fpm7.4", "-F"]