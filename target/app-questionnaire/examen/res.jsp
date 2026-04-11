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
    <title>Résultat</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-gray-100 min-h-screen">
    <jsp:include page="/navbar.jsp"/>

    <main class="max-w-xl mx-auto p-6 mt-10">
        <div class="bg-gray-800 border border-gray-700 rounded-2xl p-8 text-center space-y-6">

            <!-- Note -->
            <div class="text-7xl font-bold <%= note >= 5 ? "text-green-400" : "text-red-400" %>">
                <%= note %>/10
            </div>

            <!-- Statut -->
            <div class="text-lg font-semibold">
                <% if (note >= 5) { %>
                    <span class="text-green-400">Réussi !</span>
                <% } else { %>
                    <span class="text-red-400">Ajourné</span>
                <% } %>
            </div>

            <!-- Infos -->
            <div class="text-sm text-gray-400 space-y-1">
                <p><span class="text-gray-300">Étudiant :</span>
                   <%= etu.getNom() %> <%= etu.getPrenoms() %></p>
                <p><span class="text-gray-300">Année :</span> <%= anneeUniv %></p>
            </div>

            <!-- Boutons -->
            <div class="flex gap-4 pt-4">
                <a href="<%= request.getContextPath() %>/examen?action=passer"
                   class="flex-1 py-3 bg-blue-600 hover:bg-blue-500
                          rounded-xl text-sm font-bold transition-all text-center">
                    Nouvel examen
                </a>
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