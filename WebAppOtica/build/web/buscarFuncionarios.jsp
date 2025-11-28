<%-- 
    Document   : buscarFuncionarios
    Created on : 28 de nov. de 2025, 00:19:27
    Author     : Deskzito
--%>

<%@page import="model.DAO.FuncionarioDAO"%>
<%@page import="model.Funcionario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nome = request.getParameter("nome");
    FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
    List<Funcionario> funcionarios = null;
    
    if (nome != null && !nome.trim().isEmpty()) {
        funcionarios = funcionarioDAO.consultaPorNome(nome);
    }
    
    if (funcionarios != null && !funcionarios.isEmpty()) {
        for (Funcionario funcionario : funcionarios) {
%>
            <option value="<%= funcionario.getIdFuncionario() %>">
                <%= funcionario.getNomeCompleto() %> - CPF: <%= funcionario.getCpf() %>
            </option>
<%
        }
    } else {
%>
        <option value="">Nenhum funcionário encontrado</option>
<%
    }
%>
