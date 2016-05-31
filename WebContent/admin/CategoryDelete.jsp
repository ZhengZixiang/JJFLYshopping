<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除该类CategoryDelete</title>
<%
int id = Integer.parseInt(request.getParameter("id"));
Category c = Category.loadById(id);
c.delete();
response.sendRedirect("CategoryList.jsp");
%>
</head>
<body>

</body>
</html>