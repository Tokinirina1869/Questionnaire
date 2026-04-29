package com.monapp.controller;

import com.monapp.model.Etudiant;
import com.monapp.service.EtudiantService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

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
                String prochainNum = service.generateProchainNum();

                req.setAttribute("prochainNum", prochainNum);
        
                req.getRequestDispatcher("/etudiants/add.jsp")
                   .forward(req, response);

            } 
            else if ("edit".equals(action)) {
                String idParam = req.getParameter("id");
                
                HttpSession session = req.getSession();
                Etudiant utilisateurLogge = (Etudiant) session.getAttribute("utilisateurConnecte");

                // 2. Vérifier : Est-ce que l'ID demandé est MON ID ?
                if (utilisateurLogge != null && utilisateurLogge.getNumEtudiant().equals(idParam)) {
                    Etudiant e = service.rechercherParNum(idParam); 
                    req.setAttribute("etudiant", e);
                    req.getRequestDispatcher("/etudiants/edit.jsp").forward(req, response);
                } else {
                    response.sendRedirect(req.getContextPath() + "/etudiants?erreur=access_denied");
                }
            } 
            else if ("delete".equals(action)) {
                String idParam = req.getParameter("id");
                HttpSession session = req.getSession();
                Etudiant utilisateurLogge = (Etudiant) session.getAttribute("utilisateurConnecte");

                // Vérification de sécurité
                if (utilisateurLogge != null && utilisateurLogge.getNumEtudiant().equals(idParam)) {
                    Etudiant e = service.rechercherParNum(idParam); 
                    service.supprimer(e);                      
                    
                    // Comme il a supprimé son propre compte, on le déconnecte
                    session.invalidate(); 
                    response.sendRedirect(req.getContextPath() + "/login?succes=account_deleted");
                } else {
                    // Tentative de suppression d'un autre compte
                    response.sendRedirect(req.getContextPath() + "/etudiants?erreur=delete_forbidden");
                }
            }
            else if ("search".equals(action)) {
                String q = req.getParameter("q");
                req.setAttribute("etudiants", service.rechercher(q));
                req.setAttribute("query", q);
                req.getRequestDispatcher("/etudiants/list.jsp")
                    .forward(req, response);
                return;
            }
            else {
                List<Etudiant> etudiants = service.lister();
                Map<String, List<Etudiant>> groupes = etudiants.stream()
                            .filter(e -> e.getNiveau() != null) // On ignore ceux qui n'ont pas de niveau
                            .collect(Collectors.groupingBy(Etudiant::getNiveau));
                req.setAttribute("groupes", groupes);
                req.getRequestDispatcher("/etudiants/listApprouve.jsp")
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
        String id = request.getParameter("id");

        if (action != null && (action.equals("approuver_etudiant") || action.equals("rejeter_etudiant"))) {
            if (id != null && !id.isEmpty()) {
                if ("approuver_etudiant".equals(action)) {
                    service.approuverEtudiant(id);
                } else if ("rejeter_etudiant".equals(action)) {
                    service.rejeterEtudiant(id);
                }
                
                response.sendRedirect(request.getContextPath() + "/admin-gestion"); 
                return; 
            }
        }

        // --- 2. GESTION DU FORMULAIRE (INSCRIPTION / MODIFICATION) ---
        // Ce code ne s'exécute QUE si on n'est pas dans le bloc précédent (grâce au return)
        String numEtudiant = request.getParameter("num_etudiant");
        String nom         = request.getParameter("nom");
        String prenoms     = request.getParameter("prenoms");
        String niveau      = request.getParameter("niveau"); 
        String adrEmail    = request.getParameter("adr_email");
        String mdp         = request.getParameter("password");
        String confirm     = request.getParameter("confirm_password");

        // Génération automatique du matricule si vide
        if (numEtudiant == null || numEtudiant.trim().isEmpty() || "0000 H-F".equals(numEtudiant)) {
            numEtudiant = service.generateProchainNum();
        }

        // Vérification des mots de passe
        if ("ajouter".equals(action) && (mdp == null || !mdp.equals(confirm))) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.setAttribute("prochainNum", numEtudiant); 
            request.getRequestDispatcher("/etudiants/add.jsp").forward(request, response);
            return;
        }

        try {
            Etudiant e = new Etudiant(numEtudiant, nom, prenoms, niveau, adrEmail, mdp);

            if ("ajouter".equals(action)) {
                // IMPORTANT : L'étudiant s'inscrit, il n'est PAS encore approuvé
                e.setApprouve(false); 
                service.ajouter(e);
                response.sendRedirect(request.getContextPath() + "/login?inscription=success");
            } 
            else if ("modifier".equals(action)) {
                service.modifier(e);
                response.sendRedirect(request.getContextPath() + "/etudiants?succes=edit");
            }
        
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", "Erreur base de données : " + ex.getMessage());
        }
    }

}