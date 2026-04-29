package com.monapp.controller;

import com.monapp.model.Admin;
import com.monapp.model.Etudiant;
import com.monapp.service.AdminService;
import com.monapp.service.EtudiantService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.inject.Inject;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-gestion")
public class AdminServlet extends HttpServlet {

    @Inject
    private AdminService service;

    @Inject
    private EtudiantService etu;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        List<Admin> admins = service.listeAdmin();

        List<Etudiant> etudiants = etu.lister();

        request.setAttribute("listeAdmins", admins);
        request.setAttribute("listeEtudiants", etudiants);
        request.getRequestDispatcher("/approbation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        
        // Log pour debugger dans ta console IDE
        System.out.println("Action reçue : " + action + " pour ID : " + id);

        if ("approuver_admin".equals(action)) {
            if (id != null && !id.isEmpty()) {
                Long idLong = Long.parseLong(id);
                service.approuverAdmin(idLong); 
                response.sendRedirect(request.getContextPath() + "/admin-gestion");
                return; 
            }
        } 
        
        if ("rejeter_admin".equals(action)) { 
            if (id != null && !id.isEmpty()) {
                Long idLong = Long.parseLong(id);
                service.rejeterAdmin(idLong);
                response.sendRedirect(request.getContextPath() + "/admin-gestion");
                return;
            }
        }
    }
}