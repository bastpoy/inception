#!/bin/bash

WP_CONFIG_PATH="/var/www/html/wp-config-sample.php"
WP_CONFIG_FINAL="/var/www/html/wp-config.php"

DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST}
WP_CACHE_KEY_SALT=$(openssl rand -base64 32)

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
chmod 644 $WP_CONFIG_FINAL

sed -i "s/database_name_here/$DB_NAME/" $WP_CONFIG_FINAL
sed -i "s/username_here/$DB_USER/" $WP_CONFIG_FINAL
sed -i "s/password_here/$DB_PASSWORD/" $WP_CONFIG_FINAL
sed -i "s/localhost/$DB_HOST/" $WP_CONFIG_FINAL

echo "define('WP_CACHE_KEY_SALT', '$WP_CACHE_KEY_SALT');" >> $WP_CONFIG_FINAL

# Enable Redis Object Cache
echo "define('WP_REDIS_HOST', 'redis');" >> $WP_CONFIG_FINAL
echo "define('WP_REDIS_PORT', 6379);" >> $WP_CONFIG_FINAL
echo "define('WP_CACHE', true);" >> $WP_CONFIG_FINAL

DEBUG_LOG="/var/www/html/wp-content/debug.log"
touch $DEBUG_LOG
chown www-data:www-data $DEBUG_LOG
chmod 664 $DEBUG_LOG

# Install WP-CLI if not already installed
if ! command -v wp &> /dev/null
then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Create admin user
wp core install --path="/var/www/html" \
    --url="${WORDPRESS_URL}" \
    --title="Inception" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email\
    --allow-root

# Activate Redis Object Cache plugin
wp plugin activate redis-cache --allow-root

# Enable Redis Object Cache
wp redis enable --allow-root

# Create user
if ! wp user get bob --allow-root &>/dev/null; then
    # User doesn't exist, so create it
    wp user create bob maildebob@rien.com \
    --user_pass="${WORDPRESS_USERPASS}" \
    --allow-root
    echo "User 'bob' created successfully."
else
    echo "User 'bob' already exists. Skipping creation."
fi

exec php-fpm7.4 -F