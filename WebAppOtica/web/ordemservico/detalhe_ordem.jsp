<%-- 
    Document   : detalhe_ordem
    Created on : Detalhe de Ordem de Serviço
    Author     : WebAppOtica
--%>

<%@page import="model.OrdemServico"%>
<%@page import="model.ItemOrdemServico"%>
<%@page import="model.DAO.OrdemServicoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Detalhe da Ordem de Serviço</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
    <style>
        .detail-section {
            background-color: #f8f9fa;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
            border-left: 4px solid #0d6efd;
        }
        .badge-aberta { background-color: #0dcaf0; }
        .badge-andamento { background-color: #0d6efd; }
        .badge-concluida { background-color: #198754; }
        .badge-cancelada { background-color: #dc3545; }
    </style>
</head>
<body>
<div class="container mt-5 mb-5">
    <div class="card">
        <div class="card-header bg-primary text-white">
            <h2><i class="bi bi-ticket-detailed"></i> Detalhe da Ordem de Serviço</h2>
        </div>
        <div class="card-body">
            <%
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
            %>
                <div class="alert alert-danger">ID inválido!</div>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">Voltar</a>
            <%
            } else {
                try {
                    int idOrdem = Integer.parseInt(idParam);
                    OrdemServicoDAO ordemDAO = new OrdemServicoDAO();
                    OrdemServico ordem = ordemDAO.consultaPorId(idOrdem);
                    
                    if (ordem == null) {
            %>
                <div class="alert alert-warning">Ordem de serviço não encontrada!</div>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">Voltar</a>
            <%
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                        String badgeClass = "badge-aberta";
                        switch(ordem.getStatusOrdem()) {
                            case "Em Andamento": badgeClass = "badge-andamento"; break;
                            case "Concluída": badgeClass = "badge-concluida"; break;
                            case "Cancelada": badgeClass = "badge-cancelada"; break;
                        }
            %>
            
            <div class="row mb-4">
                <div class="col-md-6">
                    <h5>ID da Ordem: <strong>#<%= ordem.getIdOrdem() %></strong></h5>
                    <p class="mb-0">Status: <span class="badge <%= badgeClass %>"><%= ordem.getStatusOrdem() %></span></p>
                </div>
                <div class="col-md-6 text-end">
                    <p><strong>Data de Abertura:</strong> <%= sdf.format(ordem.getDataAbertura()) %></p>
                    <% if (ordem.getDataFechamento() != null) { %>
                        <p><strong>Data de Fechamento:</strong> <%= sdf.format(ordem.getDataFechamento()) %></p>
                    <% } %>
                </div>
            </div>

            <div class="detail-section">
                <h5><i class="bi bi-person"></i> Informações do Cliente</h5>
                <p><strong>Nome:</strong> <%= ordem.getCliente().getNomeCompleto() %></p>
                <p><strong>CPF:</strong> <%= ordem.getCliente().getCpf() %></p>
                <p><strong>Telefone:</strong> <%= ordem.getCliente().getTelefone() %></p>
                <p><strong>Email:</strong> <%= ordem.getCliente().getEmail() %></p>
                <p><strong>Endereço:</strong> <%= ordem.getCliente().getEndereco() %> - <%= ordem.getCliente().getCidade() %>, <%= ordem.getCliente().getEstado() %></p>
            </div>

            <div class="detail-section">
                <h5><i class="bi bi-person-badge"></i> Técnico Responsável</h5>
                <p><strong>Nome:</strong> <%= ordem.getFuncionario().getNomeCompleto() %></p>
                <p><strong>Cargo:</strong> <%= ordem.getFuncionario().getCargo() %></p>
                <p><strong>Telefone:</strong> <%= ordem.getFuncionario().getTelefone() %></p>
                <p><strong>Email:</strong> <%= ordem.getFuncionario().getEmail() %></p>
            </div>

            <div class="detail-section">
                <h5><i class="bi bi-tools"></i> Descrição do Problema</h5>
                <p><%= ordem.getDescricaoProblem() %></p>
            </div>

            <% if (ordem.getSolucaoTecnica() != null && !ordem.getSolucaoTecnica().isEmpty()) { %>
            <div class="detail-section">
                <h5><i class="bi bi-check-circle"></i> Solução Técnica</h5>
                <p><%= ordem.getSolucaoTecnica() %></p>
            </div>
            <% } %>

            <div class="detail-section">
                <h5><i class="bi bi-box"></i> Itens da Ordem de Serviço</h5>
                <div class="table-responsive">
                    <table class="table table-sm">
                        <thead class="table-light">
                            <tr>
                                <th>Produto</th>
                                <th>Quantidade</th>
                                <th>Valor Unitário</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            if (ordem.getItens() != null && !ordem.getItens().isEmpty()) {
                                for (ItemOrdemServico item : ordem.getItens()) {
                            %>
                            <tr>
                                <td><%= item.getProduto().getNomeProduto() %></td>
                                <td><%= item.getQuantidade() %></td>
                                <td>R$ <%= String.format("%.2f", item.getValorUnitario()) %></td>
                                <td>R$ <%= String.format("%.2f", item.getValorTotal()) %></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="4" class="text-center text-muted">Nenhum item na ordem.</td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="detail-section">
                <div class="row">
                    <div class="col-md-6">
                        <h5><i class="bi bi-shield-check"></i> Garantia</h5>
                        <p><%= ordem.getGarantia() != null ? ordem.getGarantia() : "Não informado" %></p>
                    </div>
                    <div class="col-md-6 text-end">
                        <h5>Valor Total</h5>
                        <h3 class="text-success">R$ <%= String.format("%.2f", ordem.getValorTotal()) %></h3>
                    </div>
                </div>
            </div>

            <div class="text-center mt-4">
                <a href="editar_ordem.jsp?id=<%= ordem.getIdOrdem() %>" class="btn btn-warning">
                    <i class="bi bi-pencil"></i> Editar
                </a>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Voltar
                </a>
            </div>

            <%
                    }
                } catch (NumberFormatException e) {
            %>
                <div class="alert alert-danger">ID inválido: <%= e.getMessage() %></div>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">Voltar</a>
            <%
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <div class="alert alert-danger">Erro ao carregar dados: <%= e.getMessage() %></div>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">Voltar</a>
            <%
                }
            }
            %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
