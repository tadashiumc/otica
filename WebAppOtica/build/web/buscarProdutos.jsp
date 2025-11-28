<%-- 
    Document   : buscarProdutos
    Created on : 28 de nov. de 2025, 00:20:45
    Author     : Deskzito
--%>

<%@page import="model.DAO.ProdutoDAO"%>
<%@page import="model.Produto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nome = request.getParameter("nome");
    ProdutoDAO produtoDAO = new ProdutoDAO();
    List<Produto> produtos = null;
    
    if (nome != null && !nome.trim().isEmpty()) {
        produtos = produtoDAO.consultaPorNome(nome);
    }
    
    if (produtos != null && !produtos.isEmpty()) {
        for (Produto produto : produtos) {
%>
            <option 
                value="<%= produto.getIdProduto() %>" 
                data-preco="<%= produto.getPrecoVenda() %>"
            >
                <%= produto.getNomeProduto() %> - R$ <%= String.format("%.2f", produto.getPrecoVenda()) %> 
                (Estoque: <%= produto.getQuantidadeEstoque() %>)
            </option>
<%
        }
    } else {
%>
        <option value="">Nenhum produto encontrado</option>
<%
    }
%>
