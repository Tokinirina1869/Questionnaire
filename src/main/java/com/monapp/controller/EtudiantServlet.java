package com.monapp.controller;

import com.monapp.model.Etudiant;
import com.monapp.service.EtudiantService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/etudiants")
public class EtudiantServlet extends HttpServlet {

    @Inject
    private EtudiantService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException 
    {

        try {
            String action = req.getParameter("action");

            if ("add".equals(action)) {
                // → ouvre le formulaire vide
                req.getRequestDispatcher("/etudiants/add.jsp")
                   .forward(req, response);

            } 
            else if ("edit".equals(action)) {
                // → récupère l'étudiant et ouvre edit.jsp
                String id  = req.getParameter("id");
                Etudiant e = service.rechercherParNum(id); 
                req.setAttribute("etudiant", e);
                req.getRequestDispatcher("/etudiants/edit.jsp")
                   .forward(req, response);

            } 
            else if ("delete".equals(action)) {
                // → supprime et redirige vers la liste
                String id  = req.getParameter("id");       
                Etudiant e = service.rechercherParNum(id); 
                service.supprimer(e);                      
                response.sendRedirect(req.getContextPath() + "/etudiants");

            } 
            else {
                List<Etudiant> etudiants = service.lister();
                req.setAttribute("etudiants", etudiants);
                req.getRequestDispatcher("/etudiants/list.jsp")
                   .forward(req, response);
            }

        } 
        catch (Exception e) {
            e.printStackTrace();

            String messageErreur = "";

            if ("add".equals(req.getParameter("action"))) {
                messageErreur = "Impossible d'ouvrir le formulaire d'ajout.";
            }
            else if ("edit".equals(req.getParameter("action"))) {
                messageErreur = "Impossible de charger l'étudiant à modifier."
                                + "Vérifiez que le numéro existe!";
            }

            else if ("delete".equals(req.getParameter("action"))) {
                messageErreur = "Impossible de supprimer l'étudiant."
                                + "Il peut-être lié à un examen.";
            }
            
            else {
                messageErreur = "Impossible de charger la liste des étudiants.";
            }

            req.setAttribute("erreur", messageErreur);
            req.setAttribute("etudiants", new java.util.ArrayList<>());
            req.getRequestDispatcher("/etudiants/list.jsp").forward(req, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {

        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            String numEtudiant = request.getParameter("num_etudiant");
            String nom         = request.getParameter("nom");
            String prenoms     = request.getParameter("prenoms");
            String niveau      = request.getParameter("niveau");
            String adrEmail    = request.getParameter("adr_email");

            Etudiant e = new Etudiant(numEtudiant, nom, prenoms, niveau, adrEmail);
            service.ajouter(e);

        } else if ("modifier".equals(action)) {
            String numEtudiant = request.getParameter("num_etudiant");
            String nom         = request.getParameter("nom");
            String prenoms     = request.getParameter("prenoms");
            String niveau      = request.getParameter("niveau");
            String adrEmail    = request.getParameter("adr_email");

            Etudiant e = new Etudiant(numEtudiant, nom, prenoms, niveau, adrEmail);
            service.modifier(e);
        }

        response.sendRedirect(request.getContextPath() + "/etudiants");
        
    }
}