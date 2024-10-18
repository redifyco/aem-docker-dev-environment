# AEM local development Docker Setup

This project uses Docker to configure two AEM instances (Author and Publish) along with a Dispatcher based on Apache HTTP Server (in progress). 
Everything is orchestrated via Docker Compose. Common resources like the JDK file and startup script are centralized to avoid duplication.
Potentially this configuration can work with any version of AEM on premise, we are using it for AEM 6.5 and place specific service packs in install folder.

It is possible to auto-install packages on startup by placing the ZIP packages in the `install` folder.

## Steps to start
Put jdk file with same name (or you have to change configuration reference), jar file and license in the root 

## Folder structure:

- **docker-aem/**
- - **install/**
  - **logs/**
    - **author/**  
    - **publish/**
  - **dispatcher/**
    - Dockerfile
    - dispatcher-apache2.4-4.3.7.so
    - httpd.conf
  - jdk-11_linux-x64_bin.tar.gz  # Shared JDK file
  - start-aem.sh                 # Shared startup script
  - docker-compose.yml
  - license.properties
  - aem-quickstart.jar
  - Dockerfile                   # Multistage configuration

## In Progress

We are currently working on the dispatcher configuration to improve automation during development and 
a dedicated development environment specific for cloud as a service local instance. 

