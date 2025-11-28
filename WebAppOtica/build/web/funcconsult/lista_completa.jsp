<%-- 
    Document   : lista_completa
    Created on : 27 de nov. de 2025, 15:16:15
    Author     : Notezin
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Funcionario"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta de Funcionários</title>
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
            <h2 class="mb-0">Consulta de Funcionários - Lista Completa</h2>
        </div>
        <div class="card-body">
            <%            
            FuncionarioDAO funcDAO = new FuncionarioDAO();
            List<Funcionario> lst = new ArrayList<>();         
            lst = funcDAO.consulta_geral();
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
                            <th>Cargo</th>
                            <th>Data Admissão</th>
                            <th>Salário</th>
                            <th>Status</th>
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
                            <td><%=lst.get(i).getIdFuncionario()%></td>
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
                            <td><%=lst.get(i).getCargo()%></td>
                            <td>
                            <% 
                            if (lst.get(i).getDataAdmissao() != null) { 
                                out.print(new java.text.SimpleDateFormat("dd/MM/yyyy").format(lst.get(i).getDataAdmissao()));
                            } else {
                                out.print("Não informada");
                            }
                            %>
                            </td>
                            <td>R$ <%=String.format("%.2f", lst.get(i).getSalario())%></td>
                            <td><%=lst.get(i).getStatus()%></td>
                            <td>
                                <div class="btn-group" role="group">
                                    <a href="../funcionarioalterar/func_cons_alt.jsp?ident=<%=lst.get(i).getIdFuncionario()%>" class="btn btn-sm btn-warning">
                                        <i class="fas fa-edit"></i> Editar
                                    </a>
                                    <a href="../funcionarioApagar/funcApagar.jsp?ident=<%=lst.get(i).getIdFuncionario()%>" class="btn btn-sm btn-danger">
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
                Nenhum funcionário encontrado no banco de dados.
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