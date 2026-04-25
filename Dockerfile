# =========================
# BUILD STAGE (Maven)
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ ./src/

RUN mvn clean package -DskipTests

# =========================
# RUNTIME (WildFly)
# =========================
FROM quay.io/wildfly/wildfly:latest

# Admin user (optionnel)
RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin.123 --silent

# Deploy WAR
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/app.war

# PostgreSQL driver (si utilisé)
COPY --from=build /app/target/lib/postgresql-42.6.0.jar /opt/jboss/wildfly/standalone/deployments/

# =========================
# CLOUD CONFIG (IMPORTANT)
# =========================

ENV JBOSS_BIND_ADDRESS=0.0.0.0
ENV JAVA_OPTS="-Xms128m -Xmx512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UseContainerSupport"

EXPOSE 8080

# Healthcheck compatible cloud
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:8080/ || exit 1

# Render nécessite PORT dynamique
CMD ["/bin/sh", "-c", "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Djboss.http.port=${PORT:-8080} -c standalone.xml -bmanagement 0.0.0.0"]