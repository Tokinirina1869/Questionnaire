<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>

<!DOCTYPE html>
<html lang="fr" class="bg-gray-900 text-gray-100">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Étudiants</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body class="min-h-screen">
    
    <jsp:include page="/navbar.jsp" />

    <main class="max-w-6xl mx-auto p-6">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold border-l-4 border-blue-500 pl-4">Listes des Étudiants inscrits</h1>
            <button onclick="toggleModal()" class="bg-blue-600 hover:bg-blue-700 text-white px-5 py-2 rounded-lg text-sm font-medium transition-all flex items-center gap-2">
                <span class="text-lg">+</span> Ajouter un étudiant
            </button>
        </div>

        <div class="border border-gray-700 rounded-xl shadow-xl overflow-hidden">
            <div class="p-4 border-b border-gray-700">
                <input type="text" placeholder="Rechercher un étudiant..." 
                       class="w-full md:w-80 px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-sm focus:outline-none focus:border-blue-500 transition-colors" />
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left">
                    <thead class="text-xs uppercase">
                        <tr>
                            <th class="px-6 py-4">Matricule</th>
                            <th class="px-6 py-4">Nom & Prénoms</th>
                            <th class="px-6 py-4 text-center">Niveau</th>
                            <th class="px-6 py-4">Email</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-700">
                        <%
                            List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
                            if(etudiants != null && !etudiants.isEmpty()) {
                                for (Etudiant e : etudiants) {
                        %>
                        <tr class="hover:bg-gray-750 transition-colors">
                            <td class="px-6 py-4 font-mono text-blue-400 text-sm"><%= e.getNumEtudiant() %></td>
                            <td class="px-6 py-4">
                                <div class="font-medium"><%= e.getNom() %></div>
                                <div class="text-xs text-gray-400"><%= e.getPrenoms() %></div>
                            </td>
                            <td class="px-6 py-4 text-center">
                                <span class="px-2 py-1 text-blue-300 rounded-md text-xs font-bold border border-blue-800/50">
                                    <%= e.getNiveau() %>
                                </span>
                            </td>
                            <td class="px-6 py-4 text-sm text-center italic"><%= e.getAdrEmail() %></td>
                            <td class="px-6 py-4">
                                <div class="flex justify-center items-center gap-3">
                                    <button onclick="editStudent(this)" 
                                            data-id="<%= e.getNumEtudiant() %>"
                                            data-nom="<%= e.getNom() %>"
                                            data-prenom="<%= e.getPrenoms() %>"
                                            data-niveau="<%= e.getNiveau() %>"
                                            data-email="<%= e.getAdrEmail() %>"
                                            class="...">
                                        <i class="bi bi-pencil-square"></i>
                                    </button>
                                    
                                    <button onclick="deleteStudent('<%= e.getNumEtudiant() %>')" 
                                            class="p-2 text-red-400 hover:bg-red-500/10 rounded-lg transition-colors"
                                            title="Supprimer">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% 
                                }
                            } else { 
                        %>
                        <tr>
                            <td colspan="4" class="px-6 py-12 text-center text-gray-500">
                                <div class="flex flex-col items-center">
                                    <span class="text-3xl mb-2">📁</span>
                                    <p>Aucun étudiant trouvé dans la base de données.</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div id="addStudentModal" class="fixed inset-0 bg-black/70 backdrop-blur-sm hidden items-center justify-center z-50 p-4">
        <div class="border border-gray-700 w-full max-w-md rounded-2xl shadow-2xl overflow-hidden transform transition-all">
            <div class="flex justify-between items-center p-5 border-b border-gray-700">
                <h3 class="text-lg font-semibold text-blue-400">Nouvel Étudiant</h3>
                <button onclick="toggleModal()" class="text-gray-400 hover:text-white transition-colors text-2xl">&times;</button>
            </div>

            <form method="POST" action="<%= request.getContextPath() %>/etudiants" class="p-6 space-y-5">
                <div class="space-y-1">
                    <label class="text-xs font-bold text-gray-400 uppercase tracking-wider">Numéro Étudiant</label>
                    <input type="text" name="num_etudiant" required placeholder="Ex: ETU-001"
                        class="w-full px-4 py-2.5 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none text-sm transition-all">
                </div>
                
                <div class="grid grid-cols-2 gap-4">
                    <div class="space-y-1">
                        <label class="text-xs font-bold text-gray-400 uppercase tracking-wider">Nom</label>
                        <input type="text" name="nom" required
                            class="w-full px-4 py-2.5 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
                    </div>
                    <div class="space-y-1">
                        <label class="text-xs font-bold text-gray-400 uppercase tracking-wider">Prénoms</label>
                        <input type="text" name="prenoms" required
                            class="w-full px-4 py-2.5 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
                    </div>
                </div>

                <div class="space-y-1">
                    <label class="text-xs font-bold text-gray-400 uppercase tracking-wider">Niveau d'étude</label>
                    <select name="niveau" class="w-full px-4 py-2.5 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
                        <option value="L1">Licence 1 (L1)</option>
                        <option value="L2">Licence 2 (L2)</option>
                        <option value="L3">Licence 3 (L3)</option>
                        <option value="M1">Master 1 (M1)</option>
                        <option value="M2">Master 2 (M2)</option>
                    </select>
                </div>

                <div class="space-y-1">
                    <label class="text-xs font-bold text-gray-400 uppercase tracking-wider">Adresse Email</label>
                    <input type="email" name="adr_email" required placeholder="nom@exemple.com"
                        class="w-full px-4 py-2.5 border border-gray-600 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none text-sm">
                </div>

                <div class="flex gap-4 pt-4">
                    <button type="button" onclick="toggleModal()" 
                        class="flex-1 px-4 py-3 bg-gray-700 hover:bg-gray-600 rounded-xl text-sm font-medium transition-colors">
                        Annuler
                    </button>
                    <button type="submit" 
                        class="flex-1 px-4 py-3 bg-blue-600 hover:bg-blue-500 rounded-xl text-sm font-bold shadow-lg shadow-blue-900/20 transition-all">
                        Enregistrer
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function toggleModal() {
            const modal = document.getElementById('addStudentModal');
            const isOpening = modal.classList.contains('hidden');
            
            if (isOpening) {
                modal.classList.remove('hidden');
                modal.classList.add('flex');
            } 
            else {
                // Réinitialiser le formulaire à la fermeture
                const form = modal.querySelector('form');
                form.reset();
                form.querySelector('input[name="num_etudiant"]').readOnly = false;
                modal.querySelector('h3').innerText = "Nouvel Étudiant";
                form.action = "<%= request.getContextPath() %>/etudiants"; // Action par défaut
                
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            }
        }

        window.onclick = function(event) {
            const modal = document.getElementById('addStudentModal');
            if (event.target == modal) {
                toggleModal();
            }
        }

        function deleteStudent(id) {
            if(confirm("Voulez-vous vraiment supprimer l'étudiant " + id + " ?")) {
                // Redirection vers une servlet de suppression ou appel Fetch API
                window.location.href = "<%= request.getContextPath() %>/etudiants?action=delete&id=" + id;
            }
        }

        function editStudent(btn) {
            const modal = document.getElementById('addStudentModal');
            const form  = modal.querySelector('form');

            // On récupère les données via dataset (plus propre et gère mieux les espaces/apostrophes)
            form.querySelector('input[name="num_etudiant"]').value = btn.dataset.id;
            form.querySelector('input[name="nom"]').value = btn.dataset.nom;
            form.querySelector('input[name="prenoms"]').value = btn.dataset.prenom;
            form.querySelector('select[name="niveau"]').value = btn.dataset.niveau;
            form.querySelector('input[name="adr_email"]').value = btn.dataset.email;

            toggleModal();
        }
    </script>
</body>
</html>