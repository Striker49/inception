# Use the official Alpine image as a base
FROM alpine:3.19

# Install necessary packages
RUN apk update && \
    apk add --no-cache mariadb mariadb-client mariadb-server-utils openrc

# Copy the setup script into the image
COPY script.sh /script.sh

# Make the script executable
RUN chmod +x /script.sh

# Configure MariaDB to run as root
RUN sed -i '/\[mysqld\]/a user=root' /etc/my.cnf.d/mariadb-server.cnf

# Expose port 3306
EXPOSE 3306

# Run the setup script
ENTRYPOINT ["/script.sh"]

# Start MariaDB server in the foreground
CMD ["mysqld_safe", "--datadir=/var/lib/mysql"]