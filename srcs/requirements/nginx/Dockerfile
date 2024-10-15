FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]