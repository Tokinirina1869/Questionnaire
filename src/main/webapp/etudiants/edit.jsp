<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.monapp.model.Etudiant" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>

    <jsp:include page="/navbar.jsp" />

    <%
        Etudiant e = (Etudiant) request.getAttribute("etudiant");
    %>

    <main class="max-w-xl mx-auto p-6">

        <!-- En-tête -->
        <div class="flex items-center gap-4 mb-8">
            <a href="<%= request.getContextPath() %>/etudiants"
               class="p-2 text-gray-400 hover:text-white hover:bg-gray-700 rounded-lg transition-colors">
                <i class="bi bi-arrow-left text-lg"></i>
            </a>
            <h1 class="text-2xl font-bold border-l-4 border-amber-500 pl-4">
                Modifier un étudiant
            </h1>
        </div>

        <!-- Message d'erreur éventuel -->
        <% if (request.getAttribute("erreur") != null) { %>
        <div class="mb-6 p-4 bg-red-900/30 border border-red-700 rounded-lg text-red-400 text-sm flex items-center gap-2">
            <i class="bi bi-exclamation-circle"></i>
            <%= request.getAttribute("erreur") %>
        </div>
        <% } %>

        <!-- Formulaire -->
        <form method="POST" action="<%= request.getContextPath() %>/etudiants"
              class="bg-gray-800 border border-gray-700 rounded-xl p-6 space-y-5 shadow-xl">

            <input type="hidden" name="action" value="modifier"/>

            <!-- Numéro étudiant — NON modifiable (clé primaire) -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Numéro Étudiant
                </label>
                <div class="relative">
                    <input type="text" name="num_etudiant"
                           value="<%= e.getNumEtudiant() %>" readonly
                           class="w-full px-4 py-2.5 rounded-lg 
                                  text-sm text-gray-400 cursor-not-allowed"/>
                    <span class="absolute right-3 top-1/2 -translate-y-1/2 text-xs 
                                px-2 py-0.5 rounded">
                        Non modifiable
                    </span>
                </div>
            </div>

            <!-- Nom et Prénoms -->
            <div class="grid grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="text-xs font-bold tracking-wider">
                        Nom *
                    </label>
                    <input type="text" name="nom" required
                        value="<%= e.getNom() %>"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                           border border-gray-300 dark:border-gray-700
                           bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                           focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
                <div class="space-y-1">
                    <label class="text-xs font-bold tracking-wider">
                        Prénoms *
                    </label>
                    <input type="text" name="prenoms" required
                        value="<%= e.getPrenoms() %>"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                           border border-gray-300 dark:border-gray-700
                           bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                           focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
            </div>

            <!-- Niveau -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Niveau d'étude *
                </label>
                <select name="niveau"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                           border border-gray-300 dark:border-gray-700
                           bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                           focus:ring-2 focus:ring-blue-500 outline-none"/>
                    <option class="dark:bg-gray-800" value="L1" <%= "L1".equals(e.getNiveau()) ? "selected" : "" %>>Licence 1 (L1)</option>
                    <option class="dark:bg-gray-800" value="L2" <%= "L2".equals(e.getNiveau()) ? "selected" : "" %>>Licence 2 (L2)</option>
                    <option class="dark:bg-gray-800" value="L3" <%= "L3".equals(e.getNiveau()) ? "selected" : "" %>>Licence 3 (L3)</option>
                    <option class="dark:bg-gray-800" value="M1" <%= "M1".equals(e.getNiveau()) ? "selected" : "" %>>Master 1 (M1)</option>
                    <option class="dark:bg-gray-800" value="M2" <%= "M2".equals(e.getNiveau()) ? "selected" : "" %>>Master 2 (M2)</option>
                </select>
            </div>

            <!-- Email -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Adresse Email *
                </label>
                <input type="email" name="adr_email" required
                    value="<%= e.getEmail() %>"
                    class="w-full px-4 py-2.5 rounded-lg text-sm
                        border border-gray-300 dark:border-gray-700
                        bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                        focus:ring-2 focus:ring-blue-500 outline-none"/>
            </div>

            <!-- Boutons -->
            <div class="flex gap-4 pt-2">
                <a href="<%= request.getContextPath() %>/etudiants"
                   class="flex-1 text-center px-4 py-3 bg-red-700 hover:bg-red-600 
                          rounded-xl text-sm font-medium transition-colors">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 px-4 py-3 bg-amber-600 hover:bg-amber-500 rounded-xl 
                               text-sm font-bold shadow-lg shadow-amber-900/20 transition-all 
                               flex items-center justify-center gap-2">
                    <i class="bi bi-check-circle"></i> Modifier
                </button>
            </div>

        </form>
    </main>
</body>
</html>