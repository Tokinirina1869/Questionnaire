<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Création de Compte - Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- FontAwesome pour les icônes -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Animation d'apparition fluide */
        @keyframes slideUp { 
            from { opacity: 0; transform: translateY(20px); } 
            to { opacity: 1; transform: translateY(0); } 
        }
        /* Animation de flottement de l'icône */
        @keyframes float { 
            0%, 100% { transform: translateY(0px); } 
            50% { transform: translateY(-10px); } 
        }
        
        .glass-effect { 
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(12px); 
            border: 1px solid rgba(255, 255, 255, 0.3); 
        }
        .fade-in { animation: slideUp 0.5s ease-out forwards; }
        .float-animation { animation: float 3s ease-in-out infinite; }
        
        /* Style des onglets actifs */
        .tab-active { 
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); 
            color: white; 
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.4); 
        }
        
        /* Bouton avec dégradé */
        .btn-gradient { 
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%); 
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
        }
        .btn-gradient:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3); 
            filter: brightness(1.1); 
        }
        
        /* Animation de secousse en cas d'erreur */
        .error-shake { animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both; }
        @keyframes shake { 
            10%, 90% { transform: translate3d(-1px, 0, 0); } 
            20%, 80% { transform: translate3d(2px, 0, 0); } 
            30%, 50%, 70% { transform: translate3d(-4px, 0, 0); } 
            40%, 60% { transform: translate3d(4px, 0, 0); } 
        }
        
        .input-focus-ring:focus { 
            border-color: #4f46e5; 
            box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1); 
        }
    </style>
