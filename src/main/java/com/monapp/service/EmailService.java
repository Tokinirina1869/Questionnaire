package com.monapp.service;

import jakarta.ejb.Stateless;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@Stateless
public class EmailService {
    private final String EXPEDITEUR = "roberttokinirina@gmail.com";
    private final String Mdp        = "ljor tgeh pklk zoxe";

    public void envoyerNote(String destinataire, String nomEtudiant, int note, String anneeUniv)
    {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(EXPEDITEUR, Mdp);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EXPEDITEUR));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));

            message.setSubject("Résultat de votre examen QCM --" + anneeUniv);

            String contenu =
                "<h2>Résultat de votre examen</h2>" +
                "<p>Bonjour <strong>" + nomEtudiant + "</strong>,</p>" +
                "<p>La note théorique obtenue pour l'année universitaire <strong>" + anneeUniv +
                "</strong> est :</p>" +
                "<h1 style='color:" + (note >= 5 ? "green" : "red") + "'>" +
                note + " / 10</h1>" +
                "<p>" + (note >= 5 ? "Félicitations, vous êtes <strong>Admis</strong> !"
                                   : "Vous avez besoin des <strong>efforts</strong>.") +
                "</p>";

                message.setContent(contenu, "text/html; charset=UTF-8");
                Transport.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void send(String destinataire, String sujet, String messageTexte){
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(EXPEDITEUR, Mdp);
            }
        });


        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EXPEDITEUR));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinataire));
            
            // On utilise le sujet et le contenu passés en paramètres
            message.setSubject(sujet);
            
            // Format HTML simple pour l'alerte
            String contenu = 
                "<div style='font-family: Arial, sans-serif; border: 1px solid #ddd; padding: 20px;'>" +
                "<h2 style='color: #d9534f;'>🚨 Alerte Sécurité Système</h2>" +
                "<p>" + messageTexte + "</p>" +
                "<hr/>" +
                "<footer style='font-size: 0.8em; color: #777;'>Généré automatiquement par qcm.app</footer>" +
                "</div>";

            message.setContent(contenu, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("Alerte SSL envoyée à : " + destinataire);

        } catch (Exception e) {
            System.err.println("Erreur lors de l'envoi de l'alerte : " + e.getMessage());
            e.printStackTrace();
        }

    }
}
