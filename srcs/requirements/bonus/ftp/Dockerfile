FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    vsftpd && \
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

COPY vsftpd.conf /etc/vsftpd.conf

# Expose FTP ports
EXPOSE 21 21100-21110

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]