</head>
<body class="bg-gradient-to-br from-slate-900 via-indigo-950 to-slate-900 min-h-screen flex items-center justify-center p-6">

    <div class="max-w-xl w-full glass-effect rounded-[2.5rem] shadow-2xl p-8 md:p-10 fade-in">
        <!-- Header -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-tr from-indigo-600 to-purple-500 rounded-2xl mb-4 shadow-lg float-animation">
                <i class="fas fa-user-plus text-white text-2xl"></i>
            </div>
            <h1 class="text-3xl font-extrabold text-slate-800 tracking-tight">Inscription</h1>
            <p class="text-slate-500 mt-2 font-medium">Créez votre compte pour accéder à cette plateforme</p>
        </div>

        <!-- Sélecteur de Rôle (Tabs) -->
        <div class="bg-slate-100/50 p-1.5 rounded-2xl mb-8 flex gap-2">
            <button type="button" onclick="switchTo('etudiant')" id="tab-etu" class="flex-1 py-3 px-4 text-sm font-bold rounded-xl tab-active transition-all duration-300 flex items-center justify-center gap-2">
                <i class="fas fa-user-graduate"></i> Étudiant
            </button>
            <button type="button" onclick="switchTo('admin')" id="tab-adm" class="flex-1 py-3 px-4 text-sm font-bold rounded-xl text-slate-500 hover:bg-white/50 transition-all duration-300 flex items-center justify-center gap-2">
                <i class="fas fa-user-shield"></i> Admin
            </button>
        </div>

        <!-- Formulaire -->
        <form id="mainForm" method="POST" action="${pageContext.request.contextPath}/etudiants" class="space-y-5" onsubmit="return validateForm()">
            <input type="hidden" name="role" id="role-val" value="etudiant">
            <input type="hidden" name="action" value="ajouter"/>

            <!-- Section spécifique Étudiant (Niveau) -->
            <div id="section-etudiant" class="transition-all duration-300">
                <div class="relative group">
                    <label class="block text-xs font-bold text-indigo-600 uppercase tracking-wider mb-1 ml-1">Niveau d'étude</label>
                    <div class="relative">
                        <select name="niveau" id="niveau" class="w-full px-4 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring appearance-none transition-all font-medium text-slate-700">
                            <option value="L1">Licence 1 (L1)</option>
                            <option value="L2">Licence 2 (L2)</option>
                            <option value="L3" selected>Licence 3 (L3)</option>
                            <option value="M1">Master 1 (M1)</option>
                            <option value="M2">Master 2 (M2)</option>
                        </select>
                        <i class="fas fa-chevron-down absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none text-xs"></i>
                    </div>
                </div>
            </div>

            <!-- Identité (Nom / Prénom dynamique) -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Nom</label>
                    <input type="text" name="nom" id="nom" required class="w-full px-4 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring transition-all" placeholder="Dupont">
                </div>
                <!-- Le champ prénom sera masqué pour l'admin via JS -->
                <div class="space-y-1 transition-all duration-300" id="container-prenoms">
                    <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Prénoms</label>
                    <input type="text" name="prenoms" id="prenoms" required class="w-full px-4 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring transition-all" placeholder="Jean">
                </div>
            </div>

            <!-- Email -->
            <div class="space-y-1">
                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Email professionnel</label>
                <div class="relative">
                    <i class="far fa-envelope absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                    <input type="email" name="adr_email" id="adr-email" required class="w-full pl-11 pr-4 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring transition-all" placeholder="nom@exemple.com">
                </div>
            </div>

            <!-- Mots de passe -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Mot de passe</label>
                    <div class="relative">
                        <input type="password" name="password" id="password" required class="w-full pl-4 pr-11 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring transition-all" placeholder="••••••••">
                        <button type="button" onclick="toggleField('password', 'eye1')" class="absolute right-3 top-1/2 -translate-y-1/2 p-2 text-slate-400 hover:text-indigo-600 transition-colors">
                            <i class="far fa-eye" id="eye1"></i>
                        </button>
                    </div>
                </div>
                <div class="space-y-1">
                    <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Confirmation</label>
                    <div class="relative">
                        <input type="password" name="confirm_password" id="confirm_password" required class="w-full pl-4 pr-11 py-3.5 bg-slate-50 border-2 border-slate-200 rounded-2xl focus:outline-none input-focus-ring transition-all"
                            oninput="checkMatch()" placeholder="••••••••">
                        <button type="button" onclick="toggleField('confirm_password', 'eye2')" class="absolute right-3 top-1/2 -translate-y-1/2 p-2 text-slate-400 hover:text-indigo-600 transition-colors">
                            <i class="far fa-eye" id="eye2"></i>
                        </button>
                    </div>
                </div>
            </div>
            
            <p id="match-message"
                class="text-[10px] font-black uppercase tracking-widest text-center transition-all"
                style="opacity: 0;">
            </p>
            <!-- Bouton Submit -->
            <button type="submit" id="submit-btn" class="w-full py-4 btn-gradient text-white rounded-2xl font-bold shadow-xl flex items-center justify-center gap-3 group">
                <span id="submit-text">S'inscrire en tant qu'Étudiant</span>
                <i class="fas fa-arrow-right text-sm group-hover:translate-x-1 transition-transform"></i>
            </button>
        </form>

        <div class="text-center mt-8">
            <p class="text-slate-500 text-sm">
                Déjà inscrit ? 
                <a href="${pageContext.request.contextPath}/login" class="text-indigo-600 font-bold hover:text-purple-600 underline-offset-4 hover:underline transition-all">Se connecter</a>
            </p>
        </div>
    </div>

    <script>
        /**
         * Bascule entre le rôle Étudiant et Admin
         * Gère l'affichage dynamique du prénom et du niveau
         */
        function switchTo(role) {
            const isAdmin = (role === 'admin');
            const sectionEtu = document.getElementById('section-etudiant');
            const containerPrenoms = document.getElementById('container-prenoms');
            const inputPrenoms = document.getElementById('prenoms');
            const roleVal = document.getElementById('role-val');
            const submitText = document.getElementById('submit-text');
            const form = document.getElementById('mainForm');
            
            // 1. Visibilité Niveau et Prénom
            sectionEtu.classList.toggle('hidden', isAdmin);
            
            if (isAdmin) {
                containerPrenoms.classList.add('hidden');
                inputPrenoms.removeAttribute('required');
                inputPrenoms.value = ""; // Clean value
                submitText.textContent = "Créer mon compte Admin";
                form.action = "${pageContext.request.contextPath}/register";
            } else {
                containerPrenoms.classList.remove('hidden');
                inputPrenoms.setAttribute('required', '');
                submitText.textContent = "S'inscrire en tant qu'Étudiant";
                form.action = "${pageContext.request.contextPath}/etudiants";
            }

            roleVal.value = role;

            // 2. Style des Onglets
            const tabEtu = document.getElementById('tab-etu');
            const tabAdm = document.getElementById('tab-adm');
            
            if(isAdmin) {
                tabAdm.classList.add('tab-active'); tabEtu.classList.remove('tab-active');
                tabEtu.classList.add('text-slate-500'); tabAdm.classList.remove('text-slate-500');
            } else {
                tabEtu.classList.add('tab-active'); tabAdm.classList.remove('tab-active');
                tabAdm.classList.add('text-slate-500'); tabEtu.classList.remove('text-slate-500');
            }
        }

        /**
         * Toggle de visibilité du mot de passe
         */
        function toggleField(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            const isPassword = input.type === 'password';
            
            input.type = isPassword ? 'text' : 'password';
            icon.classList.toggle('fa-eye', !isPassword);
            icon.classList.toggle('fa-eye-slash', isPassword);
        }

        /**
         * Vérification de correspondance des mots de passe en temps réel
         */
        const pass        = document.getElementById('password');
        const confirmPass = document.getElementById('confirm_password');
        const matchMsg    = document.getElementById('match-message');


        function checkMatch() {
            if (confirmPass.value.length > 0) {
                const isMatch = pass.value === confirmPass.value;

                /* ✅ style.color au lieu de classes Tailwind dynamiques */
                matchMsg.textContent  = isMatch
                    ? '✓ Les mots de passe correspondent'
                    : '✗ Les mots de passe sont différents';

                matchMsg.style.color   = isMatch ? '#22c55e' : '#ef4444';
                matchMsg.style.opacity = '1';

                confirmPass.style.borderColor = isMatch ? '#22c55e' : '#ef4444';
                pass.style.borderColor        = isMatch ? '#22c55e' : '#ef4444';

            } else {
                /* Reset */
                matchMsg.style.opacity        = '0';
                matchMsg.textContent          = '';
                confirmPass.style.borderColor = '';
                pass.style.borderColor        = '';
            }
        }

        pass.addEventListener('input', checkMatch);
        confirmPass.addEventListener('input', checkMatch);

        /**
         * Validation finale avant envoi
         */
        function validateForm() {
            if (pass.value !== confirmPass.value) {
                const card = document.querySelector('.glass-effect');
                card.classList.add('error-shake');
                setTimeout(() => card.classList.remove('error-shake'), 500);
                return false;
            }
            
            const btn = document.getElementById('submit-btn');
            btn.innerHTML = `<i class="fas fa-circle-notch animate-spin"></i> Traitement en cours...`;
            btn.style.pointerEvents = 'none';
            return true;
        }
    </script>
</body>
</html>