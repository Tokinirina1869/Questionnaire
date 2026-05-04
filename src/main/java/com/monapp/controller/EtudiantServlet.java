package com.monapp.controller;

import com.monapp.model.Admin;
import com.monapp.model.Etudiant;
import com.monapp.service.EtudiantService;

import jakarta.ejb.EJBTransactionRolledbackException;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/etudiants")
public class EtudiantServlet extends HttpServlet {

    @Inject
    private EtudiantService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = req.getParameter("action");
            HttpSession session = req.getSession(false);
            String role = (session != null) ? (String) session.getAttribute("role") : null;

            if ("add".equals(action)) {
                String prochainNum = service.generateProchainNum();
                req.setAttribute("prochainNum", prochainNum);
                req.getRequestDispatcher("/etudiants/add.jsp").forward(req, response);

            }
            else if ("edit".equals(action)) {
                String idParam = req.getParameter("id");

                if (session == null) {
                    response.sendRedirect(req.getContextPath() + "/login");
                    return;
                }

                // ADMIN peut modifier n'importe quel étudiant
                if ("ADMIN".equals(role)) {
                    Etudiant e = service.rechercherParNum(idParam);
                    if (e != null) {
                        req.setAttribute("etudiant", e);
                        req.getRequestDispatcher("/etudiants/edit.jsp").forward(req, response);
                    } else {
                        response.sendRedirect(req.getContextPath() + "/etudiants?erreur=not_found");
                    }
                    return;
                }

                // ETUDIANT ne peut modifier que son propre compte
                Etudiant utilisateurLogge = (Etudiant) session.getAttribute("utilisateurConnecte");
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

                if (idParam == null || idParam.isBlank()) {
                    response.sendRedirect(req.getContextPath() + "/etudiants?erreur=invalid_id");
                    return;
                }

                if (session == null) {
                    response.sendRedirect(req.getContextPath() + "/login");
                    return;
                }

                try {
                    // ADMIN supprime n'importe quel étudiant
                    if ("ADMIN".equals(role)) {
                        Etudiant e = service.rechercherParNum(idParam);
                        if (e != null) {
                            service.supprimer(e);
                            response.sendRedirect(req.getContextPath() + "/etudiants?succes=deleted");
                        } else {
                            response.sendRedirect(req.getContextPath() + "/etudiants?erreur=not_found");
                        }
                        return;
                    }

                    // ETUDIANT supprime uniquement son propre compte
                    Etudiant utilisateurLogge = (Etudiant) session.getAttribute("utilisateurConnecte");
                    if (utilisateurLogge != null && utilisateurLogge.getNumEtudiant().equals(idParam)) {
                        service.supprimer(utilisateurLogge);
                        session.invalidate();
                        response.sendRedirect(req.getContextPath() + "/login?succes=account_deleted");
                    } else {
                        response.sendRedirect(req.getContextPath() + "/etudiants?erreur=delete_forbidden");
                    }

                } catch (EJBTransactionRolledbackException e) {
                    response.sendRedirect(req.getContextPath() + "/etudiants?erreur=delete_linked");
                }
            }
            else if ("search".equals(action)) {
                String q = req.getParameter("q");
                req.setAttribute("etudiants", service.rechercher(q));
                req.setAttribute("query", q);
                req.getRequestDispatcher("/etudiants/list.jsp").forward(req, response);
            }
            else {
                List<Etudiant> etudiants = service.lister();
                Map<String, List<Etudiant>> groupes = etudiants.stream()
                        .filter(e -> e.getNiveau() != null)
                        .collect(Collectors.groupingBy(Etudiant::getNiveau));
                req.setAttribute("groupes", groupes);
                req.getRequestDispatcher("/etudiants/listApprouve.jsp").forward(req, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erreur", "Une erreur est survenue : " + e.getMessage());
            req.setAttribute("etudiants", new java.util.ArrayList<>());
            req.getRequestDispatcher("/etudiants/list.jsp").forward(req, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        if ("approuver_etudiant".equals(action) || "rejeter_etudiant".equals(action)) {
            if (id != null && !id.isEmpty()) {
                if ("approuver_etudiant".equals(action)) {
                    service.approuverEtudiant(id);
                } else {
                    service.rejeterEtudiant(id);
                }
                response.sendRedirect(request.getContextPath() + "/admin-gestion");
                return;
            }
        }

        // ── Inscription / Modification ──
        String numEtudiant = request.getParameter("num_etudiant");
        String nom         = request.getParameter("nom");
        String prenoms     = request.getParameter("prenoms");
        String niveau      = request.getParameter("niveau");
        String adrEmail    = request.getParameter("adr_email");
        String mdp         = request.getParameter("password");
        String confirm     = request.getParameter("confirm_password");

        if (numEtudiant == null || numEtudiant.trim().isEmpty() || "0000 H-F".equals(numEtudiant)) {
            numEtudiant = service.generateProchainNum();
        }

        if ("ajouter".equals(action) && (mdp == null || !mdp.equals(confirm))) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.setAttribute("prochainNum", numEtudiant);
            request.getRequestDispatcher("/etudiants/add.jsp").forward(request, response);
            return;
        }

        try {
            Etudiant e = new Etudiant(numEtudiant, nom, prenoms, niveau, adrEmail, mdp);

            if ("ajouter".equals(action)) {
                HttpSession session = request.getSession(false);
                String role = (session != null) ? (String) session.getAttribute("role") : null;

                e.setApprouve(false);
                service.ajouter(e);

                if ("ADMIN".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/login");
                } else {
                    // Auto-inscription → rediriger vers login
                    response.sendRedirect(request.getContextPath() + "/login?inscription=success");
                }

            } else if ("modifier".equals(action)) {
                service.modifier(e);

                HttpSession session = request.getSession(false);
                String role = (session != null) ? (String) session.getAttribute("role") : null;

                // Si ADMIN modifie → retour liste étudiants
                if ("ADMIN".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/etudiants?succes=edit");
                } else {
                    // Étudiant modifie son propre profil → retour à son espace
                    response.sendRedirect(request.getContextPath() + "/etudiants?succes=edit");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("erreur", "Erreur base de données : " + ex.getMessage());
        }
    }
}