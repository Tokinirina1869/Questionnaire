package com.monapp.controller;

import java.io.IOException;
import java.util.List;

import com.monapp.model.Examen;
import com.monapp.service.ExamenService;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/etudiant/classement")
public class ClassementServlet extends HttpServlet {
    @Inject private ExamenService examService;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Examen> classements = examService.listerExamen(); 
        
        request.setAttribute("classements", classements);
        request.setAttribute("noteSession", request.getParameter("noteObtenue"));
        
        request.getRequestDispatcher("/resultatfinal.jsp").forward(request, response);
    }
}
