<%@ page contentType="text/html;charset=UTF-8" %>

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
    <main class="max-w-xl mx-auto p-6">
        <div class="flex items-center gap-4 mb-8">
            <a href="<%= request.getContextPath() %>/qcm" class="p-2 rounded-lg transitions-colors">
                <i class="bi bi-arrow-left text-lg"></i>
            </a>
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4">
                Ajouter une nouvelle Question
            </h1>
        </div>

        <% if(request.getAttribute("erreur") != null) { %>
            <div class="mb-6 p-4 bg-red-900/30 border border-red-700 text-red-400 text-sm flex items-center gap-2">
                <i class="bi bi-exclamation-circle"></i>
                <%= request.getAttribute("erreur") %>
            </div>
        <% } %>

        <form method="POST" action="<%= request.getContextPath() %>/qcm" class="border rounded-xl p-6 space-y-5 shadow-xl">
            <input type="hidden" name="action" value="ajouter">
            <div class="space-y-1">
                <label for="Question" class="text-xs font-bold tracking-wider">
                    Question*
                </label>
                <input type="text" name="question" required placeholder="Poser la question ici"
                    class="w-full px-4 py-2.5 rounded-lg text-sm transition-all" />
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label for="reponse1" class="text-xs font-bold tracking-wider">
                        Réponse1
                    </label>
                    <input type="text" name="reponse1" required placeholder="Reponse1" 
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
                <div class="space-y-1">
                    <label for="reponse2" class="text-xs font-bold tracking-wider">
                        Réponse2
                    </label>
                    <input type="text" name="reponse2" required placeholder="Reponse2"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
                <div class="space-y-1">
                    <label for="reponse3" class="text-xs font-bold tracking-wider">
                        Réponse3
                    </label>
                    <input type="text" name="reponse3" required placeholder="Reponse3"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
                <div class="space-y-1">
                    <label for="reponse4" class="text-xs font-bold tracking-wider">
                        Réponse4
                    </label>
                    <input type="text" name="reponse4" required placeholder="Reponse4"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>
            </div>

            <div class="space-y-1">
                <label for="bonneReponse" class="text-xs font-bold tracking-wider">
                    Bonne Réponse
                </label>

                <select name="bonne_reponse"
                    class="w-full px-4 py-2.5 rounded-lg text-sm
                        border border-gray-300 dark:border-gray-700
                        bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                        focus:ring-2 focus:ring-blue-500 outline-none"/>
                    <option class="dark:bg-gray-800" value="1">Option 1</option>
                    <option class="dark:bg-gray-800" value="2">Option 2</option>
                    <option class="dark:bg-gray-800" value="3">Option 3</option>
                    <option class="dark:bg-gray-800" value="3">Option 4</option>
                </select>
            </div>

            <div class="flex gap-4 pt-2">
                <a href="<%= request.getContextPath() %>/qcm" class="flex-l text-center px-4 py-3 bg-red-700 hover:bg-red-600
                    rounded-xl text-sm font-medium transition-colors">
                    Annuler
                </a>
                <button type="submit"
                        class="flex-1 px-4 py-3 bg-blue-600 hover:bg-blue-500 rounded-xl 
                               text-sm font-bold shadow-lg shadow-blue-900/20 transition-all 
                               flex items-center justify-center gap-2">
                    <i class="bi bi-person-plus"></i> Enregistrer question
                </button>
            </div>
        </form>
    </main>
</body>
</html>