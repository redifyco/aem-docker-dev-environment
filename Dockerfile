# Stage 1: Base image
FROM almalinux:9 AS base

# Imposta variabili d'ambiente per AEM
ENV AEM_VERSION=6.5.0
ENV JAVA_HOME=/opt/jdk-11.0.24
ENV PATH=$JAVA_HOME/bin:$PATH

# Installa wget e tar per scaricare ed estrarre il JDK
RUN yum update -y && \
    yum install -y wget tar && \
    yum clean all

# Copia e installa JDK dalla directory principale del progetto
COPY jdk-11_linux-x64_bin.tar.gz /tmp/
RUN tar -xzf /tmp/jdk-11_linux-x64_bin.tar.gz -C /opt && \
    rm /tmp/jdk-11_linux-x64_bin.tar.gz

# Verifica che il JDK sia installato correttamente
RUN java -version

# Stage 2: AEM Author
FROM base AS author

# Crea la directory per AEM
WORKDIR /aem

# Copia il file AEM Quickstart JAR, la licenza e lo script dalla directory principale del progetto
COPY aem-quickstart.jar /aem/aem-quickstart.jar
COPY license.properties /aem/license.properties
COPY start-aem.sh /aem/start-aem.sh
COPY install /aem/install

# Rinomina il file JAR per l'istanza Author
RUN mv /aem/aem-quickstart.jar /aem/aem-author-p4502.jar

# Imposta i permessi per lo script
RUN chmod +x /aem/start-aem.sh

# Espone la porta 4502 per AEM Author
EXPOSE 4502

# Comando di avvio dello script start-aem.sh
CMD ["/aem/start-aem.sh", "author"]

# Stage 3: AEM Publish
FROM base AS publish

# Crea la directory per AEM
WORKDIR /aem

# Copia il file AEM Quickstart JAR, la licenza e lo script dalla directory principale del progetto
COPY aem-quickstart.jar /aem/aem-quickstart.jar
COPY license.properties /aem/license.properties
COPY start-aem.sh /aem/start-aem.sh
COPY install /aem/install

# Rinomina il file JAR per l'istanza Publish
RUN mv /aem/aem-quickstart.jar /aem/aem-publish-p4503.jar

# Imposta i permessi per lo script
RUN chmod +x /aem/start-aem.sh

# Espone la porta 4503 per AEM Publish
EXPOSE 4503

# Comando di avvio dello script start-aem.sh
CMD ["/aem/start-aem.sh", "publish"]
