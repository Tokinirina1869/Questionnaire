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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.List;

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

           
        List<Qcm> questions = qService.dixQuestionsAleatoires();            
        List<Etudiant> etudiants = etuService.lister();

        // Debug console
        System.out.println("Service QCM injecté ? " + (qService != null));
        System.out.println("Nombre de questions récupérées: " + (questions != null ? questions.size() : "NULL"));
        
        if (questions == null) questions = new ArrayList<>();
        if (etudiants == null) etudiants = new ArrayList<>();

        request.setAttribute("questions", questions);
        request.setAttribute("etudiants", etudiants);

        if ("passer".equals(action)) {
            request.getRequestDispatcher("/examen/passer.jsp")
                    .forward(request, reponse);
        }
        else if ("envoyer".equals(action)) {
            Integer numExam = Integer.parseInt(request.getParameter("numExam"));
            Examen examen   = examService.trouverParId(numExam);

            String email    = examen.getEtudiant().getEmail();
            String nom      = examen.getEtudiant().getNom() + " "
                            + examen.getEtudiant().getPrenoms();
            int note        = examen.getNote();
            String anneeUniv = examen.getAnneeUniv();

            emailService.envoyerNote(email, nom, note, anneeUniv);

            reponse.sendRedirect(request.getContextPath()
                    + "/examen?action=resultats&succes=email");
            return;
        }
        else if ("resultats".equals(action)) {
            request.setAttribute("examens", examService.listerExamen());
            request.getRequestDispatcher("/examen/resultat.jsp").forward(request, reponse);
        }
        else {
            request.getRequestDispatcher("/examen/passer.jsp")
                    .forward(request, reponse);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String numEtudiant  = request.getParameter("num_etudiant");
        String anneeUniv    = request.getParameter("annee_univ");
        Etudiant etudiant   = etuService.rechercherParNum(numEtudiant); 
        
        String[] numQuests  = request.getParameterValues("num_quest");
        int note = 0;

        for (String numQuest : numQuests) {
            Integer idQuestion  = Integer.parseInt(numQuest);
            Qcm question        = qService.trouverParId(idQuestion);
            String reponseDonne = request.getParameter("reponse_" + numQuest);

            if (reponseDonne != null) {
                int repInt = Integer.parseInt(reponseDonne);

                // Comparer avec la bonneReponse
                if (repInt == question.getBonneReponse()) {
                    note++;
                }
            }
        }

        // Save in BD

        Examen exam = new Examen(etudiant, anneeUniv, note);
        examService.ajouterExamen(exam);

        request.setAttribute("note", note);
        request.setAttribute("etudiant", etudiant);
        request.setAttribute("anneeUniv", anneeUniv);
        request.getRequestDispatcher("/examen/res.jsp")
                .forward(request, response);
    }
    
}
