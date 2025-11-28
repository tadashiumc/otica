<%-- 
    Document   : login
    Created on : Login - WebAppOtica
    Author     : Notezin
--%>

<%@page import="model.Usuario"%>
<%@page import="model.DAO.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebApp Ótica - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            padding: 20px;
        }

        .login-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 20px;
            text-align: center;
        }

        .login-header i {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .login-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group input::placeholder {
            color: #999;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 13px;
        }

        .remember-forgot a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .remember-forgot a:hover {
            color: #764ba2;
        }

        .remember-forgot input[type="checkbox"] {
            margin-right: 5px;
            cursor: pointer;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .alert {
            margin-bottom: 20px;
            border-radius: 8px;
            border: none;
            font-size: 14px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
            color: #999;
            font-size: 13px;
        }

        .divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #e0e0e0;
        }

        .divider span {
            background: white;
            padding: 0 10px;
            position: relative;
            z-index: 1;
        }

        .btn-signup {
            width: 100%;
            padding: 12px;
            background: #f0f0f0;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: all 0.3s ease;
        }

        .btn-signup:hover {
            background: #667eea;
            color: white;
        }

        .input-group-icon {
            position: relative;
        }

        .input-group-icon i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            pointer-events: none;
        }

        .input-group-icon input {
            padding-right: 40px;
        }

        @media (max-width: 480px) {
            .login-container {
                max-width: 100%;
            }

            .login-body {
                padding: 30px 20px;
            }

            .login-header {
                padding: 30px 20px;
            }

            .login-header i {
                font-size: 40px;
            }

            .login-header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <!-- Header -->
            <div class="login-header">
                <i class="fas fa-glasses"></i>
                <h1>WebApp Ótica</h1>
                <p>Sistema de Gestão</p>
            </div>

            <!-- Body -->
            <div class="login-body">
                <%
                    String mensagem = "";
                    String tipo = "";
                    
                    if (request.getParameter("nomeUsuario") != null) {
                        try {
                            String nomeUsuario = request.getParameter("nomeUsuario");
                            String senha = request.getParameter("senha");
                            
                            UsuarioDAO usuarioDAO = new UsuarioDAO();
                            Usuario usuario = usuarioDAO.login(nomeUsuario, senha);
                            
                            if (usuario != null) {
                                // Login bem-sucedido
                                session.setAttribute("usuarioId", usuario.getIdUsuario());
                                session.setAttribute("usuarioNome", usuario.getNomeUsuario());
                                session.setAttribute("usuarioPerfil", usuario.getPerfil());
                                session.setAttribute("usuarioEmail", usuario.getEmail());
                                
                                // Redirecionar para home
                                response.sendRedirect("index.jsp");
                            } else {
                                mensagem = "Usuário ou senha inválidos!";
                                tipo = "danger";
                            }
                        } catch (Exception e) {
                            mensagem = "Erro ao processar login: " + e.getMessage();
                            tipo = "danger";
                        }
                    }
                %>

                <% if (!mensagem.isEmpty()) { %>
                    <div class="alert alert-<%= tipo %>" role="alert">
                        <i class="fas <%= tipo.equals("danger") ? "fa-exclamation-circle" : "fa-check-circle" %>"></i>
                        <%= mensagem %>
                    </div>
                <% } %>

                <form method="POST" action="login.jsp">
                    <div class="form-group">
                        <label for="nomeUsuario">
                            <i class="fas fa-user"></i> Usuário
                        </label>
                        <div class="input-group-icon">
                            <input type="text" class="form-control" id="nomeUsuario" name="nomeUsuario" 
                                   placeholder="Digite seu usuário" required autofocus>
                            <i class="fas fa-user"></i>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="senha">
                            <i class="fas fa-lock"></i> Senha
                        </label>
                        <div class="input-group-icon">
                            <input type="password" class="form-control" id="senha" name="senha" 
                                   placeholder="Digite sua senha" required>
                            <i class="fas fa-lock"></i>
                        </div>
                    </div>

                    <div class="remember-forgot">
                        <label>
                            <input type="checkbox" name="lembrar"> Lembrar-me
                        </label>
                        <a href="#" title="Esta funcionalidade será implementada em breve">Esqueci minha senha</a>
                    </div>

                    <button type="submit" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i> Entrar
                    </button>
                </form>

                <div class="divider">
                    <span>Novo por aqui?</span>
                </div>

                <a href="cadastro_usuario.jsp" class="btn-signup" style="text-decoration: none;">
                    <i class="fas fa-user-plus"></i> Criar Conta
                </a>
            </div>
        </div>

        <!-- Footer -->
        <div style="text-align: center; color: white; margin-top: 30px; font-size: 12px;">
            <p>&copy; 2025 WebApp Ótica. Todos os direitos reservados.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
