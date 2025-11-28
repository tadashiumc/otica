<%-- 
    Document   : cliente
    Created on : 21 de ago. de 2025, 21:12:36
    Author     : alunocmc
--%>

<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Controle de Clientes - Alterar</title>
    
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
                    <i class="fas fa-edit me-2"></i>Controle de Clientes - Alterar
                </h2>
            </div>
            <div class="card-body">
                <%
                try {
                    // Instância do objeto
                    Cliente cli = new Cliente();
                    cli.setIdCliente(Integer.parseInt(request.getParameter("ident")));
                    cli.setNomeCompleto(request.getParameter("nomeCompleto"));
                    cli.setCpf(request.getParameter("cpf"));
                    cli.setEmail(request.getParameter("email"));
                    cli.setTelefone(request.getParameter("telefone"));
                    
                    // Conversão de data
                    String dataNascimento = request.getParameter("dataNascimento");
                    if (dataNascimento != null && !dataNascimento.isEmpty()) {
                        cli.setDataNascimento(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(dataNascimento));
                    }
                    
                    cli.setEndereco(request.getParameter("endereco"));
                    cli.setCidade(request.getParameter("cidade"));
                    cli.setEstado(request.getParameter("estado"));
                    cli.setObservacoes(request.getParameter("observacoes"));

                    // Salvar a Alteração
                    ClienteDAO cliDAO = new ClienteDAO();
                    if (cliDAO.alterar(cli)) {
                %>
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        Cliente alterado com sucesso!!!
                    </div>
                <% } else { %>
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Erro ao alterar o cliente!
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
