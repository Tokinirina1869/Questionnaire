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
<div class="grid grid-cols-4 gap-4 p-6 border-b ">

  <div class="bg-gray-800 border  rounded-xl p-4">
    <div class="text-2xl font-semibold text-blue-400">48</div>
    <div class="text-xs uppercase">Étudiants</div>
  </div>

  <div class="bg-gray-800 border  rounded-xl p-4">
    <div class="text-2xl font-semibold text-green-400">120</div>
    <div class="text-xs uppercase">Questions</div>
  </div>

  <div class="bg-gray-800 border  rounded-xl p-4">
    <div class="text-2xl font-semibold text-yellow-400">32</div>
    <div class="text-xs uppercase">Examens</div>
  </div>

  <div class="bg-gray-800 border  rounded-xl p-4">
    <div class="text-2xl font-semibold text-purple-400">6.4</div>
    <div class="text-xs uppercase">Moyenne</div>
  </div>

</div>

  <!-- MAIN -->
  <div class="grid grid-cols-2 gap-6 p-6">

    <!-- CLASSEMENT -->
    <div class="bg-gray-800 border  rounded-xl">
      
      <div class="p-4 border-b  flex justify-between">
        <span class="text-sm">Classement</span>
        <button class=" text-sm">Voir</button>
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
    <div class="col-span-2 bg-gray-800 border  rounded-xl">

      <div class="flex justify-between p-4 border-b ">
        <span class="text-sm">Questions QCM</span>
        <button class="bg-blue-500 px-3 py-1 rounded text-sm">+ Question</button>
      </div>

      <div class="p-4 space-y-4">

        <div class="border-b  pb-4">
          <div class="text-xs mb-1">#001</div>
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