<%-- 
    Document   : logout
    Logout - WebAppOtica
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Remover todos os atributos da sessão
    if (session.getAttribute("usuarioId") != null) {
        session.removeAttribute("usuarioId");
    }
    if (session.getAttribute("usuarioNome") != null) {
        session.removeAttribute("usuarioNome");
    }
    if (session.getAttribute("usuarioPerfil") != null) {
        session.removeAttribute("usuarioPerfil");
    }
    if (session.getAttribute("usuarioEmail") != null) {
        session.removeAttribute("usuarioEmail");
    }
    
    // Invalidar a sessão completamente
    session.invalidate();
    
    // Definir headers para não cachear
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    
    // Redirecionar para login
    response.sendRedirect("login.jsp");
%>
