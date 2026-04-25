# --- Étape de Build ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests

# --- Étape Finale ---
FROM quay.io/wildfly/wildfly:latest

# On utilise les variables de Render
USER root

# Téléchargement automatique du driver (pour éviter l'erreur "file not found")
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main
ADD https://jdbc.postgresql.org/download/postgresql-42.7.3.jar /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
RUN chown -R jboss:jboss /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/

# NETTOYAGE CRUCIAL : on vire la page "Welcome to WildFly"
RUN rm -rf /opt/jboss/wildfly/welcome-content/*

USER jboss

# Configuration CLI (identique à la tienne)
RUN /opt/jboss/wildfly/bin/standalone.sh -c standalone.xml -b 0.0.0.0 & \
    sleep 10 && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command="/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)" && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command="data-source add --name=PostgreSQLDS --jndi-name=java:jboss/datasources/PostgreSQLDS --driver-name=postgresql --driver-class=org.postgresql.Driver --connection-url=jdbc:postgresql://\${env.DB_HOST}:\${env.DB_PORT}/\${env.DB_NAME} --user-name=\${env.DB_USER} --password=\${env.DB_PASS} --enabled=true" && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command=":shutdown"

RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/*

# Déploiement en ROOT pour l'accès direct via l'URL Render
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/ROOT.war

EXPOSE 8080
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]