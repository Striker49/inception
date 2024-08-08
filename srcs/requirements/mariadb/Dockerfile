# Use the official Alpine image as a base
FROM alpine:3.19

# Install necessary packages
RUN apk update && \
    apk add --no-cache mysql mysql-client openrc && \
    rm -f /var/cache/apk/*

# Copy the setup script into the image
COPY /tools/script.sh /script.sh
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Make the script executable
# RUN chmod -R 755 /sys/
RUN chmod +x /script.sh
RUN chmod +x /etc/my.cnf.d/mariadb-server.cnf

# Create folder for db and set permissions
RUN mkdir -p /var/lib/mysql
RUN chmod +x /var/lib/mysql
RUN mkdir -p /run/mysqld
RUN chmod +x /run/mysqld

# Configure MariaDB to run as root
RUN openrc && touch /run/openrc/softlevel
RUN chmod +x /run/openrc/softlevel
RUN rc-update add mariadb default
RUN rc-service mariadb setup

# Expose port 3306
EXPOSE 3306

# Run the setup script
ENTRYPOINT ["/script.sh"]

# Start MariaDB server in the foreground
CMD ["mysqld", "--user=root"]