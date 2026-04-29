<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .fade-in {
            animation: slideIn 0.5s ease-out forwards;
        }
        .float-animation {
            animation: float 3s ease-in-out infinite;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .input-group {
            position: relative;
        }
        .input-group input:focus + label,
        .input-group input:not(:placeholder-shown) + label,
        .input-group select:focus + label,
        .input-group select:valid + label {
            transform: translateY(-28px) scale(0.85);
            color: #4f46e5;
            background: white;
            padding: 0 4px;
            top: 16px;
            left: 8px;
        }
        .floating-label {
            position: absolute;
            left: 16px;
            top: 16px;
            transform: translateY(0);
            transition: all 0.2s ease;
            pointer-events: none;
            color: #6b7280;
            font-size: 14px;
            font-weight: 500;
            background: transparent;
            z-index: 1;
        }
        .input-group input:focus,
        .input-group input:not(:placeholder-shown),
        .input-group select:focus,
        .input-group select:valid {
            padding-top: 8px;
            padding-bottom: 8px;
        }
        .tab-active {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            color: white;
            box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.3);
        }
        .btn-gradient {
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
            transition: all 0.3s ease;
        }
        .btn-gradient:hover {
            background: linear-gradient(135deg, #4338ca 0%, #6d28d9 100%);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
        }
        .error-shake {
            animation: shake 0.5s;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        .success-glow {
            box-shadow: 0 0 0 3px rgba(34, 197, 94, 0.3);
        }
        .error-glow {
            box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.3);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-indigo-50 via-white to-purple-50 min-h-screen flex items-center justify-center p-6">

    <div class="max-w-2xl w-full glass-effect rounded-3xl shadow-2xl p-8 space-y-8 fade-in">
        <!-- En-tête moderne -->
        <div class="text-center">
            <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-full mb-4 float-animation">
                <i class="fas fa-user-plus text-white text-2xl"></i>
            </div>
            <h1 class="text-3xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
                Créer un compte
            </h1>
            <p class="text-gray-600 mt-2">Rejoignez notre plateforme d'apprentissage</p>
        </div>

        <!-- Message d'erreur moderne -->
        <% if (request.getAttribute("erreur") != null) { %>
        <div class="p-4 bg-red-50 border border-red-200 rounded-xl text-red-700 text-sm flex items-center gap-3 error-shake">
            <div class="flex-shrink-0">
                <i class="fas fa-exclamation-triangle text-red-500"></i>
            </div>
            <div>
                <strong>Erreur:</strong> <%= request.getAttribute("erreur") %>
            </div>
        </div>
        <% } %>

        <!-- Tabs de sélection -->
        <div class="bg-gray-50 p-1 rounded-xl">
            <div class="flex">
                <button type="button" onclick="switchTo('etudiant')" id="tab-etu" 
                        class="flex-1 py-3 px-4 text-sm font-semibold rounded-lg tab-active transition-all duration-300 flex items-center justify-center">
                    <i class="fas fa-user-graduate mr-2"></i>
                    Étudiant
                </button>
                <button type="button" onclick="switchTo('admin')" id="tab-adm" 
                        class="flex-1 py-3 px-4 text-sm font-semibold rounded-lg text-gray-600 hover:text-gray-800 transition-all duration-300 flex items-center justify-center">
                    <i class="fas fa-user-shield mr-2"></i>
                    Administrateur
                </button>
            </div>
        </div>

        <form id="mainForm" method="POST" action="<%= request.getContextPath() %>/etudiants"
              class="space-y-6" onsubmit="return validateForm()">
            
            <input type="hidden" name="role" id="role-val" value="etudiant">
            <input type="hidden" name="action" value="ajouter"/>

            <!-- Section étudiant -->
            <div id="section-etudiant" class="space-y-5">

                <div class="relative">
                    <select name="niveau" 
                            id="niveau"
                            class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all appearance-none bg-white"
                            required>
                        <option value="">Sélectionnez votre niveau</option>
                        <option value="L1">Licence 1 (L1)</option>
                        <option value="L2">Licence 2 (L2)</option>
                        <option value="L3" selected>Licence 3 (L3)</option>
                        <option value="M1">Master 1 (M1)</option>
                        <option value="M2">Master 2 (M2)</option>
                    </select>
                    <label for="niveau" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:valid]:top-1 peer-[:valid]:text-xs">
                        <i class="fas fa-graduation-cap mr-1"></i> Niveau d'étude *
                    </label>
                </div>
            </div>

            <!-- Champs communs -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="relative">
                    <input type="text" 
                           name="nom" 
                           id="nom"
                           class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all peer" 
                           placeholder=" "
                           pattern="[A-Za-zÀ-ÿ\s'-]+"
                           required>
                    <label for="nom" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:not(:placeholder-shown)]:top-1 peer-[:not(:placeholder-shown)]:text-xs">
                        <i class="fas fa-user mr-1"></i> Nom *
                    </label>
                    <span class="text-xs text-gray-500 mt-1 block">Lettres uniquement</span>
                </div>
                
                <div class="relative">
                    <input type="text" 
                           name="prenoms" 
                           id="prenoms"
                           class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all peer" 
                           placeholder=" "
                           pattern="[A-Za-zÀ-ÿ\s'-]+"
                           required>
                    <label for="prenoms" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:not(:placeholder-shown)]:top-1 peer-[:not(:placeholder-shown)]:text-xs">
                        <i class="fas fa-users mr-1"></i> Prénoms *
                    </label>
                    <span class="text-xs text-gray-500 mt-1 block">Lettres uniquement</span>
                </div>
            </div>

            <div class="relative">
                <input type="email" 
                       name="adr_email" 
                       id="adr-email"
                       class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all peer" 
                       placeholder=" "
                       required>
                <label for="adr-email" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:not(:placeholder-shown)]:top-1 peer-[:not(:placeholder-shown)]:text-xs">
                    <i class="fas fa-envelope mr-1"></i> Adresse Email *
                </label>
                <span class="text-xs text-gray-500 mt-1 block">ex: nom@example.com</span>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="relative">
                    <input type="password" 
                           name="password" 
                           id="password"
                           class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all peer" 
                           placeholder=" "
                           minlength="8"
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                           required>
                    <label for="password" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:not(:placeholder-shown)]:top-1 peer-[:not(:placeholder-shown)]:text-xs">
                        <i class="fas fa-lock mr-1"></i> Mot de passe *
                    </label>
                    <span class="text-xs text-gray-500 mt-1 block">8+ chars, maj, min, chiffre</span>
                </div>
                
                <div class="relative">
                    <input type="password" 
                           name="confirm_password" 
                           id="confirm-password"
                           class="w-full px-4 py-3 pt-6 rounded-xl text-sm border-2 border-gray-200 focus:border-indigo-500 focus:outline-none transition-all peer" 
                           placeholder=" "
                           required>
                    <label for="confirm-password" class="absolute left-4 top-4 text-gray-600 text-sm transition-all duration-200 pointer-events-none peer-focus:text-indigo-500 peer-focus:top-1 peer-focus:text-xs peer-[:not(:placeholder-shown)]:top-1 peer-[:not(:placeholder-shown)]:text-xs">
                        <i class="fas fa-lock mr-1"></i> Confirmation *
                    </label>
                    <span class="text-xs text-gray-500 mt-1 block">Doit être identique</span>
                </div>
            </div>

            <!-- Messages de validation -->
            <div id="validation-messages" class="hidden space-y-2"></div>

            <button type="submit" id="submit-btn" 
                    class="w-full py-4 btn-gradient text-white rounded-xl font-bold shadow-lg transition-all duration-300 flex items-center justify-center">
                <i class="fas fa-user-plus mr-2"></i>
                <span id="submit-text">S'inscrire en tant qu'Étudiant</span>
            </button>
        </form>


        <!-- Lien vers connexion -->
        <div class="text-center text-sm text-gray-600">
            Déjà inscrit ? <a href="${pageContext.request.contextPath}/login" class="text-indigo-600 font-bold hover:underline">Se connecter ici</a>
        </div>
    </div>

    <script>
        function switchTo(role) {
            const sectionEtu = document.getElementById('section-etudiant');
            const roleVal = document.getElementById('role-val');
            const form = document.getElementById('mainForm');
            const submitText = document.getElementById('submit-text');
            const tabEtu = document.getElementById('tab-etu');
            const tabAdm = document.getElementById('tab-adm');

            const isAdmin = (role === 'admin');

            // 1. Mise à jour du formulaire et de l'affichage
            sectionEtu.classList.toggle('hidden', isAdmin);
            roleVal.value = role;
            submitText.textContent = isAdmin ? "S'inscrire en tant qu'Administrateur" : "S'inscrire en tant qu'Étudiant";
            
            // Dynamisation de l'action du formulaire
            form.action = isAdmin ? "<%= request.getContextPath() %>/register" : "<%= request.getContextPath() %>/etudiants";

            // 2. Mise à jour visuelle des onglets
            if (isAdmin) {
                tabAdm.classList.add('tab-active');
                tabAdm.classList.remove('text-gray-600');
                tabEtu.classList.remove('tab-active');
                tabEtu.classList.add('text-gray-600');
            } else {
                tabEtu.classList.add('tab-active');
                tabEtu.classList.remove('text-gray-600');
                tabAdm.classList.remove('tab-active');
                tabAdm.classList.add('text-gray-600');
            }
        }

        function validateForm() {
            const form = document.getElementById('mainForm');
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const email = document.getElementById('adr-email').value;
            const validationMessages = document.getElementById('validation-messages');
            
            // Réinitialiser les messages
            validationMessages.innerHTML = '';
            validationMessages.classList.add('hidden');
            
            let errors = [];
            
            // Validation des mots de passe
            if (password !== confirmPassword) {
                errors.push('Les mots de passe ne correspondent pas');
                document.getElementById('confirm-password').classList.add('error-glow');
            }
            
            if (password.length < 8) {
                errors.push('Le mot de passe doit contenir au moins 8 caractères');
                document.getElementById('password').classList.add('error-glow');
            }
            
            // Validation de l'email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                errors.push('Veuillez entrer une adresse email valide');
                document.getElementById('adr-email').classList.add('error-glow');
            }
            
            // Validation du numéro étudiant si étudiant
            const role = document.getElementById('role-val').value;
            if (role === 'etudiant') {
                const numEtudiant = document.getElementById('num-etudiant').value;
                if (!/^\d+$/.test(numEtudiant)) {
                    errors.push('Le numéro étudiant doit contenir uniquement des chiffres');
                    document.getElementById('num-etudiant').classList.add('error-glow');
                }
            }
            
            // Afficher les erreurs
            if (errors.length > 0) {
                validationMessages.innerHTML = errors.map(error => 
                    `<div class="p-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm flex items-center gap-2">
                        <i class="fas fa-exclamation-circle text-red-500"></i>
                        ${error}
                    </div>`
                ).join('');
                validationMessages.classList.remove('hidden');
                
                // Retirer les effets visuels après 3 secondes
                setTimeout(() => {
                    document.querySelectorAll('.error-glow').forEach(el => {
                        el.classList.remove('error-glow');
                    });
                }, 3000);
                
                return false;
            }
            
            // Effet de succès
            const submitBtn = document.getElementById('submit-btn');
            submitBtn.classList.add('success-glow');
            
            return true;
        }

        // Validation en temps réel
        document.addEventListener('DOMContentLoaded', function() {
            const inputs = document.querySelectorAll('input[required]');
            
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    if (this.checkValidity()) {
                        this.classList.remove('error-glow');
                        this.classList.add('success-glow');
                        setTimeout(() => {
                            this.classList.remove('success-glow');
                        }, 2000);
                    } else {
                        this.classList.add('error-glow');
                    }
                });
                
                input.addEventListener('focus', function() {
                    this.classList.remove('error-glow', 'success-glow');
                });
            });
            
            // Validation de la correspondance des mots de passe en temps réel
            const confirmPassword = document.getElementById('confirm-password');
            const password = document.getElementById('password');
            
            confirmPassword.addEventListener('input', function() {
                if (this.value && this.value !== password.value) {
                    this.classList.add('error-glow');
                } else {
                    this.classList.remove('error-glow');
                }
            });
        });
    </script>
</body>
</html>