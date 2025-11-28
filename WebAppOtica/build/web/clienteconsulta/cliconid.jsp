<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Cliente"%>
<%@page import="model.DAO.ClienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Cliente por ID</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container py-4">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0">Consulta de Cliente por ID</h2>
            </div>
            <div class="card-body">
                <%            
                ClienteDAO cliDAO = new ClienteDAO();
                Cliente cliente = null;
                
                // Verifica se o ID foi passado
                String idParam = request.getParameter("ident");
                if (idParam != null && !idParam.isEmpty()) {
                    try {
                        int id = Integer.parseInt(idParam);
                        cliente = cliDAO.consultaPorId(id);
                    } catch (NumberFormatException e) {
                        // Trata erro de conversão de ID
                    }
                }
                
                if (cliente != null) {
                %>
                    <div class="row">
                        <div class="col-md-6">
                            <h3>Detalhes do Cliente</h3>
                            <table class="table table-bordered">
                                <tr>
                                    <th>ID</th>
                                    <td><%= cliente.getIdCliente() %></td>
                                </tr>
                                <tr>
                                    <th>Nome Completo</th>
                                    <td><%= cliente.getNomeCompleto() %></td>
                                </tr>
                                <tr>
                                    <th>CPF</th>
                                    <td><%= cliente.getCpf() %></td>
                                </tr>
                                <tr>
                                    <th>Data de Nascimento</th>
                                    <td><%= cliente.getDataNascimento() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(cliente.getDataNascimento()) : "Não informada" %></td>
                                </tr>
                                <tr>
                                    <th>E-mail</th>
                                    <td><%= cliente.getEmail() %></td>
                                </tr>
                                <tr>
                                    <th>Telefone</th>
                                    <td><%= cliente.getTelefone() %></td>
                                </tr>
                                <tr>
                                    <th>Endereço</th>
                                    <td><%= cliente.getEndereco() %></td>
                                </tr>
                                <tr>
                                    <th>Cidade</th>
                                    <td><%= cliente.getCidade() %></td>
                                </tr>
                                <tr>
                                    <th>Estado</th>
                                    <td><%= cliente.getEstado() %></td>
                                </tr>
                                <tr>
                                    <th>Observações</th>
                                    <td><%= cliente.getObservacoes() != null ? cliente.getObservacoes() : "Sem observações" %></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                <% } else { %>
                    <div class="alert alert-warning" role="alert">
                        Nenhum cliente encontrado para o ID: <%= idParam %>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>