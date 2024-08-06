FROM alpine:3.19

# Install necessary packages
RUN apk update && \
    apk upgrade && \
    apk add nginx openssl && \
    mkdir -p /etc/nginx/ssl
    # chmod 755 /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=CA/ST=QC/L=Quebec/O=42 School/OU=inception/CN=inception"

COPY ./conf/nginx.conf ./etc/nginx/nginx.conf

RUN mkdir -p /run/nginx

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
