FROM debian:bullseye

# Install MariaDB and any dependencies
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create necessary directories and set permissions
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld /var/lib/mysql

# Remove InnoDB log files if they exist
# RUN rm -f /var/lib/mysql/ib_logfile* /var/lib/mysql/ibdata* /var/lib/mysql/undo*  /var/lib/mysql/aria_log*
RUN rm -rf /var/lib/mysql/*

RUN chown -R mysql:mysql /var/lib/mysql

# Copy the entrypoint script
COPY ./tools/tools.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/tools.sh


EXPOSE 3306

# Start the MariaDB server

ENTRYPOINT ["/usr/local/bin/tools.sh"]