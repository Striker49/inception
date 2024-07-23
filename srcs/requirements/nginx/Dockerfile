FROM alpine:3.19

# Install necessary packages
RUN apk update && \
    apk upgrade && \
    apk add nginx vim curl openssl && \
    mkdir -p /var/www/html && \
    chmod 755 /var/www/html && \
    # Use the existing nginx user and group
    chown -R nginx:nginx /var/www/html

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
