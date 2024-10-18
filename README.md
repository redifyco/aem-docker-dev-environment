This project uses Docker to configure two AEM instances (Author and Publish) along with a Dispatcher based on Apache HTTP Server (in progress). 
Everything is orchestrated via Docker Compose. Common resources like the JDK file and startup script are centralized to avoid duplication.
Is it possible to auto-install packages on startup by putting zip packages in install folder.

Folder structure:

docker-aem/
├── install/ # Put files here to auto-install
├── logs/
│   ├── author/ 
│   ├── publish/ 
├── dispatcher/
│   ├── Dockerfile
│   ├── dispatcher-apache2.4-4.3.7.so
│   └── httpd.conf
├── jdk-11_linux-x64_bin.tar.gz   # Shared JDK file
├── start-aem.sh                  # Shared startup script
├── docker-compose.yml
└── Dockerfile                    #multistage configuration



We are working on dispatcher configuration to improve automation during development.
