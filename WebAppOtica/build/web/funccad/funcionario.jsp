<%-- 
    Document   : cliente
    Created on : 27 de nov. de 2025, 14:24:01
    Author     : Notezin
--%>

<%@page import="model.Funcionario"%>
<%@page import="model.DAO.FuncionarioDAO"%>
<%@page import="java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Funcionários</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <link href="../style_css/geral2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <h2>Controle de Funcionários</h2>
    <%
    //Instância do objeto
    Funcionario func = new Funcionario();
    if (request.getParameter("nomeCompleto") != null) {
        try {
            // NÃO DEFINA O ID - deixe o banco gerar
            func.setNomeCompleto(request.getParameter("nomeCompleto"));
            func.setEmail(request.getParameter("email"));
            func.setTelefone(request.getParameter("telefone"));
            func.setDataNascimento(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataNascimento")));
            func.setCpf(request.getParameter("cpf"));
            func.setCargo(request.getParameter("cargo"));
            func.setDataAdmissao(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataAdmissao")));
            func.setSalario(Double.parseDouble(request.getParameter("salario")));
            func.setStatus(request.getParameter("status"));

            //Saída dos dados
            out.println("Nome do Funcionário: " + func.getNomeCompleto());
            out.println("<br>E-mail.........: " + func.getEmail());
            out.println("<br>CPF............: " + func.getCpf());
            out.println("<br>Telefone.......: " + func.getTelefone());
            out.println("<br>Nascimento.....: " + func.getDataNascimento());
            out.println("<br>Cargo..........: " + func.getCargo());
            out.println("<br>Data Admissão..: " + func.getDataAdmissao());
            out.println("<br>Salário........: R$ " + String.format("%.2f", func.getSalario()));
            out.println("<br>Status.........: " + func.getStatus());

            //Salvar
            FuncionarioDAO funcDAO = new FuncionarioDAO();
            if (funcDAO.cadastrar(func)) {
                out.println("<br><strong style='color: green;'> Funcionário inserido com sucesso!!!</strong>");
            } else {
                out.println("<br><strong style='color: red;'> Erro ao cadastrar funcionário!</strong>");
            }
        } catch (Exception e) {
            out.println("<br><strong style='color: red;'>Erro: " + e.getMessage() + "</strong>");
            e.printStackTrace();
        }
    } else {
        out.println("<strong style='color: red;'>Por favor, preencha todos os campos!</strong>");
    }
    %>
    <p> <button onclick="document.location='../'" class="voltar-btn">Voltar</button> </p>
</div>
</body>
</html>