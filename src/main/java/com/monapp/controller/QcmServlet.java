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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            request.getRequestDispatcher("/qcm/add.jsp").forward(request, response);
            return; 
        } 
        
        if ("edit".equals(action)) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            Qcm q = qService.trouverParId(id);
            request.setAttribute("qcm", q);
            request.getRequestDispatcher("/qcm/edit.jsp").forward(request, response);
            return;
        }

        if ("delete".equals(action)) {
            Integer id = Integer.parseInt(request.getParameter("id"));
            qService.supprimerQcm(id);
            response.sendRedirect(request.getContextPath() + "/qcm");
            return;
        }

        List<Qcm> listeQcm = qService.listerQcm();
        request.setAttribute("qcm", listeQcm);
        request.getRequestDispatcher("/qcm/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8"); // Sécurité pour les accents
        String action = request.getParameter("action");
        
        try {
            if ("ajouter".equals(action) || "modifier".equals(action)) {
                String question = request.getParameter("question");
                String reponse1 = request.getParameter("reponse1");
                String reponse2 = request.getParameter("reponse2");
                String reponse3 = request.getParameter("reponse3");
                String reponse4 = request.getParameter("reponse4");
                String brRaw = request.getParameter("bonne_reponse");

                if (brRaw != null && !brRaw.isEmpty()) {
                    int bonneReponse = Integer.parseInt(brRaw);
                    Qcm qcm = new Qcm(question, reponse1, reponse2, reponse3, reponse4, bonneReponse);
                    
                    if ("ajouter".equals(action)) {
                        qService.ajouterQcm(qcm);
                    } else {
                        // Pour la modification, n'oubliez pas de récupérer l'ID si nécessaire
                        String idRaw = request.getParameter("num_quest");
                        if (idRaw != null) {
                            qcm.setNumQuest(Integer.parseInt(idRaw));
                        }
                        qService.modifierQcm(qcm);
                    }
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/qcm");
    }

}
