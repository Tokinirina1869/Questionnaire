package com.monapp.controller;

import com.monapp.model.Etudiant;
import com.monapp.model.Examen;
import com.monapp.model.Qcm;
import com.monapp.service.EtudiantService;
import com.monapp.service.ExamenService;
import com.monapp.service.QcmService;
import com.monapp.service.EmailService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/examen")
public class ExamenServlet extends HttpServlet {
    @Inject
    private QcmService qService;
    @Inject
    private EtudiantService etuService;
    @Inject
    private ExamenService examService;
    @Inject
    private EmailService emailService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse reponse)
        throws ServletException, IOException
    {
        String action = request.getParameter("action");
        
        // 1. Récupérer uniquement les étudiants approuvés
        List<Etudiant> etudiantsApprouves = etuService.lister().stream()
                                                    .filter(Etudiant::isApprouve)
                                                    .collect(Collectors.toList());

        // 2. Récupérer les questions (10 aléatoires)
        List<Qcm> questions = qService.dixQuestionsAleatoires();
        if (questions == null) questions = new ArrayList<>();

        // 3. Préparation des attributs pour la JSP
        request.setAttribute("etudiants", etudiantsApprouves);
        request.setAttribute("questions", questions);

        if ("resultats".equals(action)) {
            request.setAttribute("examens", examService.listerExamen());
            request.getRequestDispatcher("/examen/resultat.jsp").forward(request, reponse);
        }
        else if ("envoyer".equals(action)) {
            // Logique d'envoi d'email
            try {
                Integer numExam = Integer.parseInt(request.getParameter("numExam"));
                Examen examen = examService.trouverParId(numExam);
                emailService.envoyerNote(examen.getEtudiant().getEmail(), 
                                       examen.getEtudiant().getNom(), 
                                       examen.getNote(), 
                                       examen.getAnneeUniv());
                reponse.sendRedirect(request.getContextPath() + "/examen?action=resultats&succes=email");
            } catch (Exception e) {
                reponse.sendRedirect(request.getContextPath() + "/examen?action=resultats&erreur=email");
            }
        }
        else if ("delete".equals(action)) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            examService.supprimerExam(id);
            reponse.sendRedirect(request.getContextPath() + "/examen?action=resultats&succes=delete");
        }
        else {
            // Action "passer" ou par défaut
            request.getRequestDispatcher("/examen/passer.jsp").forward(request, reponse);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String[] idsEtudiants = request.getParameterValues("ids_etudiants");
        String anneeUniv = request.getParameter("annee_univ");
        
        // Dans ExamenServlet.java -> doPost
        if (idsEtudiants != null) {
            for (String id : idsEtudiants) {
                Etudiant etu = etuService.rechercherParNum(id);
                // On met 0 pour éviter l'erreur SQLState: 23514
                Examen assignation = new Examen(etu, anneeUniv, 0); 
                examService.ajouterExamen(assignation);
            }
        }
        response.sendRedirect(request.getContextPath() + "/examen?action=resultats&succes=publie");
    }
}
