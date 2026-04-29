<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<script>
    tailwind.config = { darkMode: 'class' };

    // Applique le thème immédiatement pour éviter le flash blanc
    (function() {
        const theme = localStorage.getItem("theme") || "light";
        if (theme === "dark") {
            document.documentElement.classList.add("dark");
        }
    })();
</script>

<style type="text/tailwindcss">
    @layer base {
        body {
            @apply bg-gradient-to-br from-indigo-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-indigo-900 text-gray-900 dark:text-gray-100 transition-colors duration-300 min-h-screen;
        }
        /* Classe réutilisable pour les conteneurs de tableaux/formulaires */
        .card-container {
            @apply bg-white/95 dark:bg-gray-900/95 backdrop-blur-sm border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl overflow-hidden;
        }
    }
    @keyframes slideDown {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }
    .nav-slide {
        animation: slideDown 0.3s ease-out;
    }
    .nav-glass {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }
    .dark .nav-glass {
        background: rgba(17, 24, 39, 0.95);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .nav-link {
        position: relative;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    .nav-link::before {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        width: 0;
        height: 2px;
        background: linear-gradient(90deg, #4f46e5, #7c3aed);
        transition: all 0.3s ease;
        transform: translateX(-50%);
    }
    .nav-link:hover::before {
        width: 100%;
    }
    .nav-link.active::before {
        width: 100%;
    }
    .theme-toggle {
        transition: all 0.3s ease;
    }
    .theme-toggle:hover {
        transform: rotate(180deg);
    }
    .clock-widget {
        background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
        border: 1px solid rgba(0, 0, 0, 0.1);
    }
    .dark .clock-widget {
        background: linear-gradient(135deg, #374151, #1f2937);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
</style>

<nav class="sticky top-0 z-50 nav-glass nav-slide shadow-lg">
    <div class="mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <!-- Logo et branding -->
            <div class="flex items-center space-x-4">
                <div class="flex items-center space-x-3">
                    <h1 class="text-xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
                        QCM Platforme
                    </h1>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Système d'Évaluation</p>
                </div>
            </div>

            <!-- Navigation principale -->
            <div class="hidden md:flex items-center space-x-1">
                <c:set var="uri" value="${pageContext.request.requestURI}"/>
                <c:set var="userRole" value="${sessionScope.role}"/>

                <c:set var="base"     value="nav-link px-4 py-2 rounded-lg text-sm font-medium transition-all duration-300"/>
                <c:set var="inactive" value="text-gray-600 dark:text-gray-400 hover:text-indigo-600 dark:hover:text-indigo-400 hover:bg-gray-50 dark:hover:bg-gray-800"/>
                <c:set var="active"   value="text-white bg-gradient-to-r from-indigo-600 to-purple-600 shadow-md font-bold"/>

                <a href="${pageContext.request.contextPath}/dashboard"
                    class="${base} ${uri.contains('/dashboard') ? active : inactive}">
                    <i class="fas fa-home mr-2"></i> Tableau de Bord
                </a>

                <%-- SECTION ETUDIANT --%>
                <c:if test="${userRole == 'ETUDIANT'}">
                    <a href="${pageContext.request.contextPath}/etudiants"
                        class="${base} ${uri.contains('/etudiants') ? active : inactive}">
                        <i class="fas fa-file-alt mr-2"></i> ListeEtudiants
                    </a>
                    <a href="${pageContext.request.contextPath}/etudiant/classement"
                        class="${mobileBase} ${uri.contains('/etudiant/classement') ? mobileActive : mobileInactive}">
                        <i class="fas fa-chart-line mr-2"></i> Mes Notes
                    </a>
                </c:if>

                <%-- SECTION ADMIN --%>
                <c:if test="${userRole == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/examen?action=passer"
                        class="${base} ${uri.contains('/examen') ? active : inactive}">
                        <i class="fas fa-file-alt mr-2"></i> Passer l'examen
                    </a>
                    <a href="${pageContext.request.contextPath}/qcm"
                        class="${base} ${uri.contains('/qcm') ? active : inactive}">
                        <i class="fas fa-tasks mr-2"></i> Gestion QCM
                    </a>
                    <a href="${pageContext.request.contextPath}/examen?action=resultats"
                        class="${base} ${param.action == 'resultats' ? active : inactive}">
                        <i class="fas fa-chart-bar mr-2"></i> Résultats
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-gestion"
                        class="${base} ${uri.contains('/admin-gestion') ? active : inactive}">
                        <i class="fas fa-user-shield mr-2"></i> Accès Admin
                    </a>
                </c:if>
            </div>

            <!-- Actions et widgets -->
            <div class="flex items-center space-x-4">
                <!-- Bouton thème -->
                <button id="themeToggle"
                        class="theme-toggle p-2 rounded-xl bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 text-gray-600 dark:text-gray-400">
                    <i id="iconDark" class="fas fa-sun text-yellow-500"></i>
                    <i id="iconLight" class="fas fa-moon text-blue-400 hidden"></i>
                </button>

                <!-- Widget horloge -->
                <div class="clock-widget px-4 py-2 rounded-full flex items-center space-x-2">
                    <i class="fas fa-clock text-indigo-500"></i>
                    <span id="horloge" class="text-sm font-mono text-gray-700 dark:text-gray-300"></span>
                </div>

                <!-- Menu mobile -->
                <button id="mobileMenuToggle" class="md:hidden p-2 rounded-lg bg-gray-100 dark:bg-gray-800">
                    <i class="fas fa-bars text-gray-600 dark:text-gray-400"></i>
                </button>
            </div>
        </div>

        <!-- Menu mobile -->
        <div id="mobileMenu" class="hidden md:hidden py-4 border-t border-gray-200 dark:border-gray-700">
            <div class="flex flex-col space-y-2">
                <c:set var="mobileBase" value="block w-full text-left px-4 py-2 rounded-lg text-sm font-medium transition-all duration-300"/>
                <c:set var="mobileInactive" value="text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800"/>
                <c:set var="mobileActive" value="text-white bg-gradient-to-r from-indigo-600 to-purple-600"/>

                <a href="${pageContext.request.contextPath}/dashboard"
                    class="${mobileBase} ${uri.contains('/dashboard') ? mobileActive : mobileInactive}">
                    <i class="fas fa-home mr-2"></i> Tableau de Bord
                </a>

                <c:if test="${userRole == 'ETUDIANT'}">
                    <a href="${pageContext.request.contextPath}/etudiants"
                    class="${mobileBase} ${uri.contains('/etudiants') ? mobileActive : mobileInactive}">
                        <i class="fas fa-user-graduate mr-2"></i> Etudiants
                    </a>
                    <a href="${pageContext.request.contextPath}/etudiant/classement"
                    class="${mobileBase} ${uri.contains('/etudiant/classement') ? mobileActive : mobileInactive}">
                        <i class="fas fa-chart-line mr-2"></i> Mes Notes
                    </a>
                </c:if>

                <c:if test="${userRole == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/examen?action=passer"
                    class="${mobileBase} ${uri.contains('/examen') ? mobileActive : mobileInactive}">
                        <i class="fas fa-file-alt mr-2"></i> Passer l'examen
                    </a>
                    <a href="${pageContext.request.contextPath}/qcm"
                    class="${mobileBase} ${uri.contains('/qcm') ? mobileActive : mobileInactive}">
                        <i class="fas fa-tasks mr-2"></i> Gestion QCM
                    </a>
                    <a href="${pageContext.request.contextPath}/examen?action=resultats"
                        class="${mobileBase} ${param.action == 'resultats' ? mobileActive : mobileInactive}">
                        <i class="fas fa-chart-bar mr-2"></i> Résultats
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-gestion"
                    class="${mobileBase} ${uri.contains('/admin-gestion') ? mobileActive : mobileInactive}">
                        <i class="fas fa-user-shield mr-2"></i> Accès Admin
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<script>
    function actualiserHeure() {
        const maintenant = new Date();
        
        // Configuration du format
        const optionsDate = { day: '2-digit', month: '2-digit', year: 'numeric' };
        const date = maintenant.toLocaleDateString('fr-FR', optionsDate);
        
        const heures = String(maintenant.getHours()).padStart(2, '0');
        const minutes = String(maintenant.getMinutes()).padStart(2, '0');
        
        document.getElementById('horloge').innerText = date + " à " + heures + ":" + minutes;
    }

    // Appeler immédiatement et rafraîchir toutes les minutes
    actualiserHeure();
    setInterval(actualiserHeure, 60000); 
</script>

<script>
    // Gestion du thème
    const toggleBtn = document.getElementById("themeToggle");
    const iconDark  = document.getElementById("iconDark");
    const iconLight = document.getElementById("iconLight");

    function syncIcons() {
        const isDark = document.documentElement.classList.contains("dark");
        iconDark.classList.toggle("hidden", isDark);
        iconLight.classList.toggle("hidden", !isDark);
    }

    syncIcons();

    toggleBtn.addEventListener("click", () => {
        const isDark = document.documentElement.classList.toggle("dark");
        localStorage.setItem("theme", isDark ? "dark" : "light");
        syncIcons();
        
        // Animation de transition
        document.body.style.transition = 'all 0.3s ease';
    });

    // Menu mobile
    const mobileMenuToggle = document.getElementById("mobileMenuToggle");
    const mobileMenu = document.getElementById("mobileMenu");

    if (mobileMenuToggle && mobileMenu) {
        mobileMenuToggle.addEventListener("click", () => {
            mobileMenu.classList.toggle("hidden");
            
            // Animation du bouton hamburger
            const icon = mobileMenuToggle.querySelector('i');
            if (mobileMenu.classList.contains('hidden')) {
                icon.classList.remove('fa-times');
                icon.classList.add('fa-bars');
            } else {
                icon.classList.remove('fa-bars');
                icon.classList.add('fa-times');
            }
        });
    }

    // Gestion des classes actives pour les liens de navigation
    document.addEventListener('DOMContentLoaded', function() {
        const navLinks = document.querySelectorAll('.nav-link');
        const currentPath = window.location.pathname;
        
        navLinks.forEach(link => {
            if (link.getAttribute('href') && currentPath.includes(link.getAttribute('href'))) {
                link.classList.add('active');
            }
        });
    });
</script>