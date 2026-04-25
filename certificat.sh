#!/bin/bash
# Automatisation de la surveillance SSL pour questionnaire-iqzw.onrender.com

DOMAIN="questionnaire-iqzw.onrender.com"
EXPIRY_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

# Conversion en timestamp
EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s)
NOW_EPOCH=$(date +%s)
DAYS_LEFT=$(( ($EXPIRY_EPOCH - $NOW_EPOCH) / 86400 ))

echo "Le certificat pour $DOMAIN expire le $EXPIRY_DATE"
echo "Il reste $DAYS_LEFT jours."

if [ $DAYS_LEFT -lt 15 ]; then
    echo "ALERTE : Renouvellement nécessaire ou échec de l'automate Render !"
    # Ici, ajouter une commande pour envoyer un mail ou un log critique
else
    echo "Statut : Sécurisé."
fi
