<%-- 
    Document   : func_consult_alt
    
    Author     : Notezin   
--%>

<%@page import="model.Funcionario"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Cadastro de Funcionário</title>
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
                <i class="fas fa-edit me-2"></i>Alterar Cadastro de Funcionário
            </h2>
        </div>
        <div class="card-body">
            <%            
            Funcionario func = new Funcionario();
            FuncionarioDAO funcDAO = new FuncionarioDAO();            
            func.setIdFuncionario(Integer.parseInt(request.getParameter("ident")));            
            func = funcDAO.consultaPorId(func.getIdFuncionario()); // Chamada da consulta por ID.
            if (func == null) {
            %>
            <div class="alert alert-danger text-center" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Funcionário não localizado!
            </div>
            <% } else { %>
            <form method="post" action="func_alt.jsp">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label for="identificador" class="form-label">Identificador</label>
                        <input 
                            type="number" 
                            class="form-control" 
                            id="identificador" 
                            name="ident" 
                            value="<%=func.getIdFuncionario()%>" 
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
                            value="<%=func.getNomeCompleto()%>" 
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
                            value="<%=func.getCpf()%>" 
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
                            value="<%=func.getEmail()%>" 
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
                            value="<%=func.getTelefone()%>" 
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
                            value="<%=func.getDataNascimento() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(func.getDataNascimento()) : ""%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="cargo" class="form-label">Cargo</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="cargo" 
                            name="cargo" 
                            value="<%=func.getCargo()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="dataAdmissao" class="form-label">Data Admissão</label>
                        <input 
                            type="date" 
                            class="form-control" 
                            id="dataAdmissao" 
                            name="dataAdmissao" 
                            value="<%=func.getDataAdmissao() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(func.getDataAdmissao()) : ""%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="salario" class="form-label">Salário</label>
                        <input 
                            type="number" 
                            step="0.01" 
                            class="form-control" 
                            id="salario" 
                            name="salario" 
                            value="<%=func.getSalario()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="status" class="form-label">Status</label>
                        <select 
                            class="form-select" 
                            id="status" 
                            name="status" 
                            required
                        >
                            <option value="Ativo" <%= func.getStatus().equals("Ativo") ? "selected" : "" %>>Ativo</option>
                            <option value="Inativo" <%= func.getStatus().equals("Inativo") ? "selected" : "" %>>Inativo</option>
                        </select>
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