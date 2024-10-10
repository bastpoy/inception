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

cat << EOF >> $WP_CONFIG_FINAL

// Enable debugging
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
@ini_set( 'display_errors', 0 );

// Test database connection
\$connection = mysqli_connect('$DB_HOST', '$DB_USER', '$DB_PASSWORD', '$DB_NAME');
if (!\$connection) {
    error_log("Database connection failed: " . mysqli_connect_error());
    die("Database connection failed. Check your configuration.");
}
mysqli_close(\$connection);
EOF

# printf "\n\
# define( 'WP_DEBUG', true ); \n\
# define( 'WP_DEBUG_LOG', true ); \n\
# define( 'WP_DEBUG_DISPLAY', false ); \n\
# " >> /var/www/html/wp-config.php

exec php-fpm7.4 -F
