<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
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

<script>
    let timeLeft = 10 * 60; 
    const timerElement = document.getElementById('timer');
    const examForm = document.getElementById('examForm'); // Ajoute id="examForm" à ta balise <form>
    const submitBtn = document.getElementById('submitBtn');
    let isSubmitted = false;

    // Gestion du compte à rebours
    const countdown = setInterval(function() {
        let minutes = Math.floor(timeLeft / 60);
        let seconds = timeLeft % 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        timerElement.innerHTML = minutes + ":" + seconds;

        if (timeLeft <= 0) {
            clearInterval(countdown);
            if (!isSubmitted) {
                autoSubmit();
            }
        }
        timeLeft--;
    }, 1000);

    // Fonction de soumission
    function autoSubmit() {
        isSubmitted = true;
        submitBtn.disabled = true;
        submitBtn.innerHTML = "Traitement en cours...";
        examForm.submit();
    }

    // Événement lors du clic sur le bouton "Valider"
    examForm.addEventListener('submit', function(e) {
        if (isSubmitted) return; // Évite les doubles clics
        
        isSubmitted = true;
        submitBtn.disabled = true; // Désactive le bouton immédiatement
        submitBtn.innerHTML = "Soumission envoyée...";
        
        // On laisse le temps s'écouler visuellement, le navigateur 
        // chargera la page de résultat dès que le serveur répondra.
    });

    // Protection contre le retour arrière
    window.onbeforeunload = function() {
        if (timeLeft > 0 && !isSubmitted) {
            return "L'examen n'est pas encore validé !";
        }
    };
</script>
<body>

    <jsp:include page="/navbar.jsp" />


    <div class="fixed top-20 right-6 bg-red-600 text-white px-4 py-2 rounded-full font-bold shadow-lg z-50">
        <i class="bi bi-clock-history mr-2"></i> Temps restant : <span id="timer">10:00</span>
    </div>

    <main class="max-w-3xl mx-auto p-6">
        <h1 class="text-2xl font-bold mb-6">
            Examen Session : <c:out value="${annee_univ}" />
        </h1>

        <%-- Vérification si la liste est vide --%>
        <c:if test="${empty questions}">
            <div class="bg-red-500 text-white p-4 rounded-lg">
                Erreur : Aucune question n'a été chargée.
            </div>
        </c:if>

        <form method="POST" action="${pageContext.request.contextPath}/etudiant/passer-examen">
            <input type="hidden" name="numExam" value="${numExam}">

            <c:forEach var="q" items="${questions}" varStatus="loop">
                <div class="border border-gray-700 rounded-xl p-5 mb-4 bg-gray-800 shadow-sm text-white">
                    <input type="hidden" name="num_quest" value="${q.numQuest}">
                    
                    <p class="font-medium mb-4 text-blue-400">
                        Q${loop.count}. <c:out value="${q.question}" />
                    </p>

                    <div class="space-y-2">
                        <%-- Boucle pour les 4 réponses --%>
                        <label class="flex items-center gap-3 p-3 rounded-lg border border-gray-600 hover:bg-gray-700 cursor-pointer">
                            <input type="radio" name="reponse_${q.numQuest}" value="1" >
                            <span><c:out value="${q.reponse1}" /></span>
                        </label>
                        <label class="flex items-center gap-3 p-3 rounded-lg border border-gray-600 hover:bg-gray-700 cursor-pointer">
                            <input type="radio" name="reponse_${q.numQuest}" value="2">
                            <span><c:out value="${q.reponse2}" /></span>
                        </label>
                        <label class="flex items-center gap-3 p-3 rounded-lg border border-gray-600 hover:bg-gray-700 cursor-pointer">
                            <input type="radio" name="reponse_${q.numQuest}" value="3">
                            <span><c:out value="${q.reponse3}" /></span>
                        </label>
                        <label class="flex items-center gap-3 p-3 rounded-lg border border-gray-600 hover:bg-gray-700 cursor-pointer">
                            <input type="radio" name="reponse_${q.numQuest}" value="4">
                            <span><c:out value="${q.reponse4}" /></span>
                        </label>
                    </div>
                </div>
            </c:forEach>

            <button type="submit" id="submitBtn" class="w-full py-3 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-xl transition-all">
                Valider mes réponses
            </button>
        </form>
    </main>
</body>
</html>