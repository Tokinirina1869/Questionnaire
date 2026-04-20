#!/bin/bash
echo "Build Maven..."
mvn clean package -DskipTests

if [ $? -eq 0 ]; then
  echo "📦 Copie du WAR dans le conteneur..."
  docker cp target/*.war wildfly-app:/opt/jboss/wildfly/standalone/deployments/app-questionnaire.war
  echo "✅ WildFly recharge automatiquement !"
else
  echo "❌ Erreur de build !"
fi
