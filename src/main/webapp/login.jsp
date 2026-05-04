<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        /* Animation de flottement (identique à register) */
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        .float-animation {
            animation: float 3s ease-in-out infinite;
        }

        /* Animation d'apparition fluide */
        @keyframes fadeInScale {
            from { opacity: 0; transform: scale(0.98) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }

        .glass-card {
            animation: fadeInScale 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .role-btn-active {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%) !important;
            color: white !important;
            box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.4);
        }

        input:focus {
            transform: translateY(-1px);
        }
        
        .btn-gradient {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            transition: all 0.3s ease;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 min-h-screen flex items-center justify-center p-6">

    <div class="max-w-md w-full glass-card p-10 rounded-[2.5rem] shadow-2xl space-y-8">
        
        <!-- Header avec Icône Animée -->
        <div class="text-center">
            <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-tr from-indigo-600 to-purple-500 rounded-2xl mb-6 text-white shadow-xl float-animation">
                <i class="bi bi-shield-lock-fill text-4xl"></i>
            </div>
            <h1 class="text-3xl font-extrabold text-gray-900 tracking-tight">Connexion!</h1>
            <p class="text-gray-500 mt-2 font-medium">Connectez-vous à cette plateforme!</p>
        </div>

        <!-- Messages d'erreur (JSTL ou Request) -->
        <c:if test="${not empty erreur}">
            <div class="animate-bounce p-4 bg-red-50 border-l-4 border-red-500 rounded-xl flex items-center gap-3">
                <i class="bi bi-exclamation-circle-fill text-red-500"></i>
                <p class="text-sm text-red-800 font-medium">${erreur}</p>
            </div>
        </c:if>

        <!-- Sélecteur de rôle -->
        <div class="flex p-1.5 bg-gray-100 rounded-2xl">
            <button type="button" onclick="setRole('etudiant')" id="btn-etudiant" 
                    class="flex-1 py-3 rounded-xl font-bold transition-all duration-300 role-btn-active">
                <i class="bi bi-person-badge mr-2"></i> Étudiant
            </button>
            <button type="button" onclick="setRole('admin')" id="btn-admin" 
                    class="flex-1 py-3 rounded-xl font-bold transition-all duration-300 text-gray-500 hover:text-indigo-600">
                <i class="bi bi-person-workspace mr-2"></i> Admin
            </button>
        </div>

        <!-- Formulaire -->
        <form method="POST" action="${pageContext.request.contextPath}/login" class="space-y-6" id="loginForm">
            <input type="hidden" name="role" id="role-input" value="etudiant">

            <div class="space-y-1">
                <label class="text-xs font-bold text-gray-500 uppercase tracking-widest ml-1">Email</label>
                <div class="relative">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="bi bi-envelope"></i>
                    </span>
                    <input type="email" name="email" required 
                        class="w-full pl-11 pr-4 py-4 rounded-2xl border-2 border-gray-100 focus:border-indigo-500 focus:ring-0 bg-gray-50 outline-none transition-all" 
                        placeholder="nom@univ.mg">
                </div>
            </div>

            <div class="space-y-1">
                <label class="text-xs font-bold text-gray-500 uppercase tracking-widest ml-1">Mot de passe</label>
                <div class="relative group">
                    <span class="absolute inset-y-0 left-0 pl-4 flex items-center text-gray-400">
                        <i class="bi bi-lock"></i>
                    </span>
                    <input type="password" name="password" id="password" required 
                        class="w-full pl-11 pr-12 py-4 rounded-2xl border-2 border-gray-100 focus:border-indigo-500 focus:ring-0 bg-gray-50 outline-none transition-all" 
                        placeholder="••••••••">
                    
                    <button type="button" onclick="togglePassword()" 
                        class="absolute inset-y-0 right-0 pr-4 flex items-center text-gray-400 hover:text-indigo-600 transition-colors">
                        <i class="bi bi-eye" id="toggleIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" id="submitBtn"
                    class="w-full btn-gradient text-white py-4 rounded-2xl font-bold text-lg shadow-xl transform active:scale-95 flex items-center justify-center gap-3">
                <span>Se connecter</span>
                <i class="bi bi-arrow-right text-xl"></i>
            </button>
        </form>

        <div class="text-center pt-4">
            <p class="text-sm text-gray-500">
                Pas encore de compte ? 
                <a href="${pageContext.request.contextPath}/register" class="text-indigo-600 font-bold hover:underline underline-offset-4">S'inscrire gratuitement</a>
            </p>
        </div>
    </div>

    <script>
        function setRole(role) {
            const btnEtu = document.getElementById('btn-etudiant');
            const btnAdmin = document.getElementById('btn-admin');
            const roleInput = document.getElementById('role-input');

            if (role === 'admin') {
                btnAdmin.classList.add('role-btn-active');
                btnEtu.classList.remove('role-btn-active');
                btnEtu.classList.add('text-gray-500');
                roleInput.value = 'admin';
            } else {
                btnEtu.classList.add('role-btn-active');
                btnAdmin.classList.remove('role-btn-active');
                btnAdmin.classList.add('text-gray-500');
                roleInput.value = 'etudiant';
            }
        }

        function togglePassword() {
            const input = document.getElementById('password');
            const icon = document.getElementById('toggleIcon');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('bi-eye', 'bi-eye-slash');
                icon.classList.add('text-indigo-600');
            } else {
                input.type = 'password';
                icon.classList.replace('bi-eye-slash', 'bi-eye');
                icon.classList.remove('text-indigo-600');
            }
        }

        // Animation de chargement au clic
        document.getElementById('loginForm').addEventListener('submit', function() {
            const btn = document.getElementById('submitBtn');
            btn.innerHTML = '<i class="bi bi-arrow-repeat animate-spin text-xl"></i> <span>Authentification...</span>';
            btn.classList.add('opacity-80', 'cursor-not-allowed');
        });
    </script>

</body>
</html>