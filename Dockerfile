# Étape 1 — Build avec Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

# On télécharge et on COPIE le driver explicitement dans /app/
RUN mvn dependency:copy -Dartifact=org.postgresql:postgresql:42.6.0 -DoutputDirectory=/app/

COPY src/ ./src/
RUN mvn clean package -DskipTests

# Étape 2 — WildFly
FROM quay.io/wildfly/wildfly:latest

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin.123 --silent

# Correction des chemins de copie
COPY --from=build /app/target/*.war /tmp/app-questionnaire.war
# Note : Maven nomme le fichier "postgresql-42.6.0.jar" par défaut dans outputDirectory
COPY --from=build /app/postgresql-42.6.0.jar /opt/jboss/wildfly/standalone/deployments/

EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]