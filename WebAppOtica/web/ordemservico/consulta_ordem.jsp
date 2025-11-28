<%-- 
    Document   : consulta_ordem
    Created on : Consulta de Ordens de Serviço
    Author     : WebAppOtica
--%>

<%@page import="model.OrdemServico"%>
<%@page import="model.DAO.OrdemServicoDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Consulta de Ordens de Serviço</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
    <style>
        .badge-aberta { background-color: #0dcaf0; }
        .badge-andamento { background-color: #0d6efd; }
        .badge-concluida { background-color: #198754; }
        .badge-cancelada { background-color: #dc3545; }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-info text-white">
            <h2><i class="bi bi-list-ul"></i> Consulta de Ordens de Serviço</h2>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-4">
                    <form method="GET" action="consulta_ordem.jsp" class="input-group">
                        <input type="text" class="form-control" name="busca" placeholder="Buscar por cliente..." value="<%= request.getParameter("busca") != null ? request.getParameter("busca") : "" %>">
                        <button class="btn btn-primary" type="submit">
                            <i class="bi bi-search"></i> Buscar
                        </button>
                    </form>
                </div>
                <div class="col-md-4">
                    <form method="GET" action="consulta_ordem.jsp" class="input-group">
                        <select class="form-select" name="status">
                            <option value="">Todos os Status</option>
                            <option value="Aberta" <%= "Aberta".equals(request.getParameter("status")) ? "selected" : "" %>>Aberta</option>
                            <option value="Em Andamento" <%= "Em Andamento".equals(request.getParameter("status")) ? "selected" : "" %>>Em Andamento</option>
                            <option value="Concluída" <%= "Concluída".equals(request.getParameter("status")) ? "selected" : "" %>>Concluída</option>
                            <option value="Cancelada" <%= "Cancelada".equals(request.getParameter("status")) ? "selected" : "" %>>Cancelada</option>
                        </select>
                        <button class="btn btn-primary" type="submit">
                            <i class="bi bi-filter"></i> Filtrar
                        </button>
                    </form>
                </div>
                <div class="col-md-4 text-end">
                    <a href="ordem_servico.jsp" class="btn btn-success">
                        <i class="bi bi-plus-circle"></i> Nova Ordem
                    </a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-striped">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Técnico</th>
                            <th>Data de Abertura</th>
                            <th>Status</th>
                            <th>Valor</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        try {
                            OrdemServicoDAO ordemDAO = new OrdemServicoDAO();
                            List<OrdemServico> ordens = null;
                            String statusFiltro = request.getParameter("status");
                            
                            if (statusFiltro != null && !statusFiltro.isEmpty()) {
                                ordens = ordemDAO.consultaPorStatus(statusFiltro);
                            } else {
                                ordens = ordemDAO.consulta_geral();
                            }
                            
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            
                            if (ordens != null && !ordens.isEmpty()) {
                                for (OrdemServico ordem : ordens) {
                                    String badgeClass = "badge-aberta";
                                    switch(ordem.getStatusOrdem()) {
                                        case "Em Andamento": badgeClass = "badge-andamento"; break;
                                        case "Concluída": badgeClass = "badge-concluida"; break;
                                        case "Cancelada": badgeClass = "badge-cancelada"; break;
                                    }
                        %>
                        <tr>
                            <td><strong>#<%= ordem.getIdOrdem() %></strong></td>
                            <td><%= ordem.getCliente().getNomeCompleto() %></td>
                            <td><%= ordem.getFuncionario().getNomeCompleto() %></td>
                            <td><%= sdf.format(ordem.getDataAbertura()) %></td>
                            <td><span class="badge <%= badgeClass %>"><%= ordem.getStatusOrdem() %></span></td>
                            <td>R$ <%= String.format("%.2f", ordem.getValorTotal()) %></td>
                            <td>
                                <a href="detalhe_ordem.jsp?id=<%= ordem.getIdOrdem() %>" class="btn btn-sm btn-info">
                                    <i class="bi bi-eye"></i> Ver
                                </a>
                                <a href="editar_ordem.jsp?id=<%= ordem.getIdOrdem() %>" class="btn btn-sm btn-warning">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a href="excluir_ordem.jsp?id=<%= ordem.getIdOrdem() %>" class="btn btn-sm btn-danger" onclick="return confirm('Tem certeza?')">
                                    <i class="bi bi-trash"></i> Excluir
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-muted">Nenhuma ordem de serviço encontrada.</td>
                        </tr>
                        <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        %>
                        <tr>
                            <td colspan="7" class="text-center text-danger">Erro ao carregar dados.</td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-3">
                <a href="../home.jsp" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Voltar ao Menu
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
