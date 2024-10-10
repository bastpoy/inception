#!/bin/bash
set -e

# Configure MariaDB to listen on all interfaces
chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize the MySQL data directory if it's empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --datadir=/var/lib/mysql

  # Start MariaDB server
  mysqld --user=mysql --datadir=/var/lib/mysql &
  pid="$!"

  # Wait for MariaDB server to start
  until mysqladmin ping >/dev/null 2>&1; do
      echo "Waiting for MariaDB to be ready..."
      sleep 1
  done

  # Secure the MariaDB installation
  mysql -uroot <<EOSQL
      -- Set root password
      ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
      -- Delete anonymous users
      DELETE FROM mysql.user WHERE User='';
      -- Disallow root login remotely
      DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
      -- Remove test database
      DROP DATABASE IF EXISTS test;
      DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
      -- Create user for WordPress (adjust as needed)
      CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
      CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
      GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
      -- Reload privileges
      FLUSH PRIVILEGES;
EOSQL

    # Stop the temporary MariaDB server
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MySQL init process failed.'
        exit 1
    fi
else
    echo "MariaDB data directory already initialized."
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql --console