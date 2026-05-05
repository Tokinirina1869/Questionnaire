<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Étudiants</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <script>
        tailwind.config = { darkMode: 'class' };
    </script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 transition-colors duration-300">

    <jsp:include page="/navbar.jsp" />

    <main class="max-w-8xl mx-auto p-6 text-gray-900 dark:text-gray-100">

        <div class="border rounded-xl shadow-xl overflow-hidden">

            <%-- Barre de recherche --%>
            <div class="p-4 border-b dark:border-gray-700 flex gap-5">
                <form method="GET" action="${pageContext.request.contextPath}/etudiants"
                      class="flex gap-3">
                    <input type="hidden" name="action" value="search"/>
                    <input type="text" name="q"
                        value="${not empty requestScope.query ? requestScope.query : ''}"
                        placeholder="Rechercher..."
                        class="w-full px-4 py-2.5 rounded-lg text-sm
                               border border-gray-300 dark:border-gray-700
                               bg-white dark:bg-gray-800 text-gray-800 dark:text-gray-100
                               focus:ring-2 focus:ring-blue-500 outline-none"/>
                    <button type="submit"
                            class="px-4 py-2 bg-blue-600 text-white hover:bg-blue-700 
                                   rounded-lg text-sm font-medium transition-colors 
                                   flex items-center gap-2">
                        <i class="bi bi-search"></i> Rechercher
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/etudiants" class="px-4 bg-amber-400 rounded-lg text-white text-sm font-medium hover:bg-amber-400 transition-colors 
                    flex items-center gap-3">
                    <i class="bi bi-arrow-clockwise"></i>
                    <span>Actualiser</span>
                </a>
            </div>

            <%-- Tableau --%>
            <div class="space-y-4 p-4">
                <c:choose>
                    <c:when test="${not empty groupes}">
                        <c:forEach var="entry" items="${groupes}">
                            <details class="group bg-white dark:bg-gray-800 dark:text-gray-100 
                                           border border-slate-200 dark:border-slate-700 
                                           rounded-xl overflow-hidden shadow-md" open>
                                <summary class="flex items-center justify-between p-5 
                                                cursor-pointer transition-all list-none
                                                hover:bg-gray-50 dark:hover:bg-gray-700/50">
                                    <span class="text-lg font-bold tracking-wide">${entry.key}</span>
                                    <div class="flex items-center gap-4">
                                        <span class="bg-blue-600 text-white px-4 py-1 
                                                     rounded-full text-xs font-bold">
                                            ${fn:length(entry.value)} étudiants
                                        </span>
                                        <i class="bi bi-chevron-down text-slate-500 
                                                  group-open:rotate-180 transition-transform"></i>
                                    </div>
                                </summary>

                                <div class="px-5 pb-5 border-t border-slate-200 dark:border-slate-700 
                                            bg-white dark:bg-gray-900">
                                    <table class="w-full text-left mt-4">
                                        <thead class="text-gray-500 dark:text-gray-400 text-sm">
                                            <tr>
                                                <th class="pb-3 text-center font-semibold">N° Matricule</th>
                                                <th class="pb-3 text-center font-semibold">Nom</th>
                                                <th class="pb-3 text-center font-semibold">Prénoms</th>
                                                <th class="pb-3 text-center font-semibold">Email</th>
                                                <th class="pb-3 text-center font-semibold">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                            <c:forEach var="e" items="${entry.value}">
                                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800/50 transition-colors">
                                                    <td class="py-4 text-center font-mono text-blue-500 text-sm">${e.numEtudiant}</td>
                                                    <td class="py-4 text-center uppercase text-gray-700 dark:text-gray-300">${e.nom}</td>
                                                    <td class="py-4 text-center text-gray-700 dark:text-gray-300">${e.prenoms}</td>
                                                    <td class="py-4 text-center text-gray-500 dark:text-gray-400 text-sm">${e.email}</td>
                                                    <td class="py-4 text-center">
                                                        <div class="flex justify-center gap-4">

                                                            <c:if test="${e.email == sessionScope.utilisateurConnecte.email || sessionScope.role == 'ADMIN'}">
                                                                <%-- Modifier --%>
                                                                <a href="?action=edit&id=${e.numEtudiant}"
                                                                   class="text-amber-500 hover:text-amber-400 transition-colors"
                                                                   title="Modifier">
                                                                    <i class="bi bi-pencil-square text-lg"></i>
                                                                </a>
                                                                <%-- Supprimer --%>
                                                                <button onclick="deleteStudent('${e.numEtudiant}', '${e.nom} ${e.prenoms}')"
                                                                        class="text-red-500 hover:text-red-400 transition-colors"
                                                                        title="Supprimer">
                                                                    <i class="bi bi-trash text-lg"></i>
                                                                </button>
                                                            </c:if>

                                                            <c:if test="${e.email != sessionScope.utilisateurConnecte.email && sessionScope.role != 'ADMIN'}">
                                                                <span class="text-gray-400 opacity-40" title="Lecture seule">
                                                                    <i class="bi bi-lock-fill text-lg"></i>
                                                                </span>
                                                            </c:if>

                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </details>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="text-center py-20 bg-white dark:bg-gray-800 rounded-xl 
                                    border border-dashed border-gray-300 dark:border-gray-700">
                            <i class="bi bi-inbox text-4xl text-gray-400"></i>
                            <p class="text-gray-500 mt-2">Aucune donnée disponible.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        const isDark = document.documentElement.classList.contains('dark');
        const swalBase = {
            background: isDark ? '#1e293b' : '#fff',
            color:      isDark ? '#f1f5f9' : '#1e293b',
            customClass: { popup: 'rounded-2xl' }
        };

        /* ── Confirmation suppression ── */
        function deleteStudent(id, nom) {
            Swal.fire({
                ...swalBase,
                title: 'Supprimer cet étudiant ?',
                html: `Vous êtes sur le point de supprimer <b>${nom}</b>.<br>Cette action est irréversible.`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#ef4444',
                cancelButtonColor:  '#6b7280',
                confirmButtonText:  '<i class="bi bi-trash me-1"></i> Oui, supprimer',
                cancelButtonText:   'Annuler',
            }).then(result => {
                if (result.isConfirmed) {
                    window.location.href =
                        '${pageContext.request.contextPath}/etudiants?action=delete&id=' + id;
                }
            });
        }

        /* ── Alertes après redirection ── */
        document.addEventListener('DOMContentLoaded', function () {
            const params = new URLSearchParams(window.location.search);
            const erreur = params.get('erreur');
            const succes = params.get('succes');

            /* Messages d'erreur */
            const erreurs = {
                delete_linked: {
                    title: 'Suppression impossible',
                    html:  "Cet étudiant est lié à des <b>examens ou résultats</b> existants.<br>Supprimez d'abord les données associées.",
                    icon:  'warning'
                },
                delete_forbidden: {
                    title: 'Action refusée',
                    html:  "Vous n'avez pas la permission de supprimer ce compte.",
                    icon:  'error'
                },
                not_found: {
                    title: 'Introuvable',
                    html:  "Cet étudiant n'existe pas ou a déjà été supprimé.",
                    icon:  'info'
                },
                invalid_id: {
                    title: 'Erreur',
                    html:  'Identifiant invalide.',
                    icon:  'error'
                }
            };

            /* Messages de succès */
            const succes_msgs = {
                deleted: {
                    title: 'Supprimé !',
                    html:  "L'étudiant a été supprimé avec succès.",
                    icon:  'success'
                },
                add: {
                    title: 'Ajouté !',
                    html:  'Nouvel étudiant ajouté avec succès.',
                    icon:  'success'
                },
                edit: {
                    title: 'Modifié !',
                    html:  "Les informations ont été mises à jour.",
                    icon:  'success'
                }
            };

            if (erreur && erreurs[erreur]) {
                Swal.fire({
                    ...swalBase,
                    ...erreurs[erreur],
                    confirmButtonColor: '#4f46e5',
                    confirmButtonText:  'Compris'
                });
            }

            if (succes && succes_msgs[succes]) {
                Swal.fire({
                    ...swalBase,
                    ...succes_msgs[succes],
                    timer: 2500,
                    showConfirmButton: false
                });
            }
        });
    </script>

</body>
</html>