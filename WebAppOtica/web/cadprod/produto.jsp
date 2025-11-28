<%-- 
    Document   : cliente
    Created on : 27 de nov. de 2025, 14:24:01
    Author     : Notezin
--%>

<%@page import="model.Produto"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page import="java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Produtos</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>Controle de Produtos</h2>
    <%
    //Instância do objeto
    Produto prod = new Produto();
    if (request.getParameter("nomeProduto") != null) {
        try {
            // Não defina o ID - deixe o banco gerar
            prod.setCodigoProduto(request.getParameter("codigoProduto"));
            prod.setNomeProduto(request.getParameter("nomeProduto"));
            prod.setMarca(request.getParameter("marca"));
            prod.setTipoProduto(request.getParameter("tipoProduto"));
            prod.setPrecoCusto(Double.parseDouble(request.getParameter("precoCusto")));
            prod.setPrecoVenda(Double.parseDouble(request.getParameter("precoVenda")));
            prod.setQuantidadeEstoque(Integer.parseInt(request.getParameter("quantidadeEstoque")));
            prod.setDataCadastro(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataCadastro")));
            prod.setSituacao(request.getParameter("situacao"));

            //Saída dos dados
            out.println("Código do Produto: " + prod.getCodigoProduto());
            out.println("<br>Nome do Produto: " + prod.getNomeProduto());
            out.println("<br>Marca: " + prod.getMarca());
            out.println("<br>Tipo do Produto: " + prod.getTipoProduto());
            out.println("<br>Preço de Custo: R$ " + prod.getPrecoCusto());
            out.println("<br>Preço de Venda: R$ " + prod.getPrecoVenda());
            out.println("<br>Quantidade em Estoque: " + prod.getQuantidadeEstoque());
            out.println("<br>Data de Cadastro: " + prod.getDataCadastro());
            out.println("<br>Situação: " + prod.getSituacao());

            //Salvar
            ProdutoDAO prodDAO = new ProdutoDAO();
            if (prodDAO.cadastrar(prod)) {
                out.println("<br><strong style='color: green;'> Produto inserido com sucesso!!!</strong>");
            } else {
                out.println("<br><strong style='color: red;'> Erro ao cadastrar produto!</strong>");
            }
        } catch (Exception e) {
            out.println("<br><strong style='color: red;'>Erro: " + e.getMessage() + "</strong>");
            e.printStackTrace();
        }
    } else {
        out.println("<strong style='color: red;'>Por favor, preencha todos os campos!</strong>");
    }
    %>
    <p> <button onclick="document.location='../'" class="voltar-btn">Voltar</button> </p>
</div>
</body>
</html>