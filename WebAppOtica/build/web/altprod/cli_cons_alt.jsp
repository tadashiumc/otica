<%-- 
    Document   : cliente consulta geral
    Created on : 04 de set. de 2025, 
    Author     : Adilson Lima   
--%>

<%@page import="model.Produto"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Cadastro de Produto</title>
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
                <i class="fas fa-edit me-2"></i>Alterar Cadastro de Produto
            </h2>
        </div>
        <div class="card-body">
            <%            
            Produto prod = new Produto();
            ProdutoDAO prodDAO = new ProdutoDAO();            
            prod.setIdProduto(Integer.parseInt(request.getParameter("ident")));            
            prod = prodDAO.consultaPorId(prod.getIdProduto()); // Chamada da consulta por ID.
            if (prod == null) {
            %>
            <div class="alert alert-danger text-center" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Produto não localizado!
            </div>
            <% } else { %>
            <form method="post" action="prod_alt.jsp">
                <div class="row g-3">
                    <div class="col-md-4">
                        <label for="identificador" class="form-label">Identificador</label>
                        <input 
                            type="number" 
                            class="form-control" 
                            id="identificador" 
                            name="ident" 
                            value="<%=prod.getIdProduto()%>" 
                            readonly
                        >
                    </div>
                    <div class="col-md-8">
                        <label for="codigoProduto" class="form-label">Código do Produto</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="codigoProduto" 
                            name="codigoProduto" 
                            value="<%=prod.getCodigoProduto()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-6">
                        <label for="nomeProduto" class="form-label">Nome do Produto</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="nomeProduto" 
                            name="nomeProduto" 
                            value="<%=prod.getNomeProduto()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-6">
                        <label for="marca" class="form-label">Marca</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="marca" 
                            name="marca" 
                            value="<%=prod.getMarca()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="tipoProduto" class="form-label">Tipo de Produto</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="tipoProduto" 
                            name="tipoProduto" 
                            value="<%=prod.getTipoProduto()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="precoCusto" class="form-label">Preço de Custo</label>
                        <input 
                            type="number" 
                            step="0.01" 
                            class="form-control" 
                            id="precoCusto" 
                            name="precoCusto" 
                            value="<%=prod.getPrecoCusto()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="precoVenda" class="form-label">Preço de Venda</label>
                        <input 
                            type="number" 
                            step="0.01" 
                            class="form-control" 
                            id="precoVenda" 
                            name="precoVenda" 
                            value="<%=prod.getPrecoVenda()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="quantidadeEstoque" class="form-label">Quantidade em Estoque</label>
                        <input 
                            type="number" 
                            class="form-control" 
                            id="quantidadeEstoque" 
                            name="quantidadeEstoque" 
                            value="<%=prod.getQuantidadeEstoque()%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="dataCadastro" class="form-label">Data de Cadastro</label>
                        <input 
                            type="date" 
                            class="form-control" 
                            id="dataCadastro" 
                            name="dataCadastro" 
                            value="<%=prod.getDataCadastro() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(prod.getDataCadastro()) : ""%>" 
                            required
                        >
                    </div>
                    <div class="col-md-4">
                        <label for="situacao" class="form-label">Situação</label>
                        <select 
                            class="form-select" 
                            id="situacao" 
                            name="situacao" 
                            required
                        >
                            <option value="Ativo" <%=prod.getSituacao().equals("Ativo") ? "selected" : ""%>>Ativo</option>
                            <option value="Inativo" <%=prod.getSituacao().equals("Inativo") ? "selected" : ""%>>Inativo</option>
                        </select>
                    </div>
                    <div class="col-12 d-flex justify-content-between">
                        <button type="submit" class="btn btn-warning">
                            <i class="fas fa-save me-2"></i>Salvar Alteração
                        </button>
                        <button 
                            type="button" 
                            class="btn btn-outline-secondary" 
                            onclick="window.location.href='../index.html'"
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