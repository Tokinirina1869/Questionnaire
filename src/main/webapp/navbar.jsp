<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    tailwind.config = { darkMode: 'class' };
    (function() {
        if (localStorage.getItem("theme") === "dark")
            document.documentElement.classList.add("dark");
    })();
</script>

<style type="text/tailwindcss">
    @layer base {
        .nav-glass {
            @apply sticky top-0 z-50 backdrop-blur-md border-b transition-all duration-300;
            background: rgba(255,255,255,0.95);
            border-color: rgba(226,232,240,0.8);
        }
        .dark .nav-glass {
            background: rgba(15,23,42,0.95);
            border-color: rgba(30,41,59,0.8);
        }
    }

    .nav-link {
        @apply relative py-2 px-3 text-sm text-slate-500 dark:text-slate-400
               rounded-lg transition-colors duration-200
               hover:text-indigo-600 dark:hover:text-indigo-400
               hover:bg-indigo-50 dark:hover:bg-indigo-950/40;
    }

    .nav-link::after {
        content: '';
        @apply absolute bottom-0 left-3 right-3 h-0.5 rounded-full bg-indigo-600 dark:bg-indigo-400;
        transform: scaleX(0);
        transition: transform 0.25s cubic-bezier(0.34, 1.56, 0.64, 1);
    }

    .nav-link-active {
        @apply text-indigo-600 dark:text-indigo-400 font-semibold;
    }
    .nav-link-active::after {
        transform: scaleX(1);
    }

    .user-chip {
        @apply flex items-center gap-2 px-2.5 py-1.5 rounded-xl border
               border-slate-200 dark:border-slate-700
               bg-slate-50 dark:bg-slate-800/60
               cursor-pointer transition-colors duration-200
               hover:bg-slate-100 dark:hover:bg-slate-800;
    }
    .user-avatar {
        @apply w-7 h-7 rounded-lg bg-indigo-100 dark:bg-indigo-950
               flex items-center justify-center
               text-xs font-semibold text-indigo-700 dark:text-indigo-300;
    }
</style>

<c:set var="uri"  value="${pageContext.request.requestURI}"/>
<c:set var="role" value="${sessionScope.role}"/>

<%-- Résolution de l'objet connecté selon le rôle --%>
<c:choose>
    <c:when test="${role == 'ADMIN'}">
        <c:set var="connectedUser" value="${sessionScope.user}"/>
        <c:set var="displayNom"    value="${sessionScope.user.nomAdmin}"/>
    </c:when>
    <c:otherwise>
        <c:set var="connectedUser" value="${sessionScope.utilisateurConnecte}"/>
        <c:set var="displayNom"    value="${sessionScope.utilisateurConnecte.nom}"/>
    </c:otherwise>
</c:choose>

