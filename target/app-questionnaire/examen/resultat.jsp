<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Résultats</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <div class="d-flex justify-content-between mb-4">
        <h1>Classement Général</h1>
        <a href="index.jsp" class="btn btn-secondary">Retour</a>
    </div>

    <table class="table table-striped border">
        <thead class="table-dark">
            <tr>
                <th>Rang</th>
                <th>Nom</th>
                <th>Matricule</th>
                <th>Année</th>
                <th>Note /10</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="ex" items="${examens}" varStatus="st">
                <tr>
                    <td>${st.count}</td>
                    <td>${ex.etudiant.nom} ${ex.etudiant.prenoms}</td>
                    <td>${ex.etudiant.numEtudiant}</td>
                    <td>${ex.anneeUniv}</td>
                    <td class="fw-bold">${ex.note}</td>
                    <td>
                        <c:choose>
                            <c:when test="${ex.note >= 5}">
                                <span class="badge bg-success">Admis</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Ajourné</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty examens}">
                <tr><td colspan="6" class="text-center">Aucune donnée trouvée.</td></tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>