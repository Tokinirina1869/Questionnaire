# Étape 1 — Build avec Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ ./src/
RUN mvn clean package -DskipTests

# Étape 2 — WildFly officiel
FROM quay.io/wildfly/wildfly:latest

# Création de l'utilisateur admin
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin.123 --silent

# IMPORTANT : On ne met PAS le war dans /deployments pour éviter le déploiement précoce
COPY --from=build /app/target/*.war /tmp/app-questionnaire.war

EXPOSE 8080 9990
# Le CMD est géré par le docker-compose pour inclure la configuration CLI

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
