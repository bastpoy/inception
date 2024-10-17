FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/website

RUN chown -R www-data:www-data /var/www/website
RUN chmod -R 745 /var/www/website

COPY ./website /var/www/website

CMD ["nginx", "-g", "daemon off;"]