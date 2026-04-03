<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.monapp.model.Etudiant" %>

<html>
<head>
    <title>Liste des étudiants</title>
</head>
<body>
<h2>Ajouter un étudiant</h2>
<form method="post" action="<%= request.getContextPath() %>/etudiants">
    Num Étudiant: <input type="text" name="num_etudiant"/><br/>
    Nom: <input type="text" name="nom"/><br/>
    Prenoms: <input type="text" name="prenoms"/><br/>
    Niveau: <input type="text" name="niveau"/><br/>
    Email: <input type="email" name="adr_email"/><br/>
    <button type="submit">Ajouter</button>
</form>

<h2>Liste des étudiants</h2>
<table border="1">
    <tr>
        <th>Num Étudiant</th>
        <th>Nom</th>
        <th>Prenoms</th>
        <th>Niveau</th>
        <th>Email</th>
    </tr>
    <%
        List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
        if (etudiants != null) {
            for (Etudiant e : etudiants) {
    %>
    <tr>
        <td><%= e.getNumEtudiant() %></td>
        <td><%= e.getNom() %></td>
        <td><%= e.getPrenoms() %></td>
        <td><%= e.getNiveau() %></td>
        <td><%= e.getAdrEmail() %></td>
    </tr>
    <%      }
        }
    %>
</table>
</body>
</html>