FROM thingsboard/openjdk8
LABEL maintainer="dalmatialab"

RUN apt-get update && apt-get install -y nmap wget

COPY conf/logback.xml conf/thingsboard.conf src/start-db.sh src/stop-db.sh start-tb.sh src/upgrade-tb.sh src/install-tb.sh /tmp/

RUN chmod a+x /tmp/*.sh \
    && mv /tmp/start-tb.sh /usr/bin \
    && mv /tmp/upgrade-tb.sh /usr/bin \
    && mv /tmp/install-tb.sh /usr/bin \
    && mv /tmp/start-db.sh /usr/bin \
    && mv /tmp/stop-db.sh /usr/bin

ENV THINGSBOARD_VERSION=2.4.3
RUN apt update && apt install wget -y

RUN wget -P /tmp https://github.com/thingsboard/thingsboard/releases/download/v${THINGSBOARD_VERSION}/thingsboard-${THINGSBOARD_VERSION}.deb


RUN dpkg -i /tmp/thingsboard-${THINGSBOARD_VERSION}.deb

RUN systemctl --no-reload disable --now thingsboard.service > /dev/null 2>&1 || :

RUN mv /tmp/logback.xml /usr/share/thingsboard/conf && mv /tmp/thingsboard.conf /usr/share/thingsboard/conf

ENV DATA_FOLDER=/data

ENV HTTP_BIND_PORT=9090
ENV DATABASE_TS_TYPE=sql
ENV DATABASE_ENTITIES_TYPE=sql

ENV POSTGRESQL_HOST=172.17.0.2
ENV POSTGRESQL_PORT=5432

ENV SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.PostgreSQLDialect
ENV SPRING_DRIVER_CLASS_NAME=org.postgresql.Driver
ENV SPRING_DATASOURCE_URL="jdbc:postgresql://$POSTGRESQL_HOST:$POSTGRESQL_PORT/thingsboard"
ENV SPRING_DATASOURCE_USERNAME=postgres
ENV SPRING_DATASOURCE_PASSWORD=postgres

EXPOSE 9090
EXPOSE 1883
EXPOSE 5683/udp

VOLUME ["/data"]

RUN apt-get update && apt install -y postgresql-client

CMD ["start-tb.sh"]
