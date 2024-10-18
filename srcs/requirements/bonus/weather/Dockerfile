FROM debian:bullseye

RUN apt-get update && apt-get install -y\
    nodejs \
    npm
    
RUN mkdir -p /var/www/weather

RUN chmod 777 /var/www/weather

COPY ./weather /var/www/weather

CMD ["node", "/var/www/weather/script.js"]
    