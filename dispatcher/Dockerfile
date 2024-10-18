FROM almalinux:9

# Installa Apache, OpenSSL e altri strumenti necessari
RUN yum update -y && yum install -y \
    httpd \
    openssl \
    wget \
    tar \
    && yum clean all

# Scarica e installa il modulo dispatcher di AEM (SSL 3.0 compatibile)
RUN wget https://download.macromedia.com/dispatcher/download/dispatcher-apache2.4-linux-x86_64-ssl3.0-4.3.7.tar.gz -O /tmp/dispatcher.tar.gz \
    && mkdir /etc/httpd/modules/dispatcher \
    && tar -xzf /tmp/dispatcher.tar.gz -C /etc/httpd/modules/dispatcher \
    && rm /tmp/dispatcher.tar.gz

# Copia i file di configurazione per Apache e Dispatcher
COPY conf/dispatcher.any /etc/httpd/conf/dispatcher.any
COPY conf/httpd.conf /etc/httpd/conf/httpd.conf

# Espone la porta 80 per il traffico HTTP
EXPOSE 80

# Comando di avvio
CMD ["httpd", "-D", "FOREGROUND"]


