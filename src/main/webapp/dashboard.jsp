<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script>
        tailwind.config = { darkMode: 'class' };
    </script>
</head>
<body class="bg-white dark:bg-gray-800 transition-colors duration-300">
    <jsp:include page="/navbar.jsp"/>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 p-6">

        <!-- Total Étudiants -->
        <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-md border-b-4 border-blue-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm text-gray-500 uppercase font-bold">Nombre total des étudiants</p>
                    <h3 class="text-3xl font-black text-gray-800 dark:text-white">
                        ${not empty totalEtu ? totalEtu : 0}
                    </h3>
                </div>
                <div class="p-3 bg-blue-100 rounded-full text-blue-600">
                    <i class="bi bi-people-fill text-2xl"></i>
                </div>
            </div>
            <p class="text-xs text-gray-400 mt-4">Inscrits dans la base de données</p>
        </div>

        <!-- Examens réalisés -->
        <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-md border-b-4 border-green-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm text-gray-500 uppercase font-bold">Total des étudiants passés à l'examen</p>
                    <h3 class="text-3xl font-black text-gray-800 dark:text-white">
                        ${not empty totalExam ? totalExam : 0}
                    </h3>
                </div>
                <div class="p-3 bg-green-100 rounded-full text-green-600">
                    <i class="bi bi-journal-check text-2xl"></i>
                </div>
            </div>
            <p class="text-xs text-gray-400 mt-4">Etudiants inscrits uniquement peuvent le passer!</p>
        </div>

        <!-- Banque de Questions -->
        <div class="bg-white dark:bg-gray-800 p-6 rounded-xl shadow-md border-b-4 border-purple-500">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-sm text-gray-500 uppercase font-bold">Total de Questions dans la base</p>
                    <h3 class="text-3xl font-black text-gray-800 dark:text-white">
                        ${not empty totalQcm ? totalQcm : 0}
                    </h3>
                </div>
                <div class="p-3 bg-purple-100 rounded-full text-purple-600">
                    <i class="bi bi-question-circle-fill text-2xl"></i>
                </div>
            </div>
            <p class="text-xs text-gray-400 mt-4">Questions disponibles pour les tests</p>
        </div>

    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 m-5">
        <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow-md">
            <h2 class="text-xl font-bold mb-4 text-gray-800 dark:text-white">Répartition des données</h2>
            <div class="mx-auto" style="position: relative; height: 300px; width: 300px;">
                <canvas id="myChart"></canvas>
            </div>
        </div>

        <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow-md">
            <h2 class="text-xl font-bold mb-4 text-gray-800 dark:text-white text-center">
                Moyenne Générale : <span class="text-blue-500">${moyenneG}/10</span>
            </h2>
            <div class="mx-auto" style="position: relative; height: 300px; width: 300px;">
                <canvas id="reussiteChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        const ctx = document.getElementById('myChart');

        new Chart(ctx, {
            type: 'doughnut', // Tu peux mettre 'bar', 'pie' ou 'doughnut'
            data: {
                labels: ['Étudiants', 'Examens', 'Questions QCM'],
                datasets: [{
                    label: 'Quantité',
                    // On récupère ici les variables que ta Servlet a envoyé
                    data: ["${totalEtu}", "${totalExam}","${totalQcm}"],
                    backgroundColor: [
                        'rgba(59, 130, 246, 0.8)', // Bleu (Etu)
                        'rgba(34, 197, 94, 0.8)',  // Vert (Exam)
                        'rgba(168, 85, 247, 0.8)'  // Violet (Qcm)
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            color: 'gray'
                        }
                    }
                }
            }
        });
    </script>

    <script>
        const ctx2 = document.getElementById('reussiteChart');
        new Chart(ctx2, {
            type: 'pie',
            data: {
                labels: ['Moins de 5', 'Plus de 5'],
                datasets: [{
                    data: ["${moins5}", "${plus5}"], // Utilisation des guillemets pour éviter l'erreur de syntaxe
                    backgroundColor: ['#ef4444', '#22c55e'], // Rouge et Vert Tailwind
                }]
            },
            options: {
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });
    </script>
</body>
</html>