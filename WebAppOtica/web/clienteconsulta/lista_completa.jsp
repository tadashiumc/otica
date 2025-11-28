<%-- 
    Document   : lista_completa
    Created on : 27 de nov. de 2025, 15:16:15
    Author     : Notezin
--%>

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
    <title>Consulta de Clientes</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
        }
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <div class="container-fluid px-4 py-4">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h2 class="mb-0">Consulta de Clientes - Lista Completa</h2>
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
                                    <th>Data Nascimento</th>
                                    <th>E-mail</th>
                                    <th>Telefone</th>
                                    <th>Endereço</th>
                                    <th>Cidade</th>
                                    <th>Estado</th>
                                    <th>Observações</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%    
                                int n_reg = 0;
                                for (int i = 0; i <= lst.size() - 1; i++) {
                                    n_reg++;
                                %>        
                                <tr>
                                    <td><%=lst.get(i).getIdCliente()%></td>
                                    <td><%=lst.get(i).getNomeCompleto()%></td>
                                    <td><%=lst.get(i).getCpf()%></td>
                                    <td>
                                        <% 
                                        if (lst.get(i).getDataNascimento() != null) { 
                                            out.print(new java.text.SimpleDateFormat("dd/MM/yyyy").format(lst.get(i).getDataNascimento()));
                                        } else {
                                            out.print("Não informada");
                                        }
                                        %>
                                    </td>
                                    <td><%=lst.get(i).getEmail()%></td>
                                    <td><%=lst.get(i).getTelefone()%></td>
                                    <td><%=lst.get(i).getEndereco()%></td>
                                    <td><%=lst.get(i).getCidade()%></td>
                                    <td><%=lst.get(i).getEstado()%></td>
                                    <td><%=lst.get(i).getObservacoes() != null ? lst.get(i).getObservacoes() : "Sem observações"%></td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="../clientealterar/cli_cons_alt.jsp?ident=<%=lst.get(i).getIdCliente()%>" class="btn btn-sm btn-warning">
                                                <i class="fas fa-edit"></i> Editar
                                            </a>
                                            
                                            <a href="../clienteapagar/cliapagar.jsp?ident=<%=lst.get(i).getIdCliente()%>" class="btn btn-sm btn-danger">
                                                <i class="fas fa-trash"></i> Apagar
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="11" class="text-end">Total de Registros: <%=n_reg%></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                <% } else { %>
                    <div class="alert alert-warning text-center" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        Nenhum cliente encontrado no banco de dados.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</body>
</html>