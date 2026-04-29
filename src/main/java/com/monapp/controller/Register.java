package com.monapp.controller;
import java.io.IOException;
import java.util.List;

import com.monapp.model.Admin;
import com.monapp.model.Etudiant;
import com.monapp.service.AdminService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class Register extends HttpServlet {

    @Inject
    private AdminService service;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        // CAS 2 : INSCRIPTION D'UN NOUVEL ADMIN (Action venant de register.jsp)
        String nom = request.getParameter("nom");
        String email = request.getParameter("adr_email");
        String mdp = request.getParameter("password");
        String confirm = request.getParameter("confirm_password");

        if (mdp == null || !mdp.equals(confirm)) {
            request.setAttribute("erreur", "Les mots de passe ne correspondent pas.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            Admin nouvelAdmin = new Admin();
            nouvelAdmin.setNomAdmin(nom); 
            nouvelAdmin.setEmailAdmin(email);
            nouvelAdmin.setMdpAdmin(mdp);
            nouvelAdmin.setApprouve(false); 
            
            service.inscrireAdmin(nouvelAdmin);
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=en_attente");
            
        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors de l'inscription : " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
