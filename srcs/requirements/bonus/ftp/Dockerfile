FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    vsftpd \
    ftp && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf

RUN chmod +x /etc/vsftpd.conf

RUN mkdir -p /var/run/vsftpd/empty

# Expose FTP ports
EXPOSE 21 21100-21110

CMD ["/usr/sbin/vsftpd"]