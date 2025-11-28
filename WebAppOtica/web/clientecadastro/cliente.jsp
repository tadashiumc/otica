<%-- 
Document   : cliente
Created on : 27 de nov. de 2025, 14:24:01
Author     : Notezin
--%>
<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page import="java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Controle de Clientes</title>
    
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
        <div class="card-header bg-primary text-white text-center">
            <h2 class="mb-0">
                <i class="fas fa-user-plus me-2"></i>Controle de Clientes
            </h2>
        </div>
        <div class="card-body">
            <%
            //Instância do objeto
            Cliente cli = new Cliente();
            if (request.getParameter("nomeCompleto") != null) {
                try {
                    // NÃO DEFINA O ID - deixe o banco gerar
                    cli.setNomeCompleto(request.getParameter("nomeCompleto"));
                    cli.setEmail(request.getParameter("email"));
                    cli.setTelefone(request.getParameter("telefone"));
                    cli.setDataNascimento(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataNascimento")));
                    cli.setCpf(request.getParameter("cpf"));
                    cli.setEndereco(request.getParameter("endereco"));
                    cli.setCidade(request.getParameter("cidade"));
                    cli.setEstado(request.getParameter("estado"));
                    cli.setObservacoes(request.getParameter("observacoes"));
            %>
            <div class="alert alert-info">
                <strong>Dados do Cliente:</strong>
                <ul class="list-unstyled">
                    <li><strong>Nome:</strong> <%= cli.getNomeCompleto() %></li>
                    <li><strong>E-mail:</strong> <%= cli.getEmail() %></li>
                    <li><strong>CPF:</strong> <%= cli.getCpf() %></li>
                    <li><strong>Telefone:</strong> <%= cli.getTelefone() %></li>
                    <li><strong>Nascimento:</strong> <%= cli.getDataNascimento() %></li>
                    <li><strong>Endereço:</strong> <%= cli.getEndereco() %></li>
                    <li><strong>Cidade:</strong> <%= cli.getCidade() %></li>
                    <li><strong>Estado:</strong> <%= cli.getEstado() %></li>
                    <li><strong>Observações:</strong> <%= cli.getObservacoes() %></li>
                </ul>
            </div>
            <%
                    //Salvar
                    ClienteDAO cliDAO = new ClienteDAO();
                    if (cliDAO.cadastrar(cli)) {
            %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>Cliente inserido com sucesso!!!
                    </div>
            <%
                    } else {
            %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>Erro ao cadastrar cliente!
                    </div>
            <%
                    }
                } catch (Exception e) {
            %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    Erro: <%= e.getMessage() %>
                </div>
            <%
                    e.printStackTrace();
                } 
            } else {
            %>
                <div class="alert alert-warning">
                    <i class="fas fa-info-circle me-2"></i>
                    Por favor, preencha todos os campos!
                </div>
            <% } %>
        </div>
        <div class="card-footer text-center">
            <a href="../" class="btn btn-secondary">
                <i class="fas fa-arrow-left me-2"></i>Voltar
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>