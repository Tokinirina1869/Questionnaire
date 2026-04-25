# =========================
# BUILD STAGE (Maven)
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

RUN mvn dependency:copy -Dartifact=org.postgresql:postgresql:42.6.0 -DoutputDirectory=/app/

COPY src/ ./src/

RUN mvn clean package -DskipTests

# =========================
# RUNTIME (WildFly)
# =========================
FROM quay.io/wildfly/wildfly:latest

# Admin user (optionnel)
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin.123 --silent

# Copier WAR DIRECTEMENT dans deployments
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/app.war

# PostgreSQL driver
COPY --from=build /app/postgresql-42.6.0.jar /opt/jboss/wildfly/standalone/deployments/

# Render / Cloud compatibility
ENV JBOSS_BIND_ADDRESS=0.0.0.0

EXPOSE 8080

# Important: Render injecte PORT dynamiquement
CMD ["/bin/sh", "-c", "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Djboss.http.port=${PORT:-8080}"]