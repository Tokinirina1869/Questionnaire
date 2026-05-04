<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Questionnaire</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .card-hover:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .fade-in {
            animation: slideIn 0.5s ease-out forwards;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .dark .glass-effect {
            background: rgba(30, 41, 59, 0.95);
            border-color: rgba(51, 65, 85, 0.8);
        }
        .status-badge {
            transition: all 0.2s ease;
        }
        .status-badge:hover {
            transform: scale(1.05);
        }
        .action-btn {
            transition: all 0.2s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
        }
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        .delay-0 { animation-delay: 0s; }
        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
        .delay-3 { animation-delay: 0.3s; }
        .delay-4 { animation-delay: 0.4s; }
        .delay-5 { animation-delay: 0.5s; }
        .delay-6 { animation-delay: 0.6s; }
        .delay-7 { animation-delay: 0.7s; }
        .delay-8 { animation-delay: 0.8s; }
        .delay-9 { animation-delay: 0.9s; }
        .delay-10 { animation-delay: 1.0s; }
    </style>
    <script>
        tailwind.config = { darkMode: 'class' };
    </script>
</head>
<body class="bg-white dark:bg-gray-800 transition-colors duration-300">

    <jsp:include page="/navbar.jsp" />
    
    <div class="max-w-8xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Header moderne -->
        <div class="mb-10 fade-in">
            <div class="flex flex-col md:flex-row md:items-center md:justify-between">
                <div class="mb-4 md:mb-0">
                    <div class="flex items-center space-x-3 mb-2">
                        <div class="p-3 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-xl shadow-lg">
                            <i class="fas fa-shield-alt text-white text-xl"></i>
                        </div>
                        <div>
                            <h1 class="text-3xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
                                Gestion des Accès
                            </h1>
                            <p class="text-gray-500 dark:text-gray-400* text-sm text-gray-500 dark:text-gray-400">Approuvez ou rejetez les demandes d'accès à la plateforme</p>
                        </div>
                    </div>
                </div>
                <div class="flex items-center space-x-3">
                    <div class="bg-gradient-to-r from-indigo-600 to-purple-600 text-white px-4 py-2 rounded-xl text-sm font-semibold shadow-lg">
                        <i class="fas fa-crown mr-2"></i>Espace Super Admin
                    </div>
                    <div class="bg-white/80 backdrop-blur-sm border border-gray-200 rounded-xl px-4 py-2 text-sm">
                        <i class="fas fa-users mr-2 text-indigo-600"></i>
                        <span class="font-semibold text-gray-500 dark:text-gray-400">${listeAdmins.size() + listeEtudiants.size()}</span> demandes
                    </div>
                </div>
            </div>
        </div>

        <!-- Filtres et statistiques -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
            <div class="bg-white dark:bg-gray-800 rounded-xl p-4 border border-gray-200 dark:border-gray-700 card-hover">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xstext-gray-500 dark:text-gray-400 uppercase tracking-wide">Administrateurs</p>
                        <p class="text-2xl font-bold text-indigo-600">${listeAdmins.size()}</p>
                    </div>
                    <div class="p-2 bg-indigo-100 rounded-lg">
                        <i class="fas fa-user-shield text-indigo-600"></i>
                    </div>
                </div>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-xl p-4 border border-gray-200 dark:border-gray-700 card-hover">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">Étudiants</p>
                        <p class="text-2xl font-bold text-blue-600">${listeEtudiants.size()}</p>
                    </div>
                    <div class="p-2 bg-blue-100 rounded-lg">
                        <i class="fas fa-graduation-cap text-blue-600"></i>
                    </div>
                </div>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-xl p-4 border border-gray-200 dark:border-gray-700 card-hover">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">En attente</p>
                        <p class="text-2xl font-bold text-yellow-600">
                            ${listeAdmins.stream().filter(a -> !a.approuve).count() + listeEtudiants.stream().filter(e -> !e.approuve).count()}
                        </p>
                    </div>
                    <div class="p-2 bg-yellow-100 rounded-lg">
                        <i class="fas fa-clock text-yellow-600"></i>
                    </div>
                </div>
            </div>
            <div class="bg-white dark:bg-gray-800 rounded-xl p-4 border border-gray-200 dark:border-gray-700 card-hover">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-xs text-gray-500 dark:text-gray-400 uppercase tracking-wide">Approuvés</p>
                        <p class="text-2xl font-bold text-green-600">
                            ${listeAdmins.stream().filter(a -> a.approuve).count() + listeEtudiants.stream().filter(e -> e.approuve).count()}
                        </p>
                    </div>
                    <div class="p-2 bg-green-100 rounded-lg">
                        <i class="fas fa-check-circle text-green-600"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Liste des administrateurs -->
        <div class="mb-8">
            <div class="flex items-center mb-4">
                <div class="p-2 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-lg mr-3">
                    <i class="fas fa-user-shield text-white"></i>
                </div>
                <h2 class="text-xl font-bold text-gray-500 dark:text-gray-400 ">Demandes d'accès Administrateur</h2>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <c:forEach var="a" items="${listeAdmins}" varStatus="status">
                    <div class="glass-effect rounded-xl p-6 border border-gray-100 card-hover text-center justify-center fade-in delay-${status.index}">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-full flex items-center justify-center text-white font-bold">
                                    ${a.nomAdmin.charAt(0)}
                                </div>
                                <div>
                                    <h3 class="font-semibold text-gray-500 dark:text-gray-400">${a.nomAdmin}</h3>
                                    <p class="text-xs text-gray-500 dark:text-gray-400">${a.emailAdmin}</p>
                                </div>
                            </div>
                            <span class="status-badge px-3 py-1 text-xs font-bold ${a.approuve ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700 pulse-animation'} rounded-full uppercase">
                                ${a.approuve ? 'Actif' : 'En attente'}
                            </span>
                        </div>
                        
                        <div class="space-y-2 mb-4">
                            <div class="flex items-center text-sm text-gray-500 dark:text-gray-400*">
                                <i class="fas fa-user-tag mr-2 text-indigo-500"></i>
                                <span>Administrateur</span>
                            </div>
                            <div class="flex items-center text-sm text-gray-500 dark:text-gray-400*">
                                <i class="fas fa-calendar mr-2 text-gray-400"></i>
                                <span>${a.dateInscrit}</span>
                            </div>
                        </div>
                        
                        <div class="flex space-x-2">
                            <c:choose>
                                <c:when test="${!a.approuve}">
                                    <form action="admin-gestion" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="${a.idAdmin}">
                                        <button type="submit" name="action" value="approuver_admin" 
                                                class="action-btn w-full bg-gradient-to-r from-green-500 to-green-600 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:from-green-600 hover:to-green-700 shadow-md">
                                            <i class="fas fa-check mr-1"></i>Approuver
                                        </button>
                                    </form>
                                    <form action="admin-gestion" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="${a.idAdmin}">
                                        <button type="submit" name="action" value="rejeter_admin" 
                                                class="action-btn w-full bg-gradient-to-r from-red-500 to-red-600 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:from-red-600 hover:to-red-700 shadow-md">
                                            <i class="fas fa-times mr-1"></i>Rejeter
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="flex-1 bg-green-50 border border-green-200 text-green-700 px-3 py-2 rounded-lg text-center text-sm font-semibold">
                                        <i class="fas fa-check-circle mr-1"></i>Validé
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Liste des étudiants -->
        <div class="mb-8">
            <div class="flex items-center mb-4">
                <div class="p-2 bg-gradient-to-r from-blue-600 to-cyan-600 rounded-lg mr-3">
                    <i class="fas fa-graduation-cap text-white"></i>
                </div>
                <h2 class="text-xl font-bold text-gray-500 dark:text-gray-400">Demandes d'accès Étudiant</h2>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <c:forEach var="e" items="${listeEtudiants}" varStatus="status">
                    <div class="glass-effect rounded-xl p-6 border border-blue-100 card-hover fade-in bg-blue-50/30 delay-${status.index}">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center space-x-3">
                                <div class="w-12 h-12 bg-gradient-to-r from-blue-600 to-cyan-600 rounded-full flex items-center justify-center text-white font-bold">
                                    ${e.nom.charAt(0)}
                                </div>
                                <div>
                                    <h3 class="font-semibold text-gray-500 dark:text-gray-400">${e.nom} ${e.prenoms}</h3>
                                    <p class="text-xs text-gray-500 dark:text-gray-400">${e.email}</p>
                                </div>
                            </div>
                            <span class="status-badge px-3 py-1 text-xs font-bold ${e.approuve ? 'bg-green-100 text-green-700' : 'bg-yellow-100 text-yellow-700 pulse-animation'} rounded-full uppercase">
                                ${e.approuve ? 'Actif' : 'En attente'}
                            </span>
                        </div>
                        
                        <div class="space-y-2 mb-4">
                            <div class="flex items-center text-sm text-gray-500 dark:text-gray-400*">
                                <i class="fas fa-graduation-cap mr-2 text-blue-500"></i>
                                <span>Étudiant (${e.niveau})</span>
                            </div>
                            <div class="flex items-center text-sm text-gray-500 dark:text-gray-400*">
                                <i class="fas fa-calendar mr-2 text-gray-400"></i>
                                <span>${e.dateInscrit}</span>
                            </div>
                        </div>
                        
                        <div class="flex space-x-2">
                            <c:choose>
                                <c:when test="${!e.approuve}">
                                    <form action="etudiants" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="${e.numEtudiant}">
                                        <button type="submit" name="action" value="approuver_etudiant" 
                                                class="action-btn w-full bg-gradient-to-r from-green-500 to-green-600 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:from-green-600 hover:to-green-700 shadow-md">
                                            <i class="fas fa-check mr-1"></i>Approuver
                                        </button>
                                    </form>
                                    <form action="etudiants" method="POST" class="flex-1">
                                        <input type="hidden" name="id" value="${e.numEtudiant}">
                                        <button type="submit" name="action" value="rejeter_etudiant" 
                                                class="action-btn w-full bg-gradient-to-r from-red-500 to-red-600 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:from-red-600 hover:to-red-700 shadow-md">
                                            <i class="fas fa-times mr-1"></i>Rejeter
                                        </button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <div class="flex-1 bg-green-50 border border-green-200 text-green-700 px-3 py-2 rounded-lg text-center text-sm font-semibold">
                                        <i class="fas fa-check-circle mr-1"></i>Validé
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Note de sécurité moderne -->
        <div class="glass-effect rounded-xl p-6 border border-blue-200 bg-gradient-to-r from-blue-50 to-indigo-50 fade-in">
            <div class="flex items-start space-x-4">
                <div class="p-3 bg-blue-100 rounded-lg">
                    <i class="fas fa-shield-alt text-blue-600 text-xl"></i>
                </div>
                <div class="flex-1">
                    <h3 class="font-semibold text-blue-900 mb-2">Note de sécurité importante</h3>
                    <p class="text-sm text-blue-700 leading-relaxed">
                        L'approbation d'un administrateur lui donne accès complet au monitoring SSL et à la gestion des certificats. 
                        Vérifiez soigneusement l'identité du demandeur avant de valider toute demande d'accès administrateur.
                    </p>
                    <div class="mt-3 flex items-center space-x-4 text-xs text-blue-600">
                        <span><i class="fas fa-lock mr-1"></i>Accès sécurisé</span>
                        <span><i class="fas fa-eye mr-1"></i>Vérification requise</span>
                        <span><i class="fas fa-certificate mr-1"></i>Permissions SSL</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>