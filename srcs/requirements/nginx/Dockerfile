# FROM nginx:stable-bullseye
# FROM nginx:latest
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# COPY /etc/ssl/certs /etc/nginx/certs
# COPY /etc/ssl/private /etc/nginx/private
COPY ./nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]