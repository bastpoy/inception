#!/bin/bash

set -e

# Configure MariaDB to listen on all interfaces
chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize the MySQL data directory if it's empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db

    # Start MariaDB server
    mysqld --skip-networking &
    pid="$!"

    Wait for MariaDB server to start
    until mysqladmin ping >/dev/null 2>&1; do
        echo "Waiting for MariaDB to be ready..."
        sleep 1
    done

    # Secure the MariaDB installation
    mysql -uroot -p <<EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOSQL

    # service mariadb stop
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi
else
    echo "MariaDB data directory already initialized."
fi

echo "Starting MariaDB server..."
exec mysqld --console
