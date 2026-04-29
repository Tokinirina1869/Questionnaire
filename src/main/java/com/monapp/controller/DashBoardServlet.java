package com.monapp.controller;

import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import com.monapp.service.QcmService;
import com.monapp.service.ExamenService;
import java.io.IOException;
import com.monapp.service.EtudiantService;

@WebServlet("/dashboard")
public class DashBoardServlet extends HttpServlet {

    @Inject 
    private QcmService qService;

    @Inject 
    private ExamenService examService;

    @Inject
    private EtudiantService etuService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try {
            Long nbrEtu     = etuService.countEtudiant();
            Long nbrExam    = examService.countExamen();
            Long nbrQcm     = qService.countQcm();

            request.setAttribute("totalEtu", nbrEtu);
            request.setAttribute("totalExam", nbrExam);
            request.setAttribute("totalQcm", nbrQcm);

            // Dans le doGet...
            Long moins5 = examService.moin5();
            Long plus5  = examService.plus5();
            Double moyenne = examService.moyenne();

            request.setAttribute("moins5", moins5);
            request.setAttribute("plus5", plus5);
            request.setAttribute("moyenneG", moyenne != null ? Math.round(moyenne * 100.0) / 100.0 : 0);

            request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
