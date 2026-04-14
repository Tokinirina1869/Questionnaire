<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%
    Integer note     = (Integer) request.getAttribute("note");
    Etudiant etu     = (Etudiant) request.getAttribute("etudiant");
    String anneeUniv = (String) request.getAttribute("anneeUniv");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <jsp:include page="/navbar.jsp"/>

    <main class="max-w-xl mx-auto p-6 mt-10">
        <div class="border rounded-2xl p-8 text-center space-y-6">

            <!-- Note -->
            <div class="text-7xl font-bold text-green-400">
                
            </div>

            <!-- Statut -->
            <div class="text-lg font-semibold">
                <span class="text-green-400">Réussi !</span>
            </div>

            <!-- Infos -->
            <div class="text-sm space-y-1">
                <p><span class="text-gray-300">Étudiant :</span>
                   <%= etu.getNom() %> <%= etu.getPrenoms() %></p>
                <p><span>Année :</span> <%= anneeUniv %></p>
            </div>

            <!-- Boutons -->
            <div class="flex gap-4 pt-4">
                <a href="<%= request.getContextPath() %>/examen?action=resultats"
                   class="flex-1 py-3 bg-gray-700 hover:bg-gray-600
                          rounded-xl text-sm font-medium transition-all text-center">
                    Voir tous les résultats
                </a>
            </div>
        </div>
    </main>
</body>
</html>