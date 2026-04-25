FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src/ ./src/

RUN mvn clean package -DskipTests


FROM quay.io/wildfly/wildfly:latest

RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin.123 --silent

# ✅ ROOT deployment (IMPORTANT FIX)
COPY --from=build /app/target/*.war /opt/jboss/wildfly/standalone/deployments/ROOT.war

ENV JBOSS_BIND_ADDRESS=0.0.0.0
ENV JAVA_OPTS="-Xms128m -Xmx512m -XX:+UseG1GC -XX:+UseContainerSupport"

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:8080/ || exit 1

CMD ["/bin/sh", "-c", "/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -Djboss.http.port=${PORT:-8080}"]