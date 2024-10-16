FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-server \
    redis-tools \
    wget \
    unzip \
    curl \
    iputils-ping \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create necessary directories
RUN mkdir -p /var/www/html /run/php
RUN chown -R www-data:www-data /var/www/html /run/php
RUN chmod -R 755 /var/www/html

#install wordpress
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /tmp && \
    mv /tmp/wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    rm /tmp/wordpress.zip && rm -rf /tmp/wordpress

# Install Redis Object Cache plugin
RUN curl -o /tmp/redis-cache.zip -fSL "https://downloads.wordpress.org/plugin/redis-cache.latest-stable.zip" \
    && unzip /tmp/redis-cache.zip -d /var/www/html/wp-content/plugins/ \
    && rm /tmp/redis-cache.zip

# create tools script 
COPY ./tools/tools.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/tools.sh

# Set working directory
WORKDIR /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start the script
ENTRYPOINT ["/usr/local/bin/tools.sh"]
