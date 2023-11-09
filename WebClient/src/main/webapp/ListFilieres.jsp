<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Filières List</title>
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
            <h1 class="display-4">Gestion des Filières</h1>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#FiliereModalCenter">
                Ajouter une filière
            </button>
        </div>

        <!-- Add Filiere Modal -->
        <div class="modal fade" id="FiliereModalCenter" tabindex="-1" role="dialog" aria-labelledby="FiliereModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="FiliereController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="FiliereModalCenterTitle">Ajouter une filière</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Code">Code</label>
                            <input type="text" name="Code" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="Name">Nom</label>
                            <input type="text" name="Name" class="form-control" required><br><br>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
                            <input type="submit" class="btn btn-primary" value="Enregistrer">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modify Filiere Modal -->
        <div class="modal fade" id="ModifyFiliereModal" tabindex="-1" role="dialog" aria-labelledby="ModifyFiliereModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="FiliereController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyFiliereModalTitle">Modifier une filière</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="Code">Code</label>
                            <input type="text" name="Code" class="form-control" id="modalFiliereCode" required><br><br>

                            <label class="custom-modal-label" for="Name">Nom</label>
                            <input type="text" name="Name" class="form-control" id="modalFiliereName" required><br><br>

                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalFiliereId">
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
                    <th>Code</th>
                    <th>Nom</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Filieres}" var="Filiere">
                    <tr>
                        <td>${Filiere.id}</td>
                        <td>${Filiere.code}</td>
                        <td>${Filiere.name}</td>
                        <td class="d-flex align-items-center">
                            <form action="FiliereController" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${Filiere.id}">
                                <button type="submit" class="btn btn-danger">Supprimer</button>
                            </form>
                            <button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#ModifyFiliereModal"
                                    data-filiere-id="${Filiere.id}" data-filiere-code="${Filiere.code}" data-filiere-name="${Filiere.name}">
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
        $('#ModifyFiliereModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var filiereId = button.data('filiere-id');
            var filiereCode = button.data('filiere-code');
            var filiereName = button.data('filiere-name');
            var modal = $(this);

            modal.find('#modalFiliereCode').val(filiereCode);
            modal.find('#modalFiliereName').val(filiereName);
            modal.find('#modalFiliereId').val(filiereId);
        });
    </script>
</body>
</html>
