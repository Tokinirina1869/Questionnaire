<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Qcm" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%
    List<Qcm> questions    = (List<Qcm>) request.getAttribute("questions");
    List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
    
    if (questions == null || etudiants == null) {
        out.println("<div style='color:white; background:red; padding:20px;'>");
        out.println("Erreur fatale : Les données (questions ou étudiants) sont absentes.<br>");
        out.println("Assurez-vous d'accéder à la page via <b>/examen?action=passer</b> et non directement au fichier .jsp");
        out.println("</div>");
        return; 
    }
    
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

    <main class="max-w-3xl mx-auto p-6">
        <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4 mb-8">
            Assignation d'un nouvel examen
        </h1>

        <form method="POST" action="<%= request.getContextPath() %>/examen" class="space-y-6">
            <div class="border rounded-xl p-5 space-y-4 bg-white shadow-sm">
                <h2 class="font-semibold text-blue-600 flex items-center">
                    <i class="fas fa-bullhorn mr-2"></i>Étudiants concernés
                </h2>
                
                <div class="space-y-2 max-h-48 overflow-y-auto border border-gray-200 p-3 rounded-lg bg-gray-50">
                    <label class="flex items-center gap-2 font-bold text-sm mb-2 border-b pb-2 text-gray-700">
                        <input type="checkbox" id="select-all" onclick="toggleAll(this)"> 
                        Sélectionner tout le groupe (<%= etudiants.size() %>)
                    </label>
                    <% for (Etudiant e : etudiants) { %>
                        <label class="flex items-center gap-3 p-2 hover:bg-blue-50 rounded-md cursor-pointer">
                            <input type="checkbox" name="ids_etudiants" value="<%= e.getNumEtudiant() %>" class="etu-checkbox">
                            <span class="text-sm"><%= e.getNom() %> <%= e.getPrenoms() %></span>
                        </label>
                    <% } %>
                </div>

                <div>
                    <label class="text-xs font-bold uppercase text-gray-500">Session / Année</label>
                    <input type="text" name="annee_univ" required placeholder="Ex: 2025-2026"
                        class="w-full px-4 py-2.5 rounded-lg text-sm border border-gray-300 focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>

                <button type="submit" 
                        class="py-3 w-full text-white font-bold bg-indigo-600 hover:bg-indigo-700 transition-all rounded-lg shadow-md">
                    <i class="fas fa-paper-plane mr-2"></i>Publier l'examen pour ces étudiants
                </button>
            </div>
        </form>
    </main>
    
    <script>
        function toggleAll(source) {
            const checkboxes = document.querySelectorAll('.etu-checkbox');
            checkboxes.forEach(cb => cb.checked = source.checked);
        }
    </script>
</body>
</html>