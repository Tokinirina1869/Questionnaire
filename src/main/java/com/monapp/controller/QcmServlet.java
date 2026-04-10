package com.monapp.controller;

import com.monapp.model.Qcm;
import com.monapp.service.QcmService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/qcm")
public class QcmServlet extends HttpServlet {
    @Inject
    private QcmService qService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        String action = request.getParameter("action");
        
        if ("ajouter".equals(action)) {
            String question = request.getParameter("question");
            String reponse1 = request.getParameter("reponse1");
            String reponse2 = request.getParameter("reponse2");
            String reponse3 = request.getParameter("reponse3");
            String reponse4 = request.getParameter("reponse4");
            String br = request.getParameter("bonne_reponse");
            Integer bonneReponse = (br != null) ? Integer.parseInt(br) : null;

            Qcm qcm = new Qcm(question, reponse1, reponse2, reponse3, reponse4, bonneReponse);
            qService.ajouterQcm(qcm);
        }
    }

}
