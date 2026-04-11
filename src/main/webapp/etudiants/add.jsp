<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un étudiant</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="min-h-screen">

    <jsp:include page="/navbar.jsp" />

    <main class="max-w-xl mx-auto p-6">

        <!-- En-tête -->
        <div class="flex items-center gap-4 mb-8">
            <a href="<%= request.getContextPath() %>/etudiants"
               class="p-2 text-gray-400 hover:text-white hover:bg-gray-700 rounded-lg transition-colors">
                <i class="bi bi-arrow-left text-lg"></i>
            </a>
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4">
                Ajouter un étudiant
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
              class="border rounded-xl p-6 space-y-5 shadow-xl">

            <input type="hidden" name="action" value="ajouter"/>

            <!-- Numéro étudiant -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Numéro Étudiant *
                </label>
                <input type="text" name="num_etudiant" required
                       placeholder="Ex: ETU-001"
                       class="w-full px-4 py-2.5 rounded-lg text-sm transition-all"/>
            </div>

            <!-- Nom et Prénoms -->
            <div class="grid grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="text-xs font-bold tracking-wider">
                        Nom *
                    </label>
                    <input type="text" name="nom" required
                           class="w-full px-4 py-2.5 rounded-lg text-sm"/>
                </div>
                <div class="space-y-1">
                    <label class="text-xs font-bold tracking-wider">
                        Prénoms *
                    </label>
                    <input type="text" name="prenoms" required
                           class="w-full px-4 py-2.5 rounded-lg text-sm"/>
                </div>
            </div>

            <!-- Niveau -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Niveau d'étude *
                </label>
                <select name="niveau"
                        class="w-full px-4 py-2.5 rounded-lg text-sm">
                    <option value="L1">Licence 1 (L1)</option>
                    <option value="L2">Licence 2 (L2)</option>
                    <option value="L3">Licence 3 (L3)</option>
                    <option value="M1">Master 1 (M1)</option>
                    <option value="M2">Master 2 (M2)</option>
                </select>
            </div>

            <!-- Email -->
            <div class="space-y-1">
                <label class="text-xs font-bold tracking-wider">
                    Adresse Email *
                </label>
                <input type="email" name="adr_email" required
                       placeholder="nom@egmail.com"
                       class="w-full px-4 py-2.5 rounded-lg text-sm"/>
            </div>

            <!-- Boutons -->
            <div class="flex gap-4 pt-2">
                <a href="<%= request.getContextPath() %>/etudiants"
                   class="flex-1 text-center px-4 py-3 bg-red-700 hover:bg-red-600 
                          rounded-xl text-sm font-medium transition-colors">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 px-4 py-3 bg-blue-600 hover:bg-blue-500 rounded-xl 
                               text-sm font-bold shadow-lg shadow-blue-900/20 transition-all 
                               flex items-center justify-center gap-2">
                    <i class="bi bi-person-plus"></i> Enregistrer étudiant
                </button>
            </div>

        </form>
    </main>
</body>
</html>