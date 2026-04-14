<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

    <main class="max-w-6xl mx-auto p-6 bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100 transition-colors duration-300">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4">
                Liste des Étudiants inscrits
            </h1>
            <a href="<%= request.getContextPath() %>/etudiants?action=add"
               class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg text-sm 
                      font-medium transition-all flex items-center gap-2">
                <span class="text-lg">+</span> Ajouter un étudiant
            </a>
        </div>

        <div class="border rounded-xl shadow-xl overflow-hidden">

            <!-- Barre de recherche -->
            <div class="p-4 border-b">
                <form method="GET" action="<%= request.getContextPath() %>/etudiants" 
                      class="flex gap-3">
                    <input type="hidden" name="action" value="search"/>
                    <input type="text" name="q" 
                        value="<%= request.getAttribute("query") != null 
                        ? request.getAttribute("query") : "" %>"
                        placeholder="Rechercher..."
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                    <button type="submit"
                            class="px-4 py-2 bg-blue-600 hover:bg-blue-700 rounded-lg text-sm 
                                   font-medium transition-colors flex items-center gap-2">
                        <i class="bi bi-search"></i> Rechercher
                    </button>
                </form>
            </div>

            <!-- Tableau -->
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="text-xs text-center">
                        <tr>
                            <th class="px-6 py-4">Matricule</th>
                            <th class="px-6 py-4">Nom & Prénoms</th>
                            <th class="px-6 py-4">Niveau</th>
                            <th class="px-6 py-4">Email</th>
                            <th class="px-6 py-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="devide-y">
                        <c:choose>
                            <c:when test="${not empty etudiants}">
                                <c:forEach var="e" items="${etudiants}" >
                                    <tr>
                                        <tr>
                                            <td class="px-6 py-4 font-mono text-blue-400 text-sm">
                                                ${e.numEtudiant}
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex flex-col">
                                                    <span class="font-medium">${e.nom}</span>
                                                    <span class="text-xs ">${e.prenoms}</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <span class="px-2 py-1 text-blue-300 rounded-md text-xs 
                                                            font-bold border border-blue-800/50">
                                                    ${e.niveau}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 text-sm italic">
                                                ${e.email}
                                            </td>
                                            <td class="px-6 py-4">
                                                <div class="flex justify-center items-center gap-3">
                                                    <!-- Bouton Modifier → edit.jsp -->
                                                    <a href="${pageContext.request.contextPath}/etudiants?action=edit&id=${e.numEtudiant}"
                                                    class="p-2 text-amber-400 hover:bg-amber-500/10 rounded-lg 
                                                            transition-colors" title="Modifier">
                                                        <i class="bi bi-pencil-square"></i>
                                                    </a>
                                                    <!-- Bouton Supprimer -->
                                                    <button onclick="deleteStudent('${e.numEtudiant}')"
                                                            class="p-2 text-red-400 hover:bg-red-500/10 rounded-lg 
                                                                transition-colors" title="Supprimer">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tr>
                                </c:forEach>
                            </c:when>

                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center text-gray-500">
                                        <div class="flex flex-col items-center gap-2">
                                            <i class="bi bi-folder2-open text-4xl"></i>
                                            <p>Aucun étudiant trouvé dans la base de données.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <% if(request.getAttribute("erreur") != null) { %>
        <div class="max-w-6xl mx-auto px-6 mb-4">
            <div class="p-4 bg-red-900/30 border border-red-700 rounded-lg text-red-400 text-sm flex items-center gap-2">
                <i class="bi bi-exclamation-circle"></i>
                <%= request.getAttribute("erreur") %>
            </div>
        </div>
    <% } %>
    
    <script>
        function deleteStudent(id) {
            if (confirm("Voulez-vous vraiment supprimer l'étudiant " + id + " ?")) {
                window.location.href = "<%= request.getContextPath() %>/etudiants?action=delete&id=" + id;
            }
        }
    </script>
</body>
</html>