<%-- 
    Document   : buscarClientes
    Created on : 28 de nov. de 2025, 00:15:42
    Author     : Deskzito
--%>

<%@page import="model.DAO.ClienteDAO"%>
<%@page import="model.Cliente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nome = request.getParameter("nome");
    ClienteDAO clienteDAO = new ClienteDAO();
    List<Cliente> clientes = null;
    
    if (nome != null && !nome.trim().isEmpty()) {
        clientes = clienteDAO.consultaPorNome(nome);
    }
    
    if (clientes != null && !clientes.isEmpty()) {
        for (Cliente cliente : clientes) {
%>
            <option value="<%= cliente.getIdCliente() %>">
                <%= cliente.getNomeCompleto() %> - CPF: <%= cliente.getCpf() %>
            </option>
<%
        }
    } else {
%>
        <option value="">Nenhum cliente encontrado</option>
<%
    }
%>
