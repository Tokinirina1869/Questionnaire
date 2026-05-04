package com.monapp.controller;

import com.monapp.model.Admin;
import com.monapp.model.Etudiant;
import com.monapp.repository.AdminRepository;
import com.monapp.repository.EtudiantRepository;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Inject
    private AdminRepository adminRepo;

    @Inject
    private EtudiantRepository etudiantRepo;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String role = request.getParameter("role");

        if ("admin".equals(role)) {
            Admin admin = adminRepo.findByEmail(email);
            
            if (admin != null && BCrypt.checkpw(password, admin.getMdpAdmin())) {
                if (admin.isApprouve()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", admin);
                    session.setAttribute("role", "ADMIN");
                    response.sendRedirect(request.getContextPath() + "/admin-gestion");
                    return; 
                } 
                else {
                    request.setAttribute("erreur", "Votre compte est en attente d'approbation.");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                    return;
                }
            } else {
                echecConnexion(request, response);
                return;
            }
        } 

        else if ("etudiant".equals(role)) {
            Etudiant etu = etudiantRepo.findByEmail(email);
            
            if (etu != null && BCrypt.checkpw(password, etu.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("utilisateurConnecte", etu); 
                session.setAttribute("role", "ETUDIANT");
                response.sendRedirect(request.getContextPath() + "/etudiant/passer-examen");
                return;
            } 
            else {
                request.setAttribute("erreur", "Email ou mot de passe incorrect.");
                request.getRequestDispatcher("/login").forward(request, response);
                return;
            }
        }else {
            request.setAttribute("erreur", "Veuillez sélectionner un rôle valide.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void echecConnexion(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        req.setAttribute("erreur", "Email ou mot de passe incorrect.");
        req.getRequestDispatcher("/login.jsp").forward(req, res);
    }
}