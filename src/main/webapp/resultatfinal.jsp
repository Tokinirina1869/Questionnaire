<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Classement Final - Ordre de Mérite</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="bg-gray-900 text-white min-h-screen">

    <jsp:include page="/navbar.jsp" />

    <main class="max-w-7xl mx-auto p-8">
        <c:if test="${not empty noteSession}">
            <div class="bg-green-600/20 border border-green-500 p-6 rounded-2xl mb-8 text-center">
                <h2 class="text-xl font-semibold text-green-400">Examen terminé !</h2>
                <p class="text-3xl font-bold mt-2">Votre note : ${noteSession} / 10</p>
            </div>
        </c:if>

        <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold italic text-blue-400">
                <i class="bi bi-trophy-fill mr-3"></i>Ordre de Mérite
            </h1>
        </div>

        <div class="overflow-hidden rounded-xl border border-gray-700 bg-gray-800 shadow-xl">
            <table class="w-full text-left">
                <thead class="bg-gray-700/50 text-gray-300 uppercase text-sm">
                    <tr>
                        <th class="px-6 py-4 text-center">Rang</th>
                        <th class="px-6 py-4">Étudiant</th>
                        <th class="px-6 py-4">Année Universitaire</th>
                        <th class="px-6 py-4 text-right">Note Final</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-700">
                    <c:forEach var="exam" items="${classements}" varStatus="status">
                        <tr class="${status.first ? 'bg-yellow-600/10' : ''} hover:bg-gray-750 transition-colors">
                            <td class="px-6 py-4 text-center">
                                <c:choose>
                                    <c:when test="${status.count == 1}">
                                        <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-yellow-500 text-black font-bold">1</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-gray-400">${status.count}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="px-6 py-4 font-medium">
                                ${exam.etudiant.nom} ${exam.etudiant.prenoms}
                            </td>
                            <td class="px-6 py-4 text-gray-400">
                                ${exam.anneeUniv}
                            </td>
                            <td class="px-6 py-4 text-right">
                                <span class="text-lg font-bold ${exam.note >= 5 ? 'text-green-400' : 'text-red-400'}">
                                    ${exam.note} / 10
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>

</body>
</html>