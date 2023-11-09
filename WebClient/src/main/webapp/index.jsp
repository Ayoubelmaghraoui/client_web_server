<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion d'un établissement</title>
<!-- Add Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="display-4 text-center mb-4">Gestion d'un établissement</h1>
        <form action="EtudiantController" class="mb-3">
            <button class="btn btn-primary btn-block">Gestion des étudiants</button>
        </form>
        
        <form action="FiliereController" class="mb-3">
            <button class="btn btn-primary btn-block">Gestion des filières</button>
        </form>
        
        <form action="RoleController" class="mb-3">
            <button class="btn btn-primary btn-block">Gestion des roles</button>
        </form>
    </div>
    <!-- Add Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
