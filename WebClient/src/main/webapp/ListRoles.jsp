<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Roles List</title>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            margin-top: 20px;
        }

        .custom-modal-label {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="/WebClient/index.jsp" class="btn btn-warning">HOME</a>
            <h1 class="display-4">Gestion des rôles</h1>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#RoleModal">
                Ajouter un rôle
            </button>
        </div>

        <!-- Add Role Modal -->
        <div class="modal fade" id="RoleModal" tabindex="-1" role="dialog" aria-labelledby="RoleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="RoleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="RoleModalCenterTitle">Ajouter un rôle</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Name">Nom du rôle</label>
                            <input type="text" name="Name" class="form-control" required>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modify Role Modal -->
        <div class="modal fade" id="ModifyRoleModal" tabindex="-1" role="dialog" aria-labelledby="ModifyRoleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="RoleController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyRoleModalCenterTitle">Modifier un rôle</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Name">Nom du rôle</label>
                            <input type="text" name="Name" id="modalRoleName" class="form-control" required>
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalRoleId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer les modifications">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>ID</th>
                    <th>Nom du rôle</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Roles}" var="role">
                    <tr>
                        <td>${role.id}</td>
                        <td>${role.name}</td>
                        <td class="d-flex align-items-center">
                            <form action="RoleController" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${role.id}">
                                <button type="submit" class="btn btn-danger">Supprimer</button>
                            </form>
                            <button type="button" class="btn btn-primary ml-2" data-toggle="modal" data-target="#ModifyRoleModal"
                                    data-role-id="${role.id}" data-role-name="${role.name}">
                                Modifier
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        $('#ModifyRoleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var roleId = button.data('role-id');
            var roleName = button.data('role-name');
            var modal = $(this);
            modal.find('#modalRoleId').val(roleId);
            modal.find('#modalRoleName').val(roleName);
        });
    </script>
</body>
</html>
