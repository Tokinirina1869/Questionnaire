<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${param.succes == 'email'}">
    <div class="mb-4 p-4 bg-green-100 dark:bg-green-900/30 border border-green-400 
                rounded-lg text-green-700 dark:text-green-300 text-sm">
        Email envoyé avec succès !
    </div>
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
                            <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                                <td class="py-4 text-center font-bold">${st.count}</td>
                                <td class="text-center text-sm font-mono text-blue-600 dark:text-blue-400">${ex.etudiant.numEtudiant}</td>
                                <td class="text-center text-sm font-medium">${ex.etudiant.nom} ${ex.etudiant.prenoms}</td>
                                <td class="text-center text-sm italic text-gray-600 dark:text-gray-400">${ex.etudiant.email}</td>
                                <td class="text-center text-sm">${ex.anneeUniv}</td>
                                <td class="fw-bold text-center text-lg text-blue-700 dark:text-blue-300">${ex.note}</td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${ex.note >= 5}">
                                            <span class="bg-green-100 text-green-800 text-xs px-2 py-1 rounded-full dark:bg-green-900 dark:text-green-300">Admis</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-red-100 text-red-800 text-xs px-2 py-1 rounded-full dark:bg-red-900 dark:text-red-300">Ajourné</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center flex justify-between">
                                    <a href="${pageContext.request.contextPath}/examen?action=envoyer&numExam=${ex.numExam}"
                                        onclick="return confirm('Envoyer la note à ${ex.etudiant.nom} ?')"
                                        class="bg-green-600 hover:bg-green-700 text-white text-xs 
                                            px-3 py-1.5 rounded-lg transition-all inline-block">
                                        Envoyer
                                    </a>
                                    <button class="bg-red-600 hover:bg-green-700 text-white text-xs
                                        px-3 py-1.5 rounded-lg transition-all inline-block">
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
    
</body>
</html>