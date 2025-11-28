<%-- 
    Document   : cliapagar
    Created on : 27 de nov. de 2025, 16:38:23
    Author     : Notezin
--%>

<%@page import="model.DAO.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exclusão de Funcionário</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <!-- Font Awesome para ícones -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f6f9;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="card shadow-lg">
        <div class="card-header bg-danger text-white text-center">
            <h2 class="mb-0">
                <i class="fas fa-trash-alt me-2"></i>Controle de Funcionários - Apagar
            </h2>
        </div>
        <div class="card-body">
            <%
            try {
                // Instância do objeto                        
                int id = Integer.parseInt(request.getParameter("ident"));
                // Excluir
                FuncionarioDAO funcDAO = new FuncionarioDAO();
                if (funcDAO.excluir(id)) { 
            %>
            <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i>Funcionário excluído com sucesso!!!
            </div>
            <% } else { %>
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>Funcionário não encontrado ou não pôde ser excluído!
            </div>
            <% } 
            } catch (NumberFormatException e) { %>
            <div class="alert alert-warning" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>ID inválido. Por favor, insira um número válido.
            </div>
            <% } %>
                          <div class="text-center mt-3">
                  <a href="../home.jsp" class="btn btn-secondary">
                      <i class="fas fa-arrow-left me-2"></i>Voltar ao Menu
                  </a>
              </div>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>