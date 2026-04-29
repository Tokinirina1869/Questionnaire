<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Dans resultat.jsp --%>
<c:if test="${not empty param.succes}">
    <div id="toast-success" 
         class="fixed bottom-5 right-5 z-[100] flex items-center w-full max-w-xs p-4 
                text-gray-700 bg-white rounded-lg shadow-2xl border-l-4 border-green-800
                dark:bg-gray-800 dark:text-gray-300">
        
        <div class="ml-3 text-sm font-normal">
            <c:choose>
                <c:when test="${param.succes == 'email'}">Email envoyé avec succès !</c:when>
                <c:when test="${param.succes == 'delete'}">Etudiant supprimé sur la liste du classement !</c:when>
            </c:choose>
        </div>
        
        <button type="button" onclick="this.parentElement.remove()" class="ml-auto text-gray-400">
            <svg class="w-3 h-3" fill="none" viewBox="0 0 14 14"><path stroke="currentColor" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/></svg>
        </button>
    </div>

    <script>
        setTimeout(() => { document.getElementById('toast-success')?.remove(); }, 4000);
    </script>
</c:if>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>

    <jsp:include page="/navbar.jsp"/>

    <div class="container mx-auto p-6">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 dark:border-blue-400 pl-4">
                Classement des étudiants par ordre de mérite
            </h1>
        </div>
        
        <%-- 5. Adaptation de la carte et du tableau au mode sombre --%>
        <div class="bg-white dark:bg-gray-900 rounded-xl shadow-xl overflow-hidden border border-gray-200 dark:border-gray-800">
            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="bg-blue-800 dark:bg-blue-900 text-white text-center">
                        <tr>
                            <th class="py-4 px-2">Rang</th>
                            <th>Matricule</th>
                            <th>Nom et Prénom(s)</th>
                            <th>Adresse e-mail</th>
                            <th>Année</th>
                            <th>Note /10</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 dark:divide-gray-800"> 
                        <c:forEach var="ex" items="${examens}" varStatus="st">
                            <tr>
                                <td class="py-4 text-center">${st.count}</td>
                                <td class="text-center text-sm font-mono text-blue-600 dark:text-blue-400">${ex.etudiant.numEtudiant}</td>
                                <td class="text-center text-sm">${ex.etudiant.nom} ${ex.etudiant.prenoms}</td>
                                <td class="text-center text-sm italic text-gray-600 dark:text-gray-400">${ex.etudiant.email}</td>
                                <td class="text-center text-sm">${ex.anneeUniv}</td>
                                <td class="fw-bold text-center text-lg text-blue-700 dark:text-blue-300">${ex.note}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${ex.note == 0}">
                                            <span class="bg-amber-100 text-amber-700 text-[10px] font-bold px-2 py-1 rounded-full uppercase">
                                                <i class="fas fa-clock mr-1"></i>En cours
                                            </span>
                                        </c:when>
                                        <c:when test="${ex.note >= 5}">
                                            <span class="bg-green-100 text-green-700 text-[10px] font-bold px-2 py-1 rounded-full uppercase">
                                                Admis
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-red-100 text-red-700 text-[10px] font-bold px-2 py-1 rounded-full uppercase">
                                                Ajourné
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center flex justify-center gap-2 py-3">
                                    <c:choose>
                                        <%-- Cas : La note est à 0 (Examen non fait ou en cours) --%>
                                        <c:when test="${ex.note == 0}">
                                            <button onclick="alert('Action impossible : Examen en cours!')" 
                                                    class="bg-gray-400 cursor-not-allowed text-white text-xs px-3 py-1.5 rounded-lg">
                                                Envoyer
                                            </button>
                                        </c:when>

                                        <%-- Cas : L'examen est terminé (Note > 0) --%>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/examen?action=envoyer&numExam=${ex.numExam}"
                                            onclick="return confirm('Confirmer l\'envoi de la note (${ex.note}/10) à ${ex.etudiant.nom} ?')"
                                            class="bg-green-600 hover:bg-green-700 text-white text-xs px-3 py-1.5 rounded-lg transition-all shadow-sm">
                                                Envoyer
                                            </a>
                                        </c:otherwise>
                                    </c:choose>

                                    <%-- Bouton Supprimer (toujours actif) --%>
                                    <button onclick="deleteExam('${ex.numExam}')" 
                                            class="bg-red-600 hover:bg-red-700 text-white text-xs px-3 py-1.5 rounded-lg transition-all">
                                        Supprimer
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty examens}">
                            <tr>
                                <td colspan="8" class="text-center py-12 text-gray-500 dark:text-gray-400">
                                    Aucune données trouvée.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <script>
        function deleteExam(id){
            if(confirm("Voulez-vous vraiement supprimer cet étudiant " + id + " ?")){
                window.location.href = "<%= request.getContextPath() %>/examen?action=delete&id=" + id;
            }
        }
    </script>
</body>
</html>