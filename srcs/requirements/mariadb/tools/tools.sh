#!/bin/bash
set -e

# trap "exit" TERM

# Start MariaDB service
service mariadb start

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
  echo "Waiting for MariaDB to be ready..."
  sleep 2
done

# Set root password using the environment variable
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

# Delete anonymous users and the test database
mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
mysql -u root -e "DROP DATABASE IF EXISTS test;"
mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Run the main MariaDB process
exec mariadbd --user=mysql --console