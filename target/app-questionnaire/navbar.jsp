<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<script src="https://cdn.tailwindcss.com"></script>

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
            @apply bg-white dark:bg-gray-950 text-gray-900 dark:text-gray-100 transition-colors duration-300 min-h-screen;
        }
        /* Classe réutilisable pour les conteneurs de tableaux/formulaires */
        .card-container {
            @apply bg-white dark:bg-gray-900 border border-gray-200 dark:border-gray-800 rounded-xl shadow-xl overflow-hidden;
        }
    }
</style>

<nav class="flex items-center justify-between px-8 py-4 border-b bg-white dark:bg-gray-900 border-gray-200 dark:border-gray-800 transition-colors duration-300">

    <div class="flex items-center gap-2">
        <img src="${pageContext.request.contextPath}/images/qcm.png"
            class="rounded-lg h-10 w-10 object-contain" alt="logo" />
        <span class="font-mono text-3xl uppercase">
            <span class="text-white">qcm</span>
        </span>
    </div>

    <div class="flex gap-2 text-sm font-medium">
        <c:set var="uri" value="${pageContext.request.requestURI}"/>
        <c:set var="currentAction" value="${param.action}"/>

        <c:set var="base"     value="px-4 py-2 rounded-lg transition-all duration-200"/>
        <c:set var="inactive" value="text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-800"/>
        <c:set var="active"   value="bg-blue-800 text-blue-800 font-bold shadow-md"/>

        <a href="${pageContext.request.contextPath}/"
           class="${base} ${uri.endsWith('/') || uri.endsWith('index.jsp') ? active : inactive}">
            Tableau de Bord
        </a>
        <a href="${pageContext.request.contextPath}/etudiants"
           class="${base} ${uri.contains('/etudiants') ? active : inactive}">
            Étudiants
        </a>
        <a href="${pageContext.request.contextPath}/examen?action=passer" <%-- CORRIGÉ : lien complet --%>
           class="${base} ${uri.contains('/examen') && currentAction == 'passer' ? active : inactive}">
            Examen
        </a>
        <a href="${pageContext.request.contextPath}/qcm"
           class="${base} ${uri.contains('/qcm') ? active : inactive}">
            QCM
        </a>
        <a href="${pageContext.request.contextPath}/examen?action=resultats"
           class="${base} ${currentAction == 'resultats' ? active : inactive}">
            Résultats
        </a>
    </div>

    <div class="flex items-center gap-4">
        <button id="themeToggle"
                class="p-2 rounded-lg bg-gray-100 dark:bg-gray-800 hover:ring-2 hover:ring-blue-400 transition-all text-xl">
            <span id="iconDark">☀️</span>
            <span id="iconLight" class="hidden">🌙</span>
        </button>

        <div class="text-xs font-mono bg-gray-50 dark:bg-gray-800 px-3 py-1.5 rounded-full text-gray-500 dark:text-gray-400 border border-gray-200 dark:border-gray-700">
            <%= java.time.Year.now().getValue() - 1 %>-<%= java.time.Year.now().getValue() %>
        </div>
    </div>
</nav>

<script>
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
    });
</script>