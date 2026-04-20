#!/bin/bash
echo "👀 Surveillance des fichiers src/..."

while inotifywait -r -e modify,create,delete ./src; do
  echo "🔨 Changement détecté..."
  ./deploy.sh

  sleep 5
  
done