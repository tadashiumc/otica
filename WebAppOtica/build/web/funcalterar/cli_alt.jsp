<%-- 
    Document   : cliente
    Created on : 21 de ago. de 2025, 21:12:36
    Author     : alunocmc
--%>

<%@page import="model.Funcionario"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Controle de Funcionários - Alterar</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
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
        <div class="card-header bg-warning text-white text-center">
            <h2 class="mb-0">
                <i class="fas fa-edit me-2"></i>Controle de Funcionários - Alterar
            </h2>
        </div>
        <div class="card-body">
            <%
            try {
                // Instância do objeto
                Funcionario func = new Funcionario();
                func.setIdFuncionario(Integer.parseInt(request.getParameter("ident")));
                func.setNomeCompleto(request.getParameter("nomeCompleto"));
                func.setCpf(request.getParameter("cpf"));
                func.setEmail(request.getParameter("email"));
                func.setTelefone(request.getParameter("telefone"));
                
                // Conversão de data nascimento
                String dataNascimento = request.getParameter("dataNascimento");
                if (dataNascimento != null && !dataNascimento.isEmpty()) {
                    func.setDataNascimento(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dataNascimento));
                }
                
                // Campos específicos de funcionário
                func.setCargo(request.getParameter("cargo"));
                
                // Conversão de data admissão
                String dataAdmissao = request.getParameter("dataAdmissao");
                if (dataAdmissao != null && !dataAdmissao.isEmpty()) {
                    func.setDataAdmissao(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dataAdmissao));
                }
                
                // Conversão de salário
                func.setSalario(Double.parseDouble(request.getParameter("salario")));
                
                func.setStatus(request.getParameter("status"));
                
                // Salvar a Alteração
                FuncionarioDAO funcDAO = new FuncionarioDAO();
                if (funcDAO.alterar(func)) {
            %>
            <div class="alert alert-success" role="alert">
                <i class="fas fa-check-circle me-2"></i>
                Funcionário alterado com sucesso!!!
            </div>
            <% } else { %>
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Erro ao alterar o funcionário!
            </div>
            <% } 
            } catch (Exception e) { 
            %>
            <div class="alert alert-warning" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                Erro no processamento: <%= e.getMessage() %>
            </div>
            <% } %>
            <div class="text-center mt-3">
                <a href="../index.html" class="btn btn-secondary">
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
