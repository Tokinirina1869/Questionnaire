package com.monapp.controller;

import com.monapp.model.Etudiant;
import com.monapp.service.EtudiantService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/etudiants")
public class EtudiantServlet extends HttpServlet{
    @Inject
    private EtudiantService service;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse response)
        throws ServletException, IOException
    //{} <> 
    {
        List<Etudiant> etudiants = service.lister();
        req.setAttribute("etudiants", etudiants);
        req.getRequestDispatcher("/webapp/etudiants/List.jsp").forward(req, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException    
    {
        String numEtudiant  = request.getParameter("num_etudiant");
        String nom          = request.getParameter("nom");
        String prenoms      = request.getParameter("prenoms");
        String niveau       = request.getParameter("niveau");
        String adrEmail     = request.getParameter("adrEmail");

        Etudiant e = new Etudiant(numEtudiant, nom, prenoms, niveau, adrEmail);
        service.ajouter(e);
        response.sendRedirect("etudiants");
    }

}
