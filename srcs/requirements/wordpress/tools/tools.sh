#!/bin/bash

WP_CONFIG_PATH="/var/www/html/wp-config-sample.php"

DB_NAME=${MYSQL_DATABASE}
DB_USER=${MYSQL_USER}
DB_PASSWORD=${MYSQL_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST}

chmod 777 $WP_CONFIG_PATH
# sed -i.bak "s/define( *'DB_NAME'.*/define('DB_NAME', '$DB_NAME');/" "$WP_CONFIG_PATH"

sed "s/database_name_here/$DB_NAME/" $WP_CONFIG_PATH
sed "s/username_here/$DB_USER/" $WP_CONFIG_PATH
sed "s/password_here/$DB_PASSWORD/" $WP_CONFIG_PATH
sed "s/database_name_here/$DB_HOST/" $WP_CONFIG_PATH

cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

exec php-fpm7.4 -F
