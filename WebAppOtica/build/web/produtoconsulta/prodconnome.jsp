<%-- 
    Document   : cliconnome
    Created on : 27 de nov. de 2025, 15:54:17
    Author     : Notezin
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Produto"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Produtos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="mb-0">Consulta de Produtos - Por Nome</h2>
        </div>
        <div class="card-body">
            <%            
            ProdutoDAO prodDAO = new ProdutoDAO();
            List<Produto> lst = new ArrayList<>();         
            String nome = request.getParameter("nome");
            lst = prodDAO.consulta_nome(nome);
            if (lst != null && !lst.isEmpty()) {
            %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Identificador</th>
                            <th>Código Produto</th>
                            <th>Nome Produto</th>
                            <th>Marca</th>
                            <th>Tipo Produto</th>
                            <th>Preço Venda</th>
                            <th>Situação</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    int n_reg = 0;
                    for (Produto produto : lst) { 
                    n_reg++;
                    %>
                        <tr>
                            <td><%= produto.getIdProduto() %></td>
                            <td><%= produto.getCodigoProduto() %></td>
                            <td><%= produto.getNomeProduto() %></td>
                            <td><%= produto.getMarca() %></td>
                            <td><%= produto.getTipoProduto() %></td>
                            <td>R$ <%= String.format("%.2f", produto.getPrecoVenda()) %></td>
                            <td><%= produto.getSituacao() %></td>
                        </tr>
                    <% } %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="7" class="text-end">
                                Total de registros: <%= n_reg %>
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <% } else { %>
            <div class="alert alert-warning" role="alert">
                Nenhum produto encontrado para o nome: <%= nome %>
            </div>
            <% } %>
        </div>
    </div>
</div>
<!-- Bootstrap JS (opcional, mas recomendado) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