<nav class="nav-glass shadow-sm">
    <div class="max-w-8xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16 gap-6">

            <%-- ── LOGO ── --%>
            <a href="${pageContext.request.contextPath}/dashboard"
               class="flex items-center gap-2.5 shrink-0 group">
                <div class="w-9 h-9 bg-gradient-to-tr from-indigo-600 to-purple-600
                            rounded-xl flex items-center justify-center text-white text-sm
                            shadow-md group-hover:scale-105 transition-transform">
                    <i class="fas fa-brain"></i>
                </div>
                <span class="text-lg font-black text-slate-800 dark:text-white tracking-tighter">
                    QUIZ<span class="text-indigo-600">PRO</span>
                </span>
            </a>

            <%-- ── LIENS PRINCIPAUX (desktop) ── --%>
            <div class="hidden md:flex items-center gap-1 justify-center flex-1">

                <a href="${pageContext.request.contextPath}/dashboard"
                   class="nav-link ${uri.contains('dashboard') ? 'nav-link-active' : ''}">
                    <i class="fas fa-grid-2 mr-1.5 text-xs opacity-70"></i>Tableau de bord
                </a>

                <c:if test="${role == 'ETUDIANT'}">
                    <a href="${pageContext.request.contextPath}/etudiants"
                       class="nav-link ${uri.contains('etudiants') ? 'nav-link-active' : ''}">
                        <i class="fas fa-users mr-1.5 text-xs opacity-70"></i>Liste Étudiants
                    </a>
                    <a href="${pageContext.request.contextPath}/etudiant/classement"
                       class="nav-link ${uri.contains('classement') ? 'nav-link-active' : ''}">
                        <i class="fas fa-star mr-1.5 text-xs opacity-70"></i>Mes Notes
                    </a>
                </c:if>

                <c:if test="${role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/examen?action=passer"
                       class="nav-link ${uri.contains('examen') ? 'nav-link-active' : ''}">
                        <i class="fas fa-file-pen mr-1.5 text-xs opacity-70"></i>Gestion d'Examens
                    </a>
                    <a href="${pageContext.request.contextPath}/etudiants"
                       class="nav-link ${uri.contains('etudiants') ? 'nav-link-active' : ''}">
                        <i class="fas fa-users mr-1.5 text-xs opacity-70"></i>Liste Étudiants
                    </a>
                    <a href="${pageContext.request.contextPath}/qcm"
                       class="nav-link ${uri.contains('qcm') ? 'nav-link-active' : ''}">
                        <i class="fas fa-list-check mr-1.5 text-xs opacity-70"></i>Gestion de QCM
                    </a>
                    <a href="${pageContext.request.contextPath}/examen?action=resultats"
                       class="nav-link ${param.action == 'resultats' ? 'nav-link-active' : ''}">
                        <i class="fas fa-chart-bar mr-1.5 text-xs opacity-70"></i>Résultats
                    </a>
                    <a href="${pageContext.request.contextPath}/admin-gestion"
                       class="nav-link ${uri.contains('admin-gestion') ? 'nav-link-active' : ''}">
                        <i class="fas fa-shield-halved mr-1.5 text-xs opacity-70"></i>Côté Admin
                    </a>
                </c:if>
            </div>

            <%-- ── ACTIONS DROITE ── --%>
            <div class="flex items-center gap-2 shrink-0">

                <%-- Bouton thème --%>
                <button id="themeToggle"
                        class="w-9 h-9 rounded-xl border border-slate-200 dark:border-slate-700
                               bg-slate-50 dark:bg-slate-800 flex items-center justify-center
                               text-slate-500 hover:scale-105 transition-all">
                    <i id="sunIcon"  class="fas fa-sun  text-yellow-400 hidden"></i>
                    <i id="moonIcon" class="fas fa-moon text-indigo-400"></i>
                </button>

                <c:choose>
                    <%-- NON CONNECTÉ --%>
                    <c:when test="${empty connectedUser}">
                        <a href="${pageContext.request.contextPath}/login"
                           class="flex items-center gap-2 bg-indigo-600 hover:bg-indigo-700
                                  text-white text-sm font-semibold px-4 py-2 rounded-xl
                                  shadow-md shadow-indigo-200 dark:shadow-none transition-all">
                            <i class="fas fa-sign-in-alt text-xs"></i> Se connecter
                        </a>
                    </c:when>

                    <%-- CONNECTÉ --%>
                    <c:otherwise>
                        <div class="w-px h-7 bg-slate-200 dark:bg-slate-700 mx-1"></div>

                        <div class="user-chip">
                            <div class="user-avatar" id="avatarInit">??</div>
                            <div class="hidden lg:flex flex-col leading-none">
                                <span class="text-[10px] font-bold text-indigo-600 uppercase tracking-wide">
                                    ${role}
                                </span>
                                <span class="text-sm font-semibold text-slate-800 dark:text-slate-200 mt-0.5">
                                    ${displayNom}
                                </span>
                            </div>
                        </div>

                        <button onclick="handleLogout()"
                                title="Se déconnecter"
                                class="w-9 h-9 flex items-center justify-center rounded-xl
                                       bg-red-50 dark:bg-red-900/20
                                       text-red-500 dark:text-red-400
                                       border border-red-100 dark:border-red-900/40
                                       hover:bg-red-600 hover:text-white
                                       transition-all duration-200">
                            <i class="fas fa-power-off text-sm"></i>
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </div>
</nav>

<script>
    /* ── Initiales avatar ── */
    const avatarEl = document.getElementById('avatarInit');
    if (avatarEl) {
        const nom = "${not empty displayNom ? displayNom : ''}";
        avatarEl.textContent = nom.trim().substring(0, 2).toUpperCase() || '??';
    }

    /* ── Thème ── */
    const themeBtn = document.getElementById('themeToggle');
    const sun  = document.getElementById('sunIcon');
    const moon = document.getElementById('moonIcon');

    function updateIcons() {
        const dark = document.documentElement.classList.contains('dark');
        sun.classList.toggle('hidden', !dark);
        moon.classList.toggle('hidden', dark);
    }
    updateIcons();
    themeBtn.addEventListener('click', () => {
        const dark = document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', dark ? 'dark' : 'light');
        updateIcons();
    });

    /* ── Déconnexion ── */
    function handleLogout() {
        const dark = document.documentElement.classList.contains('dark');
        const name = "${not empty displayNom ? displayNom : ''}";
        Swal.fire({
            title: 'Déconnexion ?',
            html: `Voulez-vous quitter la session, <b>${name}</b> ?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#4f46e5',
            cancelButtonColor: '#ef4444',
            confirmButtonText: 'Oui, déconnecter',
            cancelButtonText: 'Annuler',
            background: dark ? '#1e293b' : '#fff',
            color: dark ? '#f1f5f9' : '#1e293b',
            customClass: { popup: 'rounded-3xl border border-slate-200 dark:border-slate-700' }
        }).then(r => { if (r.isConfirmed) window.location.href = "${pageContext.request.contextPath}/logout"; });
    }
</script>