<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>
    <main class="p-6">
        <div id="alert-examen" class="max-w-7xl mx-auto mb-6 flex items-center p-4 text-orange-800 border-l-4 border-orange-500 bg-orange-100 rounded-r-lg shadow-md animate-pulse">
            <i class="bi bi-exclamation-triangle-fill text-2xl mr-3"></i>
            <div class="flex-1">
                <p class="font-bold">Accès non autorisé</p>
                <p class="text-sm">Désolé, aucun examen n'a été activé pour votre compte par l'administrateur pour le moment.</p>
            </div>
            <button onclick="this.parentElement.remove()" class="ml-auto text-orange-600 hover:text-orange-900">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </main>
    
</body>
</html>