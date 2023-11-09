<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <meta charset="UTF-8">
    <title>Gestion des étudiants</title>
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
            <h1 class="display-4">List of Students</h1>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
                Ajouter un étudiant
            </button>
        </div>

        <form action="EtudiantController" method="post" class="mb-4">
            <div class="form-group">
                <label for="filterFiliere">Filtre par Filiere:</label>
                <select name="filterFiliere" class="form-control">
                    <option value="0">All</option>
                    <c:forEach items="${filieres}" var="filiere">
                        <option value="${filiere.id}">${filiere.name} ${filiere.code}</option>
                    </c:forEach>
                </select>
                <input type="hidden" name="action" value="filterByFiliere">
            </div>
            <button type="submit" class="btn btn-primary">Filter</button>
        </form>
        
        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="EtudiantController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Ajouter un étudiant</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="login">Login:</label>
                            <input type="text" name="login" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="firstName">First Name:</label>
                            <input type="text" name="firstName" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="lastName">Last Name:</label>
                            <input type="text" name="lastName" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="telephone">Telephone:</label>
                            <input type="text" name="telephone" class="form-control" required><br><br>

                            <label class="custom-modal-label" for="filiere">Filiere:</label>
                            <select name="filiere" class="form-control" required>
                                <c:forEach items="${filieres}" var="filiere">
                                    <option value="${filiere.id}">${filiere.name} ${filiere.code}</option>
                                </c:forEach>
                            </select>
                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Save">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="modal fade" id="ModifyStudentModal" tabindex="-1" role="dialog" aria-labelledby="ModifyStudentModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="EtudiantController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="ModifyStudentModalTitle">Modifier un étudiant</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="login">Login:</label>
                            <input type="text" name="login" class="form-control" id="modalStudentLogin" required><br><br>

                            <label class="custom-modal-label" for="firstName">First Name:</label>
                            <input type="text" name="firstName" class="form-control" id="modalStudentFirstName" required><br><br>

                            <label class="custom-modal-label" for="lastName">Last Name:</label>
                            <input type="text" name="lastName" class="form-control" id="modalStudentLastName" required><br><br>

                            <label class="custom-modal-label" for="telephone">Telephone:</label>
                            <input type="text" name="telephone" class="form-control" id="modalStudentTelephone" required><br><br>

                            <label class="custom-modal-label" for="filiere">Filiere:</label>
                            <select name="filiere" class="form-control" id="modalStudentFiliere" required>
                                <c:forEach items="${filieres}" var="filiere">
                                    <option value="${filiere.id}">${filiere.name} ${filiere.code}</option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" id="modalStudentId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Save Changes">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="modal fade" id="AssignRoleModal" tabindex="-1" role="dialog" aria-labelledby="AssignRoleModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <form action="EtudiantController" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="AssignRoleModalTitle">Assign Role to Student</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label class="custom-modal-label" for="role">Select Role:</label>
                            <select name="role" class="form-control" required>
                                <c:forEach items="${Roles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>

                            <input type="hidden" name="action" value="addRole">
                            <input type="hidden" name="id" id="modalStudentId">
                            <input type="hidden" name="studentId" id="modalAssignRoleStudentId">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <input type="submit" class="btn btn-primary" value="Assign Role">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <table class="table">
            <thead class="thead-light">
                <tr>
                    <th>ID</th>
                    <th>Login</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Telephone</th>
                    <th>Filiere</th>
                    <th>Roles</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Etudiants}" var="etudiant">
                    <tr>
                        <td>${etudiant.id}</td>
                        <td>${etudiant.login}</td>
                        <td>${etudiant.firstName}</td>
                        <td>${etudiant.lastName}</td>
                        <td>${etudiant.telephone}</td>
                        <td>${etudiant.filiere.getName()}</td>
                        <td>
                            <c:forEach items="${etudiant.roles}" var="role">
                                ${role.name}<br>
                            </c:forEach>
                        </td>
                        <td class="d-flex align-items-center">
                            <form action="EtudiantController" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${etudiant.id}">
                                <button type="submit" class="btn btn-danger">Supprimer</button>
                            </form>
                            <button type="button" class="btn btn-secondary ml-2" data-toggle="modal" data-target="#ModifyStudentModal"
                                    data-student-id="${etudiant.id}" data-student-login="${etudiant.login}"
                                    data-student-firstname="${etudiant.firstName}" data-student-lastname="${etudiant.lastName}"
                                    data-student-telephone="${etudiant.telephone}" data-student-filiere="${etudiant.filiere}">
                                Modifier
                            </button>
                            <button type="button" class="btn btn-info ml-2" data-toggle="modal" data-target="#AssignRoleModal" data-student-id="${etudiant.id}">
                                Assign Role
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
        $('#ModifyStudentModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var studentId = button.data('student-id');
            var studentLogin = button.data('student-login');
            var studentFirstName = button.data('student-firstname');
            var studentLastName = button.data('student-lastname');
            var studentTelephone = button.data('student-telephone');
            var studentFiliere = button.data('student-filiere');
            var modal = $(this);

            modal.find('#modalStudentLogin').val(studentLogin);
            modal.find('#modalStudentFirstName').val(studentFirstName);
            modal.find('#modalStudentLastName').val(studentLastName);
            modal.find('#modalStudentTelephone').val(studentTelephone);
            modal.find('#modalStudentFiliere').val(studentFiliere);
            modal.find('#modalStudentId').val(studentId);
        });

        $('#AssignRoleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var studentId = button.data('student-id');
            var modal = $(this);

            modal.find('#modalAssignRoleStudentId').val(studentId);
        });
    </script>
</body>
</html>
