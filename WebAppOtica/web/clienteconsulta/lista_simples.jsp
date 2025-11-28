<%-- 
    Document   : lista_simples
    Created on : 27 de nov. de 2025, 12:39:54
    Author     : Notezin
--%>

<%@ page import="model.Cliente" %>
<%@ page import="model.DAO.ClienteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Clientes - Lista Simples</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container-fluid px-4 py-4">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0">Consulta de Clientes - Lista Simples</h2>
            </div>
            <div class="card-body">
                <%            
                ClienteDAO cliDAO = new ClienteDAO();
                List<Cliente> lst = new ArrayList<>();         
                lst = cliDAO.consulta_geral();
                if (lst != null && !lst.isEmpty()) {
                %>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Nome Completo</th>
                                    <th>CPF</th>
                                    <th>Email</th>
                                    <th>Telefone</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                int n_reg = 0;
                                for (Cliente cliente : lst) { 
                                    n_reg++;
                                %>
                                <tr>
                                    <td><%= cliente.getIdCliente() %></td>
                                    <td><%= cliente.getNomeCompleto() %></td>
                                    <td><%= cliente.getCpf() %></td>
                                    <td><%= cliente.getEmail() %></td>
                                    <td><%= cliente.getTelefone() %></td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="5" class="text-end">
                                        Total de registros: <%= n_reg %>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                <% } else { %>
                    <div class="alert alert-warning" role="alert">
                        Nenhum cliente encontrado.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS (opcional, mas recomendado) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>