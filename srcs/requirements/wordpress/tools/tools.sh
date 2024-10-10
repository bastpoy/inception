#!/bin/bash

WP_CONFIG_PATH="/var/www/html/wp-config-sample.php"
WP_CONFIG_FINAL="/var/www/html/wp-config.php"

DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST}

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
chmod 644 $WP_CONFIG_FINAL

sed -i "s/database_name_here/$DB_NAME/" $WP_CONFIG_FINAL
sed -i "s/username_here/$DB_USER/" $WP_CONFIG_FINAL
sed -i "s/password_here/$DB_PASSWORD/" $WP_CONFIG_FINAL
sed -i "s/localhost/$DB_HOST/" $WP_CONFIG_FINAL

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

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" --console

# Create admin user
wp core install --path="/var/www/html" \
    --url="${WORDPRESS_URL}" \
    --title="Inception" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
    --skip-email\
    --allow-root

# Create user
wp user create bob maildebob@rien.com \
    --user_pass="${WORDPRESS_USERPASS}"\
    --allow-root


exec php-fpm7.4 -F