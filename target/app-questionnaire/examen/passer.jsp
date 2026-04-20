<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Qcm" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%
    List<Qcm> questions    = (List<Qcm>) request.getAttribute("questions");
    List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
    
    if (questions == null || etudiants == null) {
        out.println("<div style='color:white; background:red; padding:20px;'>");
        out.println("Erreur fatale : Les données (questions ou étudiants) sont absentes.<br>");
        out.println("Assurez-vous d'accéder à la page via <b>/examen?action=passer</b> et non directement au fichier .jsp");
        out.println("</div>");
        return; 
    }
    
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <jsp:include page="/navbar.jsp"/>

    <main class="max-w-3xl mx-auto p-6">
        <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4 mb-8">
            Passage de l'examen
        </h1>

        <form method="POST" action="<%= request.getContextPath() %>/examen"
              class="space-y-6">

            <!-- Infos étudiant -->
            <div class="border rounded-xl p-5 space-y-4">
                <h2 class="font-semibold text-blue-400">Informations</h2>

                <div>
                    <label class="text-xs font-bold uppercase">Étudiant</label>
                    <select name="num_etudiant" required
                        class="w-full px-4 py-2.5 rounded-lg text-sm 
                        border border-gray-300 dark:border-gray-700
                        bg-white dark:bg-gray-800 
                        text-gray-900 dark:text-gray-100
                        focus:ring-2 focus:ring-blue-500 outline-none">
                        <option value="">-- Choisir un étudiant --</option>
                        <% for (Etudiant e : etudiants) { %>
                            <option value="<%= e.getNumEtudiant() %>">
                                <%= e.getNumEtudiant() %> — <%= e.getNom() %> <%= e.getPrenoms() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div>
                    <label class="text-xs font-bold uppercase">
                        Année universitaire
                    </label>
                    <input type="text" name="annee_univ" required
                        placeholder="Ex: 2024-2025"
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                            border border-gray-300 dark:border-gray-700
                            bg-white dark:bg-gray-800 text-gray-800 dark:bg-gray-100
                            focus:ring-2 focus:ring-blue-500 outline-none"/>
                </div>

                <button type="button" onclick="afficherQuestions()" class="py-2 w-full text-white font-bold bg-blue-800 transition-all rounded-lg">
                    Passer à l'examen
                </button>
            </div>


            <!-- Questions -->

            <div id="section-questions" class="hidden space-y-6">
                <h2 class="text-xl font-semibold text-blue-400">Répondez aux questions</h2>
                <% int num = 1; for (Qcm q : questions) { %>
                    <div class="border rounded-xl p-5">

                        <input type="hidden" name="num_quest" value="<%= q.getNumQuest() %>"/>

                        <p class="font-medium mb-4">
                            <span class="text-blue-400 font-mono mr-2">Q<%= num++ %>.</span>
                            <%= q.getQuestion() %>
                        </p>

                        <div class="space-y-2">
                            <label class="flex items-center gap-3 p-3 rounded-lg border dark:border-gray-800 hover:bg-blue-900/20 cursor-pointer ">
                                <input type="radio" name="reponse_<%= q.getNumQuest() %>" value="1" required/>
                                <span class="text-sm"><%= q.getReponse1() %></span>
                            </label>
                            <label class="flex items-center gap-3 p-3 rounded-lg border dark:border-gray-800 hover:bg-blue-900/20 cursor-pointer  ">
                                <input type="radio" name="reponse_<%= q.getNumQuest() %>" value="2"/>
                                <span class="text-sm"><%= q.getReponse2() %></span>
                            </label>
                            <label class="flex items-center gap-3 p-3 rounded-lg border dark:border-gray-800 hover:bg-blue-900/20 cursor-pointer  ">
                                <input type="radio" name="reponse_<%= q.getNumQuest() %>" value="3"/>
                                <span class="text-sm"><%= q.getReponse3() %></span>
                            </label>
                            <label class="flex items-center gap-3 p-3 rounded-lg border dark:border-gray-800 hover:bg-blue-900/20 cursor-pointer  ">
                                <input type="radio" name="reponse_<%= q.getNumQuest() %>" value="4"/>
                                <span class="text-sm"><%= q.getReponse4() %></span>
                            </label>
                        </div>
                    </div>
                <% } %>


                <!-- Bouton soumettre -->
                <button type="submit"
                        class="w-full py-3 bg-blue-600 hover:bg-blue-500 rounded-xl
                            font-bold text-sm transition-all">
                    Soumettre mes réponses
                </button>
            </div>

        </form>
    </main>
    
    <script>
        function afficherQuestions(btn){
            const etudiant  = document.querySelector('select[name="num_etudiant"]').value;
            const annee     = document.querySelector('input[name="annee_univ"]').value;

            if(etudiant === "" || annee === "") {
                alert("Veuillez remplir les informations avant de commencer !")
                return;
            }
            document.getElementById('section-questions').classList.remove('hidden');

            document.getElementById('section-questions').scrollIntoView({ behavior:"smooth" });

            event.target.classList.add('opacity-50', 'cursor-not-allowed');
            event.target.innerText = "Examen en cours...";
        }
    </script>
</body>
</html>