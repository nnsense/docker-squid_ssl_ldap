FROM centos:latest
LABEL maintainer="nnsense@gmail.com"
LABEL version="1.0"

RUN yum -y update && yum install -y squid
RUN /usr/lib64/squid/security_file_certgen -c -s /etc/squid/ssl_db -M 20MB && chown -R root:squid /etc/squid/ssl_db
RUN /usr/bin/openssl req -new -newkey rsa:2048 -subj "/C=GB/ST=United Kingdom/L=Hogwarts/O=School of Witchcraft and Wizardry/OU=IT/CN=EtherealCA" -days 3650 -nodes -x509 -keyout /etc/squid/squid.key -out /etc/squid/squid.crt
RUN /usr/bin/openssl x509 -in /etc/squid/squid.crt -outform DER -out /etc/squid/squid.der

EXPOSE 3128/tcp

ENTRYPOINT ["/usr/sbin/squid","-NCd1"]
