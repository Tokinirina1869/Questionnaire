<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>

<html lang="fr">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Gestion de Questionnaire</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="min-h-screen">

<!-- NAV -->
<jsp:include page="navbar.jsp" />


<!-- STATS -->
<div class="grid grid-cols-4 gap-4 p-6 border-b border-gray-700">

  <div class="bg-gray-800 border border-gray-700 rounded-xl p-4">
    <div class="text-2xl font-semibold text-blue-400">48</div>
    <div class="text-xs text-gray-400 uppercase">Étudiants</div>
  </div>

  <div class="bg-gray-800 border border-gray-700 rounded-xl p-4">
    <div class="text-2xl font-semibold text-green-400">120</div>
    <div class="text-xs text-gray-400 uppercase">Questions</div>
  </div>

  <div class="bg-gray-800 border border-gray-700 rounded-xl p-4">
    <div class="text-2xl font-semibold text-yellow-400">32</div>
    <div class="text-xs text-gray-400 uppercase">Examens</div>
  </div>

  <div class="bg-gray-800 border border-gray-700 rounded-xl p-4">
    <div class="text-2xl font-semibold text-purple-400">6.4</div>
    <div class="text-xs text-gray-400 uppercase">Moyenne</div>
  </div>

</div>

<!-- MAIN -->
<div class="grid grid-cols-2 gap-6 p-6">

  <!-- CLASSEMENT -->
  <div class="bg-gray-800 border border-gray-700 rounded-xl">
    
    <div class="p-4 border-b border-gray-700 flex justify-between">
      <span class="text-sm">Classement</span>
      <button class="text-gray-400 text-sm">Voir</button>
    </div>

    <div class="p-4 space-y-3">

      <div class="flex items-center gap-3">
        <span class="text-yellow-400 text-xs font-mono">01</span>
        <div class="flex-1">
          <div class="text-sm">RABE Marie</div>
          <div class="w-full bg-gray-700 h-1 rounded">
            <div class="bg-blue-500 h-1 rounded" style="width:95%"></div>
          </div>
        </div>
        <span class="text-green-400 text-sm">9.5</span>
      </div>

    </div>

  </div>

  <!-- QCM -->
  <div class="col-span-2 bg-gray-800 border border-gray-700 rounded-xl">

    <div class="flex justify-between p-4 border-b border-gray-700">
      <span class="text-sm">Questions QCM</span>
      <button class="bg-blue-500 px-3 py-1 rounded text-sm">+ Question</button>
    </div>

    <div class="p-4 space-y-4">

      <div class="border-b border-gray-700 pb-4">
        <div class="text-xs text-gray-400 mb-1">#001</div>
        <div class="text-sm mb-2">
          Complexité du quicksort ?
        </div>

        <div class="flex flex-wrap gap-2 text-xs">
          <span class="bg-gray-700 px-2 py-1 rounded">O(n²)</span>
          <span class="bg-green-900 text-green-400 px-2 py-1 rounded border border-green-700">
            O(n log n) ✓
          </span>
        </div>
      </div>

    </div>

  </div>

</div>

<div id="addStudentModal" class="fixed inset-0 bg-black/60 backdrop-blur-sm hidden items-center justify-center z-50">
    
    <div class="bg-gray-800 border border-gray-700 w-full max-w-md rounded-xl shadow-2xl overflow-hidden">
        
        <div class="flex justify-between items-center p-4 border-b border-gray-700 bg-gray-900/50">
            <h3 class="text-lg font-medium text-blue-400">Nouvel Étudiant</h3>
            <button onclick="toggleModal()" class="text-gray-400 hover:text-white">&times;</button>
        </div>

        <form method="POST" action="<%= request.getContextPath() %>/etudiants" class="p-6 space-y-4">
            <div>
                <label class="block text-xs text-gray-400 uppercase mb-1">Numéro Étudiant</label>
                <input type="text" name="num_etudiant" required
                    class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded focus:border-blue-500 outline-none text-sm">
            </div>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs text-gray-400 uppercase mb-1">Nom</label>
                    <input type="text" name="nom" required
                        class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded focus:border-blue-500 outline-none text-sm">
                </div>
                <div>
                    <label class="block text-xs text-gray-400 uppercase mb-1">Prénoms</label>
                    <input type="text" name="prenoms" required
                        class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded focus:border-blue-500 outline-none text-sm">
                </div>
            </div>
            <div>
                <label class="block text-xs text-gray-400 uppercase mb-1">Niveau</label>
                <select name="niveau" class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded focus:border-blue-500 outline-none text-sm">
                    <option value="L1">Licence 1</option>
                    <option value="L2">Licence 2</option>
                    <option value="L3">Licence 3</option>
                    <option value="M1">Master 1</option>
                    <option value="M2">Master 2</option>
                </select>
            </div>
            <div>
                <label class="block text-xs text-gray-400 uppercase mb-1">Email</label>
                <input type="email" name="adr_email" required
                    class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded focus:border-blue-500 outline-none text-sm">
            </div>

            <div class="flex gap-3 pt-2">
                <button type="button" onclick="toggleModal()" 
                    class="flex-1 px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded text-sm transition-colors">Annuler</button>
                <button type="submit" 
                    class="flex-1 px-4 py-2 bg-blue-600 hover:bg-blue-500 rounded text-sm font-medium transition-colors">Enregistrer</button>
            </div>
        </form>
    </div>
</div>


<script>
function toggleModal() {
    const modal = document.getElementById('addStudentModal');
    if (modal.classList.contains('hidden')) {
        modal.classList.remove('hidden');
        modal.classList.add('flex');
    } else {
        modal.classList.add('hidden');
        modal.classList.remove('flex');
    }
}

// Fermer le modal si on clique à l'extérieur du cadre gris
window.onclick = function(event) {
    const modal = document.getElementById('addStudentModal');
    if (event.target == modal) {
        toggleModal();
    }
}
</script>

</body>
</html>