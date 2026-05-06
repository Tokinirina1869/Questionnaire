package com.monapp.controller;

import com.monapp.service.EmailService;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.inject.Inject;
import javax.net.ssl.HttpsURLConnection;
import java.net.URL;
import java.security.cert.X509Certificate;
import java.util.Date;
import java.util.concurrent.TimeUnit;

@Singleton
public class SSLMonitoringService {
    @Inject
    private EmailService ServiceMail;

    @Schedule(hour = "*", minute = "36", second = "0", timezone = "Indian/Antananarivo", persistent = false)
    public void checkSSLValidity(){
        try {
            URL url = new URL("https://questionnaire-iqzw.onrender.com/");
            HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
            conn.connect();

            X509Certificate cert = (X509Certificate) conn.getServerCertificates()[0];
            long diff = cert.getNotAfter().getTime() - new Date().getTime();
            long daysLeft = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);

            if (daysLeft < 15) {
                ServiceMail.send(
                    "roberttokinirina@gmail.com", 
                    "CRITIQUE : Expiration SSL imminente", 
                    "Le certificat pour l'application expire dans " + daysLeft + " jours. Vérifiez l'automatisation Render."
                );
            } 
            else {
                
                ServiceMail.send(
                    "roberttokinirina@gmail.com", 
                    "Audit SSL Quotidien - OK", 
                    "Le certificat est validé. Jours restants : " + daysLeft
                );
            }
            
            conn.disconnect();
        } 
        catch (Exception e) {
            
            ServiceMail.send(
                "roberttokinirina@gmail.com",
                "⚠️ ERREUR : Échec du monitoring SSL",
                "Impossible de vérifier le certificat SSL : " + e.getMessage()
            );
            e.printStackTrace();
        }
    }

    @PostConstruct
    public void init() {
        if (ServiceMail == null) {
            System.err.println("ERREUR CRITIQUE : EmailService n'a pas pu être injecté !");
        } else {
            System.out.println("EmailService injecté avec succès.");
            checkSSLValidity();
        }
    }
}
