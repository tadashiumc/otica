<%-- 
    Document   : excluir_ordem
    Created on : Excluir Ordem de Serviço
    Author     : WebAppOtica
--%>

<%@page import="model.DAO.OrdemServicoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Excluir Ordem de Serviço</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-danger text-white">
            <h2><i class="bi bi-trash"></i> Excluir Ordem de Serviço</h2>
        </div>
        <div class="card-body">
            <%
            try {
                int idOrdem = Integer.parseInt(request.getParameter("id"));
                OrdemServicoDAO ordemDAO = new OrdemServicoDAO();
                
                if (ordemDAO.excluir(idOrdem)) {
            %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    Ordem de Serviço #<%= idOrdem %> excluída com sucesso!!!
                </div>
            <%
                } else {
            %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Ordem de Serviço não encontrada ou não pôde ser excluída!
                </div>
            <%
                }
            } catch (NumberFormatException e) {
            %>
                <div class="alert alert-warning" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ID inválido. Por favor, insira um número válido.
                </div>
            <%
            } catch (Exception e) {
            %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Erro ao processar: <%= e.getMessage() %>
                </div>
            <%
            }
            %>
            
            <div class="text-center mt-3">
                <a href="consulta_ordem.jsp" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-2"></i>Voltar ao Menu
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
