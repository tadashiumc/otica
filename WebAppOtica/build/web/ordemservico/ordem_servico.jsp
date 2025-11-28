<%-- 
    Document   : ordem_servico
    Created on : Ordem de Serviço
    Author     : WebAppOtica
--%>

<%@page import="model.OrdemServico"%>
<%@page import="model.ItemOrdemServico"%>
<%@page import="model.Produto"%>
<%@page import="model.Cliente"%>
<%@page import="model.Funcionario"%>
<%@page import="model.DAO.OrdemServicoDAO"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page import="model.DAO.ProdutoDAO"%>
<%@page import="java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Abrir Ordem de Serviço</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
    <style>
        .item-row {
            background-color: #f8f9fa;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 5px;
        }
        .btn-remove-item {
            color: #dc3545;
            cursor: pointer;
        }
        .alert-info {
            background-color: #e7f3ff;
            border: 1px solid #b3d9ff;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h2><i class="bi bi-ticket-detailed"></i> Abrir Ordem de Serviço</h2>
        </div>
        <div class="card-body">
            <%
            OrdemServico ordem = new OrdemServico();
            boolean sucessoCadastro = false;
            String mensagemErro = "";
            
            if (request.getParameter("idCliente") != null) {
                try {
                    // Recuperar dados do formulário
                    int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                    int idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
                    String statusOrdem = request.getParameter("statusOrdem");
                    String descricaoProblema = request.getParameter("descricaoProblema");
                    String solucaoTecnica = request.getParameter("solucaoTecnica");
                    String garantia = request.getParameter("garantia");
                    
                    // Carregar cliente e funcionário
                    ClienteDAO clienteDAO = new ClienteDAO();
                    FuncionarioDAO funcDAO = new FuncionarioDAO();
                    
                    Cliente cliente = clienteDAO.consultaPorId(idCliente);
                    Funcionario funcionario = funcDAO.consultaPorId(idFuncionario);
                    
                    if (cliente == null || funcionario == null) {
                        mensagemErro = "Cliente ou Funcionário não encontrado!";
                    } else {
                        // Criar ordem de serviço
                        ordem.setCliente(cliente);
                        ordem.setFuncionario(funcionario);
                        ordem.setStatusOrdem(statusOrdem);
                        ordem.setDescricaoProblem(descricaoProblema);
                        ordem.setSolucaoTecnica(solucaoTecnica);
                        ordem.setGarantia(garantia);
                        
                        // Processar itens da ordem
                        String[] idsProduto = request.getParameterValues("idProduto[]");
                        String[] quantidades = request.getParameterValues("quantidade[]");
                        
                        if (idsProduto != null && idsProduto.length > 0) {
                            ProdutoDAO prodDAO = new ProdutoDAO();
                            double valorTotal = 0;
                            
                            for (int i = 0; i < idsProduto.length; i++) {
                                if (idsProduto[i] != null && !idsProduto[i].isEmpty() &&
                                    quantidades[i] != null && !quantidades[i].isEmpty()) {
                                    
                                    int idProd = Integer.parseInt(idsProduto[i]);
                                    int qtd = Integer.parseInt(quantidades[i]);
                                    
                                    Produto produto = prodDAO.consultaPorId(idProd);
                                    if (produto != null && qtd > 0) {
                                        ItemOrdemServico item = new ItemOrdemServico();
                                        item.setProduto(produto);
                                        item.setQuantidade(qtd);
                                        item.setValorUnitario(produto.getPrecoVenda());
                                        item.setValorTotal(qtd * produto.getPrecoVenda());
                                        
                                        ordem.adicionarItem(item);
                                        valorTotal += item.getValorTotal();
                                    }
                                }
                            }
                            
                            ordem.setValorTotal(valorTotal);
                        }
                        
                        // Cadastrar ordem
                        OrdemServicoDAO ordemDAO = new OrdemServicoDAO();
                        if (ordemDAO.cadastrar(ordem)) {
                            sucessoCadastro = true;
                        } else {
                            mensagemErro = "Erro ao cadastrar a ordem de serviço!";
                        }
                    }
                    
                } catch (NumberFormatException e) {
                    mensagemErro = "Dados inválidos: " + e.getMessage();
                } catch (Exception e) {
                    mensagemErro = "Erro no processamento: " + e.getMessage();
                }
            }
            
            if (sucessoCadastro) {
            %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    <strong>Sucesso!</strong> Ordem de Serviço #<%= ordem.getIdOrdem() %> aberta com sucesso!
                </div>
                <div class="alert alert-info">
                    <p><strong>Cliente:</strong> <%= ordem.getCliente().getNomeCompleto() %></p>
                    <p><strong>Técnico:</strong> <%= ordem.getFuncionario().getNomeCompleto() %></p>
                    <p><strong>Valor Total:</strong> R$ <%= String.format("%.2f", ordem.getValorTotal()) %></p>
                    <p><strong>Data de Abertura:</strong> <%= new SimpleDateFormat("dd/MM/yyyy HH:mm").format(ordem.getDataAbertura()) %></p>
                </div>
            <% } else if (!mensagemErro.isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <%= mensagemErro %>
                </div>
            <% } %>

            <form method="POST" action="ordem_servico.jsp" id="formOrdem">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="idCliente" class="form-label">Cliente <span class="text-danger">*</span></label>
                        <select class="form-select" id="idCliente" name="idCliente" required>
                            <option value="">Selecione um cliente...</option>
                            <%
                            try {
                                ClienteDAO clienteDAO = new ClienteDAO();
                                java.util.List<Cliente> clientes = clienteDAO.consulta_geral();
                                if (clientes != null) {
                                    for (Cliente cli : clientes) {
                            %>
                                <option value="<%= cli.getIdCliente() %>"><%= cli.getNomeCompleto() %></option>
                            <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="idFuncionario" class="form-label">Técnico Responsável <span class="text-danger">*</span></label>
                        <select class="form-select" id="idFuncionario" name="idFuncionario" required>
                            <option value="">Selecione um técnico...</option>
                            <%
                            try {
                                FuncionarioDAO funcDAO = new FuncionarioDAO();
                                java.util.List<Funcionario> funcionarios = funcDAO.consulta_geral();
                                if (funcionarios != null) {
                                    for (Funcionario func : funcionarios) {
                            %>
                                <option value="<%= func.getIdFuncionario() %>"><%= func.getNomeCompleto() %></option>
                            <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            %>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="statusOrdem" class="form-label">Status <span class="text-danger">*</span></label>
                        <select class="form-select" id="statusOrdem" name="statusOrdem" required>
                            <option value="Aberta">Aberta</option>
                            <option value="Em Andamento">Em Andamento</option>
                            <option value="Concluída">Concluída</option>
                            <option value="Cancelada">Cancelada</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="garantia" class="form-label">Garantia</label>
                        <input type="text" class="form-control" id="garantia" name="garantia" placeholder="Ex: 12 meses">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="descricaoProblema" class="form-label">Descrição do Problema <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="descricaoProblema" name="descricaoProblema" rows="3" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="solucaoTecnica" class="form-label">Solução Técnica</label>
                    <textarea class="form-control" id="solucaoTecnica" name="solucaoTecnica" rows="3"></textarea>
                </div>

                <hr>
                <h5>Produtos/Serviços</h5>
                
                <div id="containerItens">
                    <div class="item-row" id="item-0">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label">Produto</label>
                                <select class="form-select" name="idProduto[]">
                                    <option value="">Selecione um produto...</option>
                                    <%
                                    try {
                                        ProdutoDAO prodDAO = new ProdutoDAO();
                                        java.util.List<Produto> produtos = prodDAO.consulta_geral();
                                        if (produtos != null) {
                                            for (Produto prod : produtos) {
                                    %>
                                        <option value="<%= prod.getIdProduto() %>"><%= prod.getNomeProduto() %> - R$ <%= String.format("%.2f", prod.getPrecoVenda()) %></option>
                                    <%
                                            }
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Quantidade</label>
                                <input type="number" class="form-control" name="quantidade[]" min="0" value="1">
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="button" class="btn btn-sm btn-danger w-100" onclick="removerItem(0)">
                                    <i class="bi bi-trash"></i> Remover
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <button type="button" class="btn btn-secondary btn-sm mb-3" onclick="adicionarItem()">
                    <i class="bi bi-plus"></i> Adicionar Item
                </button>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Abrir Ordem de Serviço
                    </button>
                    <a href="../index.jsp" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Voltar
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.4.0/js/all.min.js"></script>

<script>
    let contador = 1;

    function adicionarItem() {
        const container = document.getElementById('containerItens');
        const novoItem = document.createElement('div');
        novoItem.className = 'item-row';
        novoItem.id = 'item-' + contador;
        
        novoItem.innerHTML = `
            <div class="row">
                <div class="col-md-6">
                    <label class="form-label">Produto</label>
                    <select class="form-select" name="idProduto[]">
                        <option value="">Selecione um produto...</option>
                        <% 
                        try {
                            ProdutoDAO prodDAO = new ProdutoDAO();
                            java.util.List<Produto> produtos = prodDAO.consulta_geral();
                            if (produtos != null) {
                                for (Produto prod : produtos) {
                        %>
                            <option value="<%= prod.getIdProduto() %>"><%= prod.getNomeProduto() %> - R$ <%= String.format("%.2f", prod.getPrecoVenda()) %></option>
                        <%
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Quantidade</label>
                    <input type="number" class="form-control" name="quantidade[]" min="0" value="1">
                </div>
                <div class="col-md-3 d-flex align-items-end">
                    <button type="button" class="btn btn-sm btn-danger w-100" onclick="removerItem(` + contador + `)">
                        <i class="bi bi-trash"></i> Remover
                    </button>
                </div>
            </div>
        `;
        
        container.appendChild(novoItem);
        contador++;
    }

    function removerItem(index) {
        const elemento = document.getElementById('item-' + index);
        if (elemento) {
            elemento.remove();
        }
    }
</script>
</body>
</html>
