<script src="https://cdn.tailwindcss.com"></script>

<nav class="flex items-center justify-between px-8 py-4 border-b">
  <div class="font-mono text-blue-400">qcm<span>.app</span></div>

  <div class="flex gap-2 text-sm">
    <a href="<%= request.getContextPath() %>/" class="px-3 py-1 rounded">Tableau de Bord</a>
    <a href="<%= request.getContextPath() %>/etudiants" class="px-3 py-1 rounded" >Etudiants</a>
    <a href="<%= request.getContextPath() %>/qcm" class="px-3 py-1 rounded">QCM</a>
    <a href="<%= request.getContextPath() %>/examen" class="px-3 py-1 rounded">Examen</a>
  </div>

  <div class="text-xs font-mono">2024-2025</div>
</nav>