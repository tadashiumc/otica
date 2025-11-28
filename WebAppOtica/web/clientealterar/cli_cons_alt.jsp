<%-- 
    Document   : cliente consulta geral
    Created on : 04 de set. de 2025, 
    Author     : Adilson Lima   
--%>

<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Cadastro de Cliente</title>
    
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
                    <i class="fas fa-edit me-2"></i>Alterar Cadastro de Cliente
                </h2>
            </div>
            <div class="card-body">
                <%            
                Cliente cli = new Cliente();
                ClienteDAO cliDAO = new ClienteDAO();            
                cli.setIdCliente(Integer.parseInt(request.getParameter("ident")));            
                cli = cliDAO.consultaPorId(cli.getIdCliente()); // Chamada da consulta por ID.
                
                if (cli == null) {
                %>
                    <div class="alert alert-danger text-center" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Cliente não localizado!
                    </div>
                <% } else { %>
                    <form method="post" action="cli_alt.jsp">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="identificador" class="form-label">Identificador</label>
                                <input 
                                    type="number" 
                                    class="form-control" 
                                    id="identificador" 
                                    name="ident" 
                                    value="<%=cli.getIdCliente()%>" 
                                    readonly
                                >
                            </div>
                            
                            <div class="col-md-8">
                                <label for="nomeCompleto" class="form-label">Nome Completo</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="nomeCompleto" 
                                    name="nomeCompleto" 
                                    value="<%=cli.getNomeCompleto()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="cpf" class="form-label">CPF</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="cpf" 
                                    name="cpf" 
                                    value="<%=cli.getCpf()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="email" class="form-label">E-mail</label>
                                <input 
                                    type="email" 
                                    class="form-control" 
                                    id="email" 
                                    name="email" 
                                    value="<%=cli.getEmail()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="telefone" class="form-label">Telefone</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="telefone" 
                                    name="telefone" 
                                    value="<%=cli.getTelefone()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="dataNascimento" class="form-label">Data Nascimento</label>
                                <input 
                                    type="date" 
                                    class="form-control" 
                                    id="dataNascimento" 
                                    name="dataNascimento" 
                                    value="<%=cli.getDataNascimento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(cli.getDataNascimento()) : ""%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-8">
                                <label for="endereco" class="form-label">Endereço</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="endereco" 
                                    name="endereco" 
                                    value="<%=cli.getEndereco()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="cidade" class="form-label">Cidade</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="cidade" 
                                    name="cidade" 
                                    value="<%=cli.getCidade()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-md-4">
                                <label for="estado" class="form-label">Estado</label>
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="estado" 
                                    name="estado" 
                                    value="<%=cli.getEstado()%>" 
                                    required
                                >
                            </div>
                            
                            <div class="col-12">
                                <label for="observacoes" class="form-label">Observações</label>
                                <textarea 
                                    class="form-control" 
                                    id="observacoes" 
                                    name="observacoes" 
                                    rows="3"
                                ><%=cli.getObservacoes() != null ? cli.getObservacoes() : ""%></textarea>
                            </div>
                            
                            <div class="col-12 d-flex justify-content-between">
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-save me-2"></i>Salvar Alteração
                                </button>
                                <button 
                                    type="button" 
                                    class="btn btn-outline-secondary" 
                                    onclick="window.location.href='../home.jsp'"
                                >
                                    <i class="fas fa-arrow-left me-2"></i>Cancelar
                                </button>
                            </div>
                        </div>
                    </form>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>