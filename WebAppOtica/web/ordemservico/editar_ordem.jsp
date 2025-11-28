<%-- 
    Document   : editar_ordem
    Created on : Editar Ordem de Serviço
    Author     : WebAppOtica
--%>

<%@page import="model.OrdemServico"%>
<%@page import="model.DAO.OrdemServicoDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Ordem de Serviço</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-warning text-dark">
            <h2><i class="bi bi-pencil-square"></i> Editar Ordem de Serviço</h2>
        </div>
        <div class="card-body">
            <%
            String idParam = request.getParameter("id");
            OrdemServicoDAO ordemDAO = new OrdemServicoDAO();
            OrdemServico ordem = null;
            String mensagem = "";
            boolean sucesso = false;
            
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int idOrdem = Integer.parseInt(idParam);
                    ordem = ordemDAO.consultaPorId(idOrdem);
                    
                    // Processar atualização
                    if (request.getParameter("statusOrdem") != null) {
                        try {
                            ordem.setStatusOrdem(request.getParameter("statusOrdem"));
                            ordem.setDescricaoProblem(request.getParameter("descricaoProblema"));
                            ordem.setSolucaoTecnica(request.getParameter("solucaoTecnica"));
                            ordem.setGarantia(request.getParameter("garantia"));
                            
                            if (ordemDAO.alterar(ordem)) {
                                sucesso = true;
                                mensagem = "Ordem de serviço atualizada com sucesso!";
                            } else {
                                mensagem = "Erro ao atualizar a ordem de serviço!";
                            }
                        } catch (Exception e) {
                            mensagem = "Erro ao processar: " + e.getMessage();
                        }
                    }
                } catch (NumberFormatException e) {
                    mensagem = "ID inválido!";
                } catch (Exception e) {
                    mensagem = "Erro ao carregar: " + e.getMessage();
                }
            } else {
                mensagem = "ID não informado!";
            }
            
            if (!mensagem.isEmpty()) {
            %>
                <div class="alert <%= sucesso ? "alert-success" : "alert-danger" %>" role="alert">
                    <%= mensagem %>
                </div>
            <%
            }
            
            if (ordem != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            %>
            
            <form method="POST" action="editar_ordem.jsp?id=<%= ordem.getIdOrdem() %>">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">ID da Ordem</label>
                        <input type="text" class="form-control" value="#<%= ordem.getIdOrdem() %>" disabled>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Data de Abertura</label>
                        <input type="text" class="form-control" value="<%= sdf.format(ordem.getDataAbertura()) %>" disabled>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Cliente</label>
                        <input type="text" class="form-control" value="<%= ordem.getCliente().getNomeCompleto() %>" disabled>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Técnico Responsável</label>
                        <input type="text" class="form-control" value="<%= ordem.getFuncionario().getNomeCompleto() %>" disabled>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="statusOrdem" class="form-label">Status <span class="text-danger">*</span></label>
                    <select class="form-select" id="statusOrdem" name="statusOrdem" required>
                        <option value="Aberta" <%= "Aberta".equals(ordem.getStatusOrdem()) ? "selected" : "" %>>Aberta</option>
                        <option value="Em Andamento" <%= "Em Andamento".equals(ordem.getStatusOrdem()) ? "selected" : "" %>>Em Andamento</option>
                        <option value="Concluída" <%= "Concluída".equals(ordem.getStatusOrdem()) ? "selected" : "" %>>Concluída</option>
                        <option value="Cancelada" <%= "Cancelada".equals(ordem.getStatusOrdem()) ? "selected" : "" %>>Cancelada</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="descricaoProblema" class="form-label">Descrição do Problema <span class="text-danger">*</span></label>
                    <textarea class="form-control" id="descricaoProblema" name="descricaoProblema" rows="3" required><%= ordem.getDescricaoProblem() %></textarea>
                </div>

                <div class="mb-3">
                    <label for="solucaoTecnica" class="form-label">Solução Técnica</label>
                    <textarea class="form-control" id="solucaoTecnica" name="solucaoTecnica" rows="3"><%= ordem.getSolucaoTecnica() != null ? ordem.getSolucaoTecnica() : "" %></textarea>
                </div>

                <div class="mb-3">
                    <label for="garantia" class="form-label">Garantia</label>
                    <input type="text" class="form-control" id="garantia" name="garantia" value="<%= ordem.getGarantia() != null ? ordem.getGarantia() : "" %>">
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Valor Total</label>
                        <input type="text" class="form-control" value="R$ <%= String.format("%.2f", ordem.getValorTotal()) %>" disabled>
                    </div>
                    <% if (ordem.getDataFechamento() != null) { %>
                    <div class="col-md-6">
                        <label class="form-label">Data de Fechamento</label>
                        <input type="text" class="form-control" value="<%= sdf.format(ordem.getDataFechamento()) %>" disabled>
                    </div>
                    <% } %>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-circle"></i> Salvar Alterações
                    </button>
                    <a href="detalhe_ordem.jsp?id=<%= ordem.getIdOrdem() %>" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Voltar
                    </a>
                </div>
            </form>
            
            <%
            } else {
            %>
                <div class="alert alert-danger">Ordem de serviço não encontrada!</div>
                <a href="consulta_ordem.jsp" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Voltar
                </a>
            <%
            }
            %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
