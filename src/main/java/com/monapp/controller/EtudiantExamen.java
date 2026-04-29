package com.monapp.controller;

import java.io.IOException;
import java.util.List;

import com.monapp.model.Etudiant;
import com.monapp.model.Examen;
import com.monapp.model.Qcm;
import com.monapp.service.ExamenService;
import com.monapp.service.QcmService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/etudiant/passer-examen")
public class EtudiantExamen extends HttpServlet {
    @Inject private QcmService qService;
    @Inject private ExamenService examService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Etudiant etu = (Etudiant) request.getSession().getAttribute("utilisateurConnecte");

        if (etu == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Enregistrer l'heure de début en session si c'est la première fois qu'on charge l'examen
        if (request.getSession().getAttribute("startTime") == null) {
            request.getSession().setAttribute("startTime", System.currentTimeMillis());
        }

        Examen examenEnAttente = examService.trouverExamenActif(etu.getNumEtudiant());

        if (examenEnAttente != null) {
            List<Qcm> questions = qService.dixQuestionsAleatoires();
            if (questions != null && !questions.isEmpty()) {
                request.getSession().setAttribute("questions", questions);
                request.setAttribute("numExam", examenEnAttente.getNumExam());
                request.setAttribute("annee_univ", examenEnAttente.getAnneeUniv());
                request.getRequestDispatcher("/etudiants/question.jsp").forward(request, response);
            } else {
               
                System.out.println("LOG DEBUG: Liste de questions vide pour l'étudiant " + etu.getNumEtudiant());
                response.sendRedirect(request.getContextPath() + "nonacces");
                return; 
            }
        } else {
            response.sendRedirect("/nonacces");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int numExam = Integer.parseInt(request.getParameter("numExam"));
        String[] numQuests = request.getParameterValues("num_quest");
        int noteCalculée = 0;

        if (numQuests != null) {
            for (String idQ : numQuests) {
                Qcm q = qService.trouverParId(Integer.parseInt(idQ));
                String repChoisie = request.getParameter("reponse_" + idQ);

                if (repChoisie != null && Integer.parseInt(repChoisie) == q.getBonneReponse()) {
                    noteCalculée++;
                }
            }
        }

        long startTime = (Long) request.getSession().getAttribute("startTime");
        long currentTime = System.currentTimeMillis();
        long duration = (currentTime - startTime) / 1000 / 60; // en minutes

        if (duration > 11) { // 1 minute de marge pour la latence réseau
            // Forcer le traitement ou rejeter si trop tard
            System.out.println("LOG WARN: Soumission tardive détectée.");
        }
        request.getSession().removeAttribute("startTime"); // Nettoyage
        
        // UPDATE : On récupère l'examen créé par l'admin (qui avait 0)
        Examen examEnBase = examService.trouverParId(numExam);
        examEnBase.setNote(noteCalculée);
        
        examService.modifierExamen(examEnBase);

        response.sendRedirect(request.getContextPath() + "/etudiant/classement?noteObtenue=" + noteCalculée);
    }

}
