<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Gestion QCM</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-900 text-gray-100 min-h-screen">

<!-- NAV -->
<nav class="flex items-center justify-between px-8 py-4 border-b border-gray-700 bg-gray-800">
  <div class="font-mono text-blue-400">qcm<span class="text-white">.app</span></div>

  <div class="flex gap-2 text-sm">
    <a class="px-3 py-1 rounded bg-gray-700 text-white">Dashboard</a>
    <a class="px-3 py-1 rounded text-gray-400 hover:bg-gray-700 hover:text-white">Étudiants</a>
    <a class="px-3 py-1 rounded text-gray-400 hover:bg-gray-700 hover:text-white">QCM</a>
    <a class="px-3 py-1 rounded text-gray-400 hover:bg-gray-700 hover:text-white">Examen</a>
  </div>

  <div class="text-xs text-gray-400 font-mono">2024-2025</div>
</nav>

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

  <!-- ETUDIANTS -->
  <div class="bg-gray-800 border border-gray-700 rounded-xl overflow-hidden">
    
    <div class="flex justify-between items-center p-4 border-b border-gray-700">
      <span class="text-sm">Étudiants récents</span>
      <button class="bg-blue-500 hover:bg-blue-600 px-3 py-1 text-sm rounded">+ Ajouter</button>
    </div>

    <div class="p-4">
      <input type="text" placeholder="Rechercher..."
        class="w-full mb-3 px-3 py-2 rounded bg-gray-700 border border-gray-600 text-sm outline-none focus:border-blue-400"/>
      
      <table class="w-full text-sm">
        <thead class="text-gray-400 text-xs uppercase">
          <tr>
            <th class="text-left py-2">Numéro</th>
            <th>Nom</th>
            <th>Niveau</th>
          </tr>
        </thead>
        <tbody>
          <tr class="border-t border-gray-700 hover:bg-gray-700">
            <td class="py-2 text-gray-400 font-mono text-xs">ETU001</td>
            <td>RAKOTO Jean</td>
            <td class="text-center">
              <span class="bg-blue-900 text-blue-300 px-2 py-1 rounded text-xs">L1</span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>

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

</body>
</html>