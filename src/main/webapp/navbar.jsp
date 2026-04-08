<script src="https://cdn.tailwindcss.com"></script>

<nav class="flex items-center justify-between px-8 py-4 border-b border-gray-700">
  <div class="font-mono text-blue-400">qcm<span class="text-white">.app</span></div>

  <div class="flex gap-2 text-sm">
    <a href="<%= request.getContextPath() %>/" class="px-3 py-1 rounded text-white">Tableau de Bord</a>
    <a href="<%= request.getContextPath() %>/etudiants" class="px-3 py-1 rounded text-gray-400 hover:bg-gray-700 hover:text-white" >Etudiants</a>
    <a href="<%= request.getContextPath() %>/qcm" class="px-3 py-1 rounded text-gray-400 hover:text-white">QCM</a>
    <a href="<%= request.getContextPath() %>/examen" class="px-3 py-1 rounded text-gray-400 hover:bg-gray-700 hover:text-white">Examen</a>
  </div>

  <div class="text-xs text-gray-400 font-mono">2024-2025</div>
</nav>