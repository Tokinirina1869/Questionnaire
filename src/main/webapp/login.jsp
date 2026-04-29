<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${not empty erreur}">
    <div class="animate-bounce p-4 mb-4 bg-red-50 border-l-4 border-red-500 rounded-xl shadow-sm flex items-center gap-3">
        <div class="flex-shrink-0 w-10 h-10 bg-red-100 rounded-full flex items-center justify-center">
            <i class="bi bi-x-circle-fill text-red-600 text-lg"></i>
        </div>
        <div>
            <p class="text-xs text-red-500 font-bold uppercase tracking-wider">Erreur d'accès</p>
            <p class="text-sm text-red-800 font-medium">${erreur}</p>
        </div>
    </div>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .role-btn-active {
            background-color: #4f46e5 !important;
            color: white !important;
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.4);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 via-indigo-900 to-blue-900 min-h-screen flex items-center justify-center p-6">

    <div class="max-w-md w-full glass-card p-10 rounded-3xl shadow-2xl space-y-8">
        
        <!-- Header -->
        <div class="text-center">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-indigo-600 rounded-2xl mb-4 text-white shadow-lg">
                <i class="bi bi-shield-lock-fill text-3xl"></i>
            </div>
            <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">Bienvenue</h1>
            <p class="text-gray-500 mt-2 text-sm">Connectez-vous pour accéder à votre espace</p>
        </div>

        <!-- Sélecteur de rôle -->
        <div class="flex p-1 bg-gray-100 rounded-2xl">
            <button type="button" onclick="setRole('etudiant')" id="btn-etudiant" 
                    class="flex-1 py-3 rounded-xl font-bold transition-all duration-300 role-btn-active">
                <i class="bi bi-person-badge mr-2"></i> Étudiant
            </button>
            <button type="button" onclick="setRole('admin')" id="btn-admin" 
                    class="flex-1 py-3 rounded-xl font-bold transition-all duration-300 text-gray-500 hover:text-gray-700">
                <i class="bi bi-person-workspace mr-2"></i> Admin
            </button>
        </div>

        <!-- Message d'erreur -->
        <% if (request.getAttribute("erreur") != null) { %>
        <div class="p-4 bg-red-100 border-l-4 border-red-500 text-red-700 text-sm rounded-lg flex items-center gap-3">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <span><%= request.getAttribute("erreur") %></span>
        </div>
        <% } %>

        <!-- Formulaire -->
        <form method="POST" action="${pageContext.request.contextPath}/login" class="space-y-6">
            <input type="hidden" name="role" id="role-input" value="etudiant">

            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700 ml-1">Email professionnel</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="bi bi-envelope"></i>
                    </span>
                    <input type="email" name="email" required 
                        class="w-full pl-11 pr-4 py-3.5 rounded-2xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 bg-gray-50 outline-none transition-all" 
                        placeholder="nom@univ.mg">
                </div>
            </div>

            <div class="space-y-2">
                <label class="text-sm font-bold text-gray-700 ml-1">Mot de passe</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="bi bi-lock"></i>
                    </span>
                    <input type="password" name="password" required 
                        class="w-full pl-11 pr-4 py-3.5 rounded-2xl border border-gray-200 focus:ring-2 focus:ring-indigo-500 bg-gray-50 outline-none transition-all" 
                        placeholder="••••••••">
                </div>
            </div>

            <button type="submit" 
                    class="w-full bg-indigo-600 text-white py-4 rounded-2xl font-bold text-lg hover:bg-indigo-700 shadow-xl transition-all transform active:scale-95 flex items-center justify-center gap-2">
                Se connecter <i class="bi bi-arrow-right-short text-2xl"></i>
            </button>
        </form>

        <!-- Footer -->
        <div class="text-center text-sm text-gray-500 pt-4">
            Pas encore de compte ? 
            <a href="${pageContext.request.contextPath}/register" class="text-indigo-600 font-bold hover:underline">S'inscrire ici</a>
        </div>
    </div>

    <script>
        function setRole(role) {
            const btnEtu = document.getElementById('btn-etudiant');
            const btnAdmin = document.getElementById('btn-admin');
            const roleInput = document.getElementById('role-input');

            if (role === 'admin') {
                btnAdmin.classList.add('role-btn-active');
                btnAdmin.classList.remove('text-gray-500');
                btnEtu.classList.remove('role-btn-active');
                btnEtu.classList.add('text-gray-500');
                roleInput.value = 'admin';
            } else {
                btnEtu.classList.add('role-btn-active');
                btnEtu.classList.remove('text-gray-500');
                btnAdmin.classList.remove('role-btn-active');
                btnAdmin.classList.add('text-gray-500');
                roleInput.value = 'etudiant';
            }
        }
    </script>

</body>
</html>