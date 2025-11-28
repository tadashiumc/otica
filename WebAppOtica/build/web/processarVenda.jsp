<%-- 
    Document   : processarVenda
    Created on : 28 de nov. de 2025, 00:22:21
    Author     : Deskzito
--%>

<%@page import="model.Venda"%>
<%@page import="model.ItemVenda"%>
<%@page import="model.DAO.VendaDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado da Venda</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-success text-white">
            <h2>Resultado da Venda</h2>
        </div>
        <div class="card-body">
            <%
            try {
                // Recuperar parâmetros do formulário
                String idClienteParam = request.getParameter("idCliente");
                String idFuncionarioParam = request.getParameter("idFuncionario");
                String formaPagamento = request.getParameter("formaPagamento");
                String numeroParcelasParam = request.getParameter("numeroParcelas");

                // Criar objeto de venda
                Venda venda = new Venda();
                
                // Configurar cliente (opcional)
                if (idClienteParam != null && !idClienteParam.isEmpty()) {
                    venda.setIdCliente(Integer.parseInt(idClienteParam));
                }
                
                // Configurar funcionário (opcional)
                if (idFuncionarioParam != null && !idFuncionarioParam.isEmpty()) {
                    venda.setIdFuncionario(Integer.parseInt(idFuncionarioParam));
                }

                // Configurar data atual
                venda.setDataVenda(new Date());
                
                // Configurar forma de pagamento e parcelas
                venda.setFormaPagamento(formaPagamento);
                venda.setNumeroParcelas(Integer.parseInt(numeroParcelasParam));
                
                // Configurar status e outras informações
                venda.setStatusVenda("Finalizada");
                venda.setObservacoes("Venda realizada pelo sistema");

                // Lista para armazenar itens da venda
                List<ItemVenda> itens = new ArrayList<>();

                // Recuperar produtos do formulário
                String[] produtosIds = request.getParameterValues("produtos[].id");
                String[] produtosQuantidades = request.getParameterValues("produtos[].quantidade");

                // Variável para calcular valor total
                double valorTotal = 0;

                // Processar itens da venda
                if (produtosIds != null && produtosQuantidades != null) {
                    for (int i = 0; i < produtosIds.length; i++) {
                        ItemVenda item = new ItemVenda();
                        int idProduto = Integer.parseInt(produtosIds[i]);
                        int quantidade = Integer.parseInt(produtosQuantidades[i]);

                        // Consultar detalhes do produto (você pode otimizar isso)
                        item.setIdProduto(idProduto);
                        item.setQuantidade(quantidade);
                        
                        // Você pode adicionar método para buscar preço do produto
                        // Por enquanto, vamos usar um valor fixo para exemplo
                        double precoProduto = 10.0; // Substituir pela consulta real
                        item.setValorUnitario(precoProduto);
                        item.setValorTotal(precoProduto * quantidade);

                        valorTotal += item.getValorTotal();
                        itens.add(item);
                    }
                }

                // Definir valor total na venda
                venda.setValorTotal(valorTotal);

                // Processar venda
                VendaDAO vendaDAO = new VendaDAO();
                boolean vendaRealizada = vendaDAO.cadastrarVenda(venda, itens);

                if (vendaRealizada) {
            %>
                <div class="alert alert-success">
                    <h3>Venda realizada com sucesso!</h3>
                    <p>Valor total: R$ <%= String.format("%.2f", venda.getValorTotal()) %></p>
                    <p>Forma de pagamento: <%= venda.getFormaPagamento() %></p>
                    <p>Número de parcelas: <%= venda.getNumeroParcelas() %></p>
                </div>
                                    <div class="text-center">
                        <a href="home.jsp" class="btn btn-primary">Voltar ao Início</a>
                    </div>
            <% } else { %>
                <div class="alert alert-danger">
                    <h3>Erro ao realizar venda</h3>
                    <p>Não foi possível processar a venda. Tente novamente.</p>
                </div>
            <% } 
            } catch (Exception e) {
            %>
                <div class="alert alert-danger">
                    <h3>Erro no processamento</h3>
                    <p><%= e.getMessage() %></p>
                </div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>
