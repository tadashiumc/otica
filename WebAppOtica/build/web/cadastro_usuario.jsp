<%-- 
    Document   : cadastro_usuario
    Created on : Cadastro de Usuário - WebAppOtica
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
    <title>Cadastro - WebApp Ótica</title>
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
            padding: 20px;
        }

        .cadastro-container {
            width: 100%;
            max-width: 500px;
        }

        .cadastro-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .cadastro-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 20px;
            text-align: center;
        }

        .cadastro-header i {
            font-size: 40px;
            margin-bottom: 10px;
        }

        .cadastro-header h1 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .cadastro-body {
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

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-group input::placeholder {
            color: #999;
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

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .btn-group-cadastro {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn-cadastrar,
        .btn-voltar {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-cadastrar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-cadastrar:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-voltar {
            background: #f0f0f0;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-voltar:hover {
            background: #667eea;
            color: white;
        }

        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
        }

        .terms {
            font-size: 12px;
            color: #666;
            margin-top: 10px;
        }

        .terms input[type="checkbox"] {
            margin-right: 5px;
            cursor: pointer;
        }

        @media (max-width: 480px) {
            .cadastro-container {
                max-width: 100%;
            }

            .cadastro-body {
                padding: 30px 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .btn-group-cadastro {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="cadastro-container">
        <div class="cadastro-card">
            <!-- Header -->
            <div class="cadastro-header">
                <i class="fas fa-user-plus"></i>
                <h1>Criar Conta</h1>
            </div>

            <!-- Body -->
            <div class="cadastro-body">
                <%
                    String mensagem = "";
                    String tipo = "";
                    
                    if (request.getParameter("nomeUsuario") != null) {
                        try {
                            String nomeUsuario = request.getParameter("nomeUsuario");
                            String email = request.getParameter("email");
                            String senha = request.getParameter("senha");
                            String confirmaSenha = request.getParameter("confirmaSenha");
                            String perfil = request.getParameter("perfil");
                            
                            // Validações
                            if (nomeUsuario.isEmpty() || email.isEmpty() || senha.isEmpty()) {
                                mensagem = "Todos os campos são obrigatórios!";
                                tipo = "danger";
                            } else if (senha.length() < 6) {
                                mensagem = "Senha deve ter no mínimo 6 caracteres!";
                                tipo = "danger";
                            } else if (!senha.equals(confirmaSenha)) {
                                mensagem = "As senhas não conferem!";
                                tipo = "danger";
                            } else {
                                UsuarioDAO usuarioDAO = new UsuarioDAO();
                                
                                // Verificar se usuário já existe
                                if (usuarioDAO.existeNomeUsuario(nomeUsuario)) {
                                    mensagem = "Este nome de usuário já está cadastrado!";
                                    tipo = "danger";
                                } else {
                                    // Criar novo usuário
                                    Usuario usuario = new Usuario();
                                    usuario.setNomeUsuario(nomeUsuario);
                                    usuario.setEmail(email);
                                    usuario.setSenha(senha);
                                    usuario.setPerfil(perfil);
                                    usuario.setStatus("Ativo");
                                    
                                    if (usuarioDAO.cadastrar(usuario)) {
                                        mensagem = "Cadastro realizado com sucesso! Faça login agora.";
                                        tipo = "success";
                                    } else {
                                        mensagem = "Erro ao cadastrar usuário!";
                                        tipo = "danger";
                                    }
                                }
                            }
                        } catch (Exception e) {
                            mensagem = "Erro no processamento: " + e.getMessage();
                            tipo = "danger";
                        }
                    }
                %>

                <% if (!mensagem.isEmpty()) { %>
                    <div class="alert alert-<%= tipo %>" role="alert">
                        <i class="fas <%= tipo.equals("danger") ? "fa-exclamation-circle" : "fa-check-circle" %>"></i>
                        <%= mensagem %>
                        <% if (tipo.equals("success")) { %>
                            <br>
                            <a href="login.jsp" style="color: inherit; text-decoration: underline; margin-top: 10px; display: block;">
                                Clique aqui para fazer login
                            </a>
                        <% } %>
                    </div>
                <% } %>

                <form method="POST" action="cadastro_usuario.jsp" id="formCadastro">
                    <div class="form-group">
                        <label for="nomeUsuario">
                            <i class="fas fa-user"></i> Nome de Usuário
                        </label>
                        <input type="text" class="form-control" id="nomeUsuario" name="nomeUsuario" 
                               placeholder="Escolha um nome de usuário" required autofocus>
                    </div>

                    <div class="form-group">
                        <label for="email">
                            <i class="fas fa-envelope"></i> Email
                        </label>
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="seu.email@exemplo.com" required>
                    </div>

                    <div class="form-group">
                        <label for="perfil">
                            <i class="fas fa-shield-alt"></i> Perfil
                        </label>
                        <select class="form-control" id="perfil" name="perfil" required>
                            <option value="">Selecione um perfil</option>
                            <option value="Administrador">Administrador</option>
                            <option value="Vendedor">Vendedor</option>
                            <option value="Tecnico">Técnico</option>
                            <option value="Gerente">Gerente</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="senha">
                            <i class="fas fa-lock"></i> Senha
                        </label>
                        <input type="password" class="form-control" id="senha" name="senha" 
                               placeholder="Digite uma senha segura (mín. 6 caracteres)" required
                               onkeyup="verificarForcaSenha()">
                        <div class="password-strength">
                            <div class="password-strength-bar" id="strengthBar"></div>
                        </div>
                        <small id="strengthText" style="color: #999; display: block; margin-top: 5px;"></small>
                    </div>

                    <div class="form-group">
                        <label for="confirmaSenha">
                            <i class="fas fa-lock"></i> Confirmar Senha
                        </label>
                        <input type="password" class="form-control" id="confirmaSenha" name="confirmaSenha" 
                               placeholder="Confirme sua senha" required>
                    </div>

                    <div class="terms">
                        <label>
                            <input type="checkbox" name="termos" required> 
                            Eu concordo com os <a href="#" style="color: #667eea;">Termos de Serviço</a>
                        </label>
                    </div>

                    <div class="btn-group-cadastro">
                        <button type="submit" class="btn-cadastrar">
                            <i class="fas fa-user-check"></i> Criar Conta
                        </button>
                        <a href="login.jsp" class="btn-voltar" style="display: flex; align-items: center; justify-content: center;">
                            <i class="fas fa-arrow-left" style="margin-right: 8px;"></i> Voltar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function verificarForcaSenha() {
            const senha = document.getElementById('senha').value;
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            let forca = 0;
            let texto = '';
            
            if (senha.length >= 6) forca += 25;
            if (senha.length >= 8) forca += 25;
            if (/[a-z]/.test(senha) && /[A-Z]/.test(senha)) forca += 25;
            if (/[0-9]/.test(senha)) forca += 25;
            
            strengthBar.style.width = forca + '%';
            
            if (forca < 25) {
                strengthBar.style.backgroundColor = '#dc3545';
                strengthText.textContent = 'Muito fraca';
                strengthText.style.color = '#dc3545';
            } else if (forca < 50) {
                strengthBar.style.backgroundColor = '#ffc107';
                strengthText.textContent = 'Fraca';
                strengthText.style.color = '#ffc107';
            } else if (forca < 75) {
                strengthBar.style.backgroundColor = '#17a2b8';
                strengthText.textContent = 'Média';
                strengthText.style.color = '#17a2b8';
            } else {
                strengthBar.style.backgroundColor = '#28a745';
                strengthText.textContent = 'Forte';
                strengthText.style.color = '#28a745';
            }
        }

        // Validar senhas iguais em tempo real
        document.getElementById('confirmaSenha').addEventListener('keyup', function() {
            const senha = document.getElementById('senha').value;
            const confirmaSenha = this.value;
            
            if (confirmaSenha && senha !== confirmaSenha) {
                this.style.borderColor = '#dc3545';
            } else if (confirmaSenha) {
                this.style.borderColor = '#28a745';
            } else {
                this.style.borderColor = '#e0e0e0';
            }
        });
    </script>
</body>
</html>
