# --- Étape de Build ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests

# --- Étape Finale ---
FROM quay.io/wildfly/wildfly:latest

ENV DB_HOST=db \
    DB_PORT=5432 \
    DB_NAME=questionnaire \
    DB_USER=toki \
    DB_PASS=toki

USER root
# Installation du driver
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main
COPY postgresql-42.7.3.jar /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
RUN chown -R jboss:jboss /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/

USER jboss

# 1. On configure WildFly D'ABORD (sans l'application)
RUN /opt/jboss/wildfly/bin/standalone.sh -c standalone.xml -b 0.0.0.0 & \
    sleep 10 && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command="/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)" && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command="data-source add \
        --name=PostgreSQLDS \
        --jndi-name=java:jboss/datasources/PostgreSQLDS \
        --driver-name=postgresql \
        --driver-class=org.postgresql.Driver \
        --connection-url=jdbc:postgresql://\${env.DB_HOST}:\${env.DB_PORT}/\${env.DB_NAME} \
        --user-name=\${env.DB_USER} \
        --password=\${env.DB_PASS} \
        --validate-on-match=false \
        --background-validation=false \
        --enabled=true \
        --use-java-context=true" && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command=":shutdown"

RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/*

# 2. On copie l'application SEULEMENT ICI
# Comme WildFly est éteint à cette étape du RUN, il ne tentera pas de la déployer de suite
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/ROOT.war


EXPOSE 8080

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]