<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Qcm" %>

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
    
    <main class="max-w-6xl mx-auto p-6">
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

        <div class="border shadow-xl overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="text-xs text-center">
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