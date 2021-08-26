![example workflow](https://github.com/dalmatialab/thingsboard/actions/workflows/main.yml/badge.svg)


# Supported tags and respective Dockerfile links

 - 2.4.3-rc-1

# What is Thingsboard ? 

[ThingsBoard](https://thingsboard.io/) is an open-source IoT platform that enables rapid development, management, and scaling of IoT projects. Our goal is to provide the out-of-the-box IoT cloud or on-premises solution that will enable server-side infrastructure for your IoT applications.

<img src="https://github.com/dalmatialab/thingsboard/blob/05e3734f2471346426cadd798c08d88c2146be76/logo.png?raw=true" width="350" height="150">

# How to use this image

## Start Thingsboard instance

    $ docker run -d --name some-thingsboard -e POSTGRESQL_HOST=postgre-host -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgre-host:5432/thingsboard   
    -e SPRING_DATASOURCE_USERNAME=username -e SPRING_DATASOURCE_PASSWORD=password -p 9090:9090 -p 1883:1883 -p 5683:5683/udpimage:tag

Where:

 - `some-thingsboard` is name you want to assign to your container
 - `postgre-host` is PostgreSQL endpoint at which Thingsboard is connecting
 - `username` is PostgreSQL username used to login in database
 - `password` is PostgreSQL password used to login in database
 - `image` is Docker image name
 - `tag` is Docker image version

## Environment variables

**POSTGRESQL_HOST**

This is required variable. It specifies PostgreSQL endpoint at which Thingsboard will connect.

**SPRING_DATASOURCE_URL**

This is required variable. It specifies datasource URL in PostgreSQL database and its format is 

    jdbc:postgresql://*POSTGRESQL_HOST*:5432/thingsboard

**SPRING_DATASOURCE_USERNAME**

This is *optional* variable. It specifies PostgreSQL username (default is `postgres`).

**SPRING_DATASOURCE_PASSWORD**

This is *required* variable. It specifies password for PostgreSQL use.

## Ports

Thingsboard exposes user interface at port 9090.  
Thingsboard exposes MQTT port 1883.  
Thingsboard exposed COAP port 5683.  

## Volumes

To save Thingsboard data mount container path `/data` to host path.  

    $ -v some-host-path:/data

## NOTE

This Thingsboard image enables usage of external PostgreSQL database, instead of database inside Thingsboard container in classic Thinsgboard Docker images.  

# License

