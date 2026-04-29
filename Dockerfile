FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests

# --- Étape 2 : Configuration du serveur WildFly ---
FROM quay.io/wildfly/wildfly:latest

USER root

# Préparation du module PostgreSQL
RUN mkdir -p /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main
ADD https://jdbc.postgresql.org/download/postgresql-42.7.3.jar /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
RUN chown -R jboss:jboss /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/

# Nettoyage de la page d'accueil par défaut
RUN rm -rf /opt/jboss/wildfly/welcome-content/*

USER jboss

# 1. Écriture du script CLI simplifié
RUN echo 'embed-server -c=standalone.xml' > /tmp/config.cli && \
    # Ajout du driver
    echo '/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)' >> /tmp/config.cli && \
    # Ajout de la DataSource sans les flags de remplacement problématiques
    echo 'data-source add \
        --name=PostgreSQLDS \
        --jndi-name=java:jboss/datasources/PostgreSQLDS \
        --driver-name=postgresql \
        --driver-class=org.postgresql.Driver \
        --connection-url=jdbc:postgresql://${env.DB_HOST:db}:${env.DB_PORT:5432}/${env.DB_NAME:questionnaire} \
        --user-name=${env.DB_USER:toki} \
        --password=${env.DB_PASS:toki} \
        --enabled=true' >> /tmp/config.cli && \
    echo 'stop-embedded-server' >> /tmp/config.cli

# 2. Exécution du script CLI
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/tmp/config.cli && rm /tmp/config.cli

# 3. Nettoyage final de la configuration
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/*

# Déploiement du fichier WAR généré à l'étape 1
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/ROOT.war

EXPOSE 8080

# Lancement de WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]