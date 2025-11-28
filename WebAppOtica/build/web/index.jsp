<%-- 
    Document   : index
    Created on : Sistema de Gestão
    Author     : Notezin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar se usuário está logado
    if (session.getAttribute("usuarioId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestão</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
        }
        
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        
        .navbar-brand {
            font-weight: 700;
            font-size: 20px;
        }
        
        .user-info {
            color: white;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .user-info .user-badge {
            background: rgba(255,255,255,0.2);
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .card-custom {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card-custom:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.12);
        }
        
        .container-menu {
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .user-info {
                gap: 8px;
            }
            
            .user-info .user-badge {
                font-size: 11px;
                padding: 3px 8px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar com informações do usuário -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-glasses"></i> WebApp Ótica
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <div class="user-info">
                            <span>
                                <i class="fas fa-user-circle"></i>
                                <%= session.getAttribute("usuarioNome") %>
                            </span>
                            <span class="user-badge"><%= session.getAttribute("usuarioPerfil") %></span>
                            <a href="logout.jsp" class="btn btn-sm btn-light">
                                <i class="fas fa-sign-out-alt"></i> Sair
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container container-menu">
        <div class="row text-center">
            <div class="col-12 mb-4">
                <h1 class="display-4">Sistema de Gestão</h1>
                <p class="lead text-muted">Bem-vindo, <strong><%= session.getAttribute("usuarioNome") %></strong>! Selecione uma opção para gerenciar</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <!-- Clientes -->
            <div class="col-md-3 mb-4">
                <div class="card card-custom shadow-sm text-center">
                    <div class="card-body">
                        <i class="fas fa-users fa-4x text-primary mb-3"></i>
                        <h5 class="card-title">Clientes</h5>
                        <p class="card-text text-muted">Gerencie o cadastro de clientes</p>
                        <a href="clientes.html" class="btn btn-primary w-100">
                            Acessar <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Funcionários -->
            <div class="col-md-3 mb-4">
                <div class="card card-custom shadow-sm text-center">
                    <div class="card-body">
                        <i class="fas fa-user-tie fa-4x text-success mb-3"></i>
                        <h5 class="card-title">Funcionários</h5>
                        <p class="card-text text-muted">Gerencie o cadastro de funcionários</p>
                        <a href="funcionarios.html" class="btn btn-success w-100">
                            Acessar <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Produtos -->
            <div class="col-md-3 mb-4">
                <div class="card card-custom shadow-sm text-center">
                    <div class="card-body">
                        <i class="fas fa-boxes fa-4x text-warning mb-3"></i>
                        <h5 class="card-title">Produtos</h5>
                        <p class="card-text text-muted">Gerencie o estoque de produtos</p>
                        <a href="produtos.html" class="btn btn-warning w-100">
                            Acessar <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Vendas -->
            <div class="col-md-3 mb-4">
                <div class="card card-custom shadow-sm text-center">
                    <div class="card-body">
                        <i class="fas fa-shopping-cart fa-4x text-danger mb-3"></i>
                        <h5 class="card-title">Vendas</h5>
                        <p class="card-text text-muted">Gerencie as vendas realizadas</p>
                        <a href="checkout.jsp" class="btn btn-danger w-100">
                            Acessar <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Ordem de Serviço -->
            <div class="col-md-3 mb-4">
                <div class="card card-custom shadow-sm text-center" style="border: 2px solid #6c757d;">
                    <div class="card-body">
                        <i class="fas fa-tools fa-4x text-secondary mb-3"></i>
                        <h5 class="card-title">🆕 Ordem de Serviço</h5>
                        <p class="card-text text-muted">Gerencie atendimentos técnicos</p>
                        <a href="ordemservico/consulta_ordem.jsp" class="btn btn-secondary w-100">
                            Acessar <i class="fas fa-arrow-right ms-2"></i>
                        </a>
                        <hr>
                        <div class="d-grid gap-2 mt-2">
                            <a href="ordemservico/ordem_servico.jsp" class="btn btn-sm btn-outline-secondary">
                                <i class="fas fa-plus-circle"></i> Nova Ordem
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
