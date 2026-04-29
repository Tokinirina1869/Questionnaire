<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Qcm" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${not empty param.succes}" >
    <div id="toast-success"
        class="fixed bottom-5 right-5 z-[100] flex items-center w-full max-w-xs p-4
            text-gray-700 bg-white rounded-lg shadow-2xl border-l-4 border-green-800
            dark:bg-gray-800 dark:text-gray-300">
        <div class="ml-3 text-sm font-normal">
            <c:choose>
                <c:when test="${param.succes == 'add'}">Ajout de nouvelle question avec succès !</c:when>
                <c:when test="${param.succes == 'edit'}">Question modifiée aves succès !</c:when>
                <c:when test="${param.succes == 'delete'}">Question supprimée avec réussite !</c:when>
            </c:choose>
        </div>
        <button type="button" onclick="this.parentElement.remove()" class="ml-auto text-gray-400">
            <svg class="w-3 h-3" fill="none" viewBox="0 0 14 14"><path stroke="currentColor" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/></svg>
        </button>
    </div>
    <script>
        setTimeout(()  => { document.getElementById('toast-success')?.remove(); }, 5000);
    </script>
</c:if>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <jsp:include page="/navbar.jsp" />
    
    <main class="mx-auto p-6">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4">
                Bibliothèque de Questions
            </h1>
            <a href="<%= request.getContextPath() %>/qcm?action=add"
               class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg text-sm 
                      font-medium transition-all flex items-center gap-2">
                <span class="text-lg">+</span> Ajouter une question
            </a>
        </div>

        <div class="bg-white dark:bg-gray-900 rounded-xl shadow-xl overflow-hidden border border-gray-200 dark:border-gray-800">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-blue-800 dark:bg-blue-900 text-white text-center">
                        <th class="px-6 py-4">Questions</th>
                        <th class="px-6 py-4">Réponses</th>
                        <th class="px-6 py-4">Bonne Réponse</th>
                        <th class="px-6 py-4">Actions</th>
                    </thead>
                    <tbody class="devide-y">
                        <%
                            List<Qcm> listeQcm = (List<Qcm>) request.getAttribute("qcm");
                            if (listeQcm != null && !listeQcm.isEmpty()) {
                                for(Qcm item : listeQcm) {
                        %>
                        <tr>
                            <td class="px-6 py-4 text-sm text-center"> 
                                <%= item.getQuestion() %>   
                            </td>
                            <td class="px-6 py-4 text-sm text-center">
                                1-<%= item.getReponse1() %> <span class="p-1">|</span>
                                2-<%= item.getReponse2() %> <span class="p-1">|</span>
                                3-<%= item.getReponse3() %> <span class="p-1">|</span>
                                4-<%= item.getReponse4() %> 
                            </td>
                            <td class="px-6 py-4 text-sm text-center">
                                <%= item.getBonneReponse() %> 
                            </td>
                            <td class="px-6 py-4 text-sm text-center">
                                <div class="flex justify-center items-center gap-3">
                                    <a href="<%= request.getContextPath() %>/qcm?action=edit&id=<%= item.getNumQuest() %>"
                                         class="p-2 text-amber-400 hover:bg-amber-500/10 rounded-lg tracking-colors" title="Modifier">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <button onclick="deleteQcm('<%= item.getNumQuest() %>')" class="p-2 text-red-400 hover:bg-red-500/10 rounded-lg transitions-colors" title="Supprimer">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %> 
                            <tr>
                                <td colspan="4" class="px-6 py-12 text-center text-gray-500">
                                    <div class="flex flex-col items-center gap-2">
                                        <i class="bi bi-folder2-open text-4xl"></i>
                                        <p>Aucune question trouvée dans la base de données.</p>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script>
        function deleteQcm(id){
            if(confirm("Voulez-vous vraiement supprimer cette question " + id + " ?")){
                window.location.href = "<%= request.getContextPath() %>/qcm?action=delete&id=" + id;
            }
        }

    </script>
</body>
</html>