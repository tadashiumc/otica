<%-- 
    Document   : checkout
    Created on : 28 de nov. de 2025, 00:14:02
    Author     : Deskzito
--%>

<%@page import="model.DAO.ClienteDAO"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page import="model.Cliente"%>
<%@page import="model.Funcionario"%>
<%@page import="model.Produto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout de Venda</title>
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
                <i class="fas fa-shopping-cart me-2"></i>Checkout de Venda
            </h2>
        </div>
        <div class="card-body">
            <form id="vendaForm" method="post" action="processarVenda.jsp">
                <div class="row">
                    <!-- Seleção de Cliente -->
                    <div class="col-md-6 mb-3">
                        <label for="cliente" class="form-label">Cliente:</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="nomeCliente" placeholder="Digite o nome do cliente">
                            <button class="btn btn-secondary" type="button" onclick="buscarClientes()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <select class="form-select mt-2" id="cliente" name="idCliente">
                            <option value="">Selecione um cliente</option>
                        </select>
                    </div>

                    <!-- Seleção de Funcionário -->
                    <div class="col-md-6 mb-3">
                        <label for="funcionario" class="form-label">Funcionário:</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="nomeFuncionario" placeholder="Digite o nome do funcionário">
                            <button class="btn btn-secondary" type="button" onclick="buscarFuncionarios()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <select class="form-select mt-2" id="funcionario" name="idFuncionario">
                            <option value="">Selecione um funcionário</option>
                        </select>
                    </div>

                    <!-- Adicionar Produto -->
                    <div class="col-md-12 mb-3">
                        <label for="produto" class="form-label">Produto:</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="nomeProduto" placeholder="Digite o nome do produto">
                            <button class="btn btn-secondary" type="button" onclick="buscarProdutos()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                        <select class="form-select mt-2" id="produto">
                            <option value="">Selecione um produto</option>
                        </select>
                        <div class="input-group mt-2">
                            <input type="number" class="form-control" id="quantidade" placeholder="Quantidade" min="1">
                            <button class="btn btn-primary" type="button" onclick="adicionarProduto()">
                                <i class="fas fa-plus"></i> Adicionar
                            </button>
                        </div>
                    </div>

                    <!-- Tabela de Produtos -->
                    <div class="col-md-12">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Produto</th>
                                    <th>Quantidade</th>
                                    <th>Valor Unitário</th>
                                    <th>Total</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody id="tabelaProdutos">
                                <!-- Produtos adicionados serão inseridos aqui -->
                            </tbody>
                        </table>
                    </div>

                    <!-- Total da Venda -->
                    <div class="col-md-12 text-end">
                        <h4>Total da Venda: R$ <span id="totalVenda">0,00</span></h4>
                    </div>

                    <!-- Detalhes da Venda -->
                    <div class="col-md-6">
                        <label for="formaPagamento" class="form-label">Forma de Pagamento:</label>
                        <select class="form-select" id="formaPagamento" name="formaPagamento">
                            <option value="Dinheiro">Dinheiro</option>
                            <option value="Cartão de Crédito">Cartão de Crédito</option>
                            <option value="Cartão de Débito">Cartão de Débito</option>
                            <option value="PIX">PIX</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="numeroParcelas" class="form-label">Número de Parcelas:</label>
                        <input type="number" class="form-control" id="numeroParcelas" name="numeroParcelas" min="1" max="12" value="1">
                    </div>

                    <!-- Botões de Ação -->
                    <div class="col-12 mt-3 text-center">
                        <button type="button" class="btn btn-success" onclick="finalizarVenda()">
                            <i class="fas fa-check-circle me-2"></i>Finalizar Venda
                        </button>
                        <button type="button" class="btn btn-danger ms-2" onclick="limparCarrinho()">
                            <i class="fas fa-trash-alt me-2"></i>Limpar Carrinho
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS e jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let produtosCarrinho = [];

    function buscarClientes() {
        const nome = document.getElementById('nomeCliente').value;
        $.ajax({
            url: 'buscarClientes.jsp',
            method: 'POST',
            data: { nome: nome },
            success: function(response) {
                $('#cliente').html(response);
            }
        });
    }

    function buscarFuncionarios() {
        const nome = document.getElementById('nomeFuncionario').value;
        $.ajax({
            url: 'buscarFuncionarios.jsp',
            method: 'POST',
            data: { nome: nome },
            success: function(response) {
                $('#funcionario').html(response);
            }
        });
    }

    function buscarProdutos() {
        const nome = document.getElementById('nomeProduto').value;
        $.ajax({
            url: 'buscarProdutos.jsp',
            method: 'POST',
            data: { nome: nome },
            success: function(response) {
                $('#produto').html(response);
            }
        });
    }

    function adicionarProduto() {
        const selectProduto = document.getElementById('produto');
        const quantidade = document.getElementById('quantidade').value;
        
        if (selectProduto.value && quantidade > 0) {
            const produto = selectProduto.options[selectProduto.selectedIndex];
            const produtoObj = {
                id: produto.value,
                nome: produto.text,
                valorUnitario: parseFloat(produto.getAttribute('data-preco')),
                quantidade: parseInt(quantidade)
            };

            produtosCarrinho.push(produtoObj);
            atualizarTabelaProdutos();
            limparSelecaoProduto();
        }
    }

    function atualizarTabelaProdutos() {
        const tabela = document.getElementById('tabelaProdutos');
        tabela.innerHTML = '';
        let total = 0;

        produtosCarrinho.forEach((produto, index) => {
            const valorTotal = produto.valorUnitario * produto.quantidade;
            total += valorTotal;

            const linha = `
                <tr>
                    <td>${produto.nome}</td>
                    <td>${produto.quantidade}</td>
                    <td>R$ ${produto.valorUnitario.toFixed(2)}</td>
                    <td>R$ ${valorTotal.toFixed(2)}</td>
                    <td>
                        <button class="btn btn-sm btn-danger" onclick="removerProduto(${index})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
            tabela.innerHTML += linha;
        });

        document.getElementById('totalVenda').textContent = total.toFixed(2);
    }

    function removerProduto(index) {
        produtosCarrinho.splice(index, 1);
        atualizarTabelaProdutos();
    }

    function limparSelecaoProduto() {
        document.getElementById('produto').selectedIndex = 0;
        document.getElementById('quantidade').value = '';
    }

    function finalizarVenda() {
        // Implementar lógica de envio do formulário
        if (produtosCarrinho.length > 0) {
            // Adicionar produtos ao formulário
            produtosCarrinho.forEach((produto, index) => {
                const hiddenProduto = document.createElement('input');
                hiddenProduto.type = 'hidden';
                hiddenProduto.name = `produtos[${index}].id`;
                hiddenProduto.value = produto.id;
                document.getElementById('vendaForm').appendChild(hiddenProduto);

                const hiddenQuantidade = document.createElement('input');
                hiddenQuantidade.type = 'hidden';
                hiddenQuantidade.name = `produtos[${index}].quantidade`;
                hiddenQuantidade.value = produto.quantidade;
                document.getElementById('vendaForm').appendChild(hiddenQuantidade);
            });

            document.getElementById('vendaForm').submit();
        } else {
            alert('Adicione pelo menos um produto ao carrinho');
        }
    }

    function limparCarrinho() {
        produtosCarrinho = [];
        atualizarTabelaProdutos();
    }
</script>
</body>
</html>
