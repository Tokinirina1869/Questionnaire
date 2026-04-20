<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${not empty param.succes}" >
    <div id="toast-success"
        class="fixed bottom-5 right-5 z-[100] flex items-center w-full max-w-xs p-4
            text-gray-700 bg-white rounded-lg shadow-2xl border-l-4 border-green-800
            dark:bg-gray-800 dark:text-gray-300">
        <div class="ml-3 text-sm font-normal">
            <c:choose>
                <c:when test="${param.succes == 'add'}">Ajout de nouveau étudiant avec succès !</c:when>
                <c:when test="${param.succes == 'edit'}">Information d'un étudiant modifié !</c:when>
                <c:when test="${param.succes == 'delete'}">Etudiant supprimé dans la base de données !</c:when>
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
                            class="px-4 py-2 bg-blue-600 text-white hover:bg-blue-700 rounded-lg text-sm 
                                   font-medium transition-colors flex items-center gap-2">
                        <i class="bi bi-search"></i> Rechercher
                    </button>
                </form>
            </div>

            <!-- Tableau -->
            <div class="space-y-4 p-4">
                <c:choose>
                    <c:when test="${not empty groupes}">
                        <%-- On boucle sur la Map : 'entry.key' est le Niveau, 'entry.value' est la Liste d'étudiants --%>
                        <c:forEach var="entry" items="${groupes}">
                            
                            <details class="group bg-white dark:bg-gray-800 dark:text-gray-100 border border-slate-800 rounded-xl overflow-hidden shadow-lg" open>
                                <summary class="flex items-center justify-between p-5 cursor-pointer transition-all list-none">
                                    <span class="text-lg font-bold tracking-wide">${entry.key}</span>
                                    
                                    <div class="flex items-center gap-4">
                                        <%-- Affichage dynamique du nombre d'étudiants via fn:length --%>
                                        <span class="bg-blue-600 text-white px-4 py-1 rounded-full text-xs font-bold border">
                                            ${fn:length(entry.value)} étudiants
                                        </span>
                                        <i class="bi bi-chevron-down text-slate-500 group-open:rotate-180 transition-transform"></i>
                                    </div>
                                </summary>

                                <div class="px-5 pb-5 border-t border-slate-800/50 bg-white dark:bg-gray-900 dark:text-gray-100 text-gray-900">
                                    <table class="w-full text-left mt-4">
                                        <thead class="text-gray-600 dark:text-gray-400 text-lg hover:bg-gray-100 dark:hover:bg-gray-800">
                                            <tr>
                                                <th class="pb-3 text-center font-semibold">N° Matricule</th>
                                                <th class="pb-3 text-center font-semibold">Nom</th>
                                                <th class="pb-3 text-center font-semibold">Prénoms</th>
                                                <th class="pb-3 text-center font-semibold text-center">Email</th>
                                                <th class="pb-3 text-center font-semibold text-right">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-800/50">
                                            <c:forEach var="e" items="${entry.value}">
                                                <tr class="group/row transition-colors">
                                                    <td class="py-4 text-center font-mono text-blue-400 text-sm">${e.numEtudiant}</td>
                                                    <td class="py-4 text-center uppercase text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800">${e.nom}</td>
                                                    <td class="py-4 text-center text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800">${e.prenoms}</td>
                                                    <td class="py-4 text-center text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800 text-sm text-center">${e.email}</td>
                                                    <td class="py-4 text-center">
                                                        <div class="flex justify-end gap-4">
                                                            <a href="?action=edit&id=${e.numEtudiant}" 
                                                                class="text-amber-500/80 hover:text-amber-400 transition-colors">
                                                                <i class="bi bi-pencil-square text-lg"></i>
                                                            </a>
                                                            <button onclick="deleteStudent('${e.numEtudiant}')" 
                                                                    class="text-red-500/80 hover:text-red-400 transition-colors">
                                                                <i class="bi bi-trash text-lg"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </details>
                            
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="text-center py-20 bg-slate-900 rounded-xl border border-dashed border-slate-800">
                            <p class="text-slate-500">Aucune donnée disponible.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
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