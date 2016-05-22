<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>类别列表CategoryList</title>
</head>
<body>
<%
//get all users
List<Category> categories = Category.getCategories();
%>
	<table border="2" align="center">
		<tr>
			<td>ID</td>
			<td>Name</td>
			<td>Pid</td>
			<td>Grade</td>
			<td colspan="3">Action</td>
		</tr>
	<%
	for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
		Category c = it.next();
		String preStr = "";
		for(int i = 1; i < c.getGrade(); i++) {
			preStr = preStr + "----";
		}
	%>
		<tr>
			<td><%= c.getId() %></td>
			<td><%= preStr + c.getName() %></td>
			<td><%= c.getPid() %></td>
			<td><%= c.getGrade() %></td>
			<td><a href="CategoryAdd.jsp?pid=<%= c.getId() %>">添加子类</a> 
			 | <a href="CategoryDelete.jsp?id=<%= c.getId() %>">删除该类</a>
			 | <a href="CategoryModify.jsp?id=<%= c.getId() %>">编辑该类</a>
			<% if(c.isLeaf()) { %>
			 | <a href="ProductAdd.jsp?categoryid=<%= c.getId() %>">添加产品</a></td>
			<% } %>
		</tr>
	<%
	}
	%>
	</table>
</body>
</html>