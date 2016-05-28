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
			<th colspan="5">类别列表</th>
		</tr>
		<tr align="center">
			<td>类别ID</td>
			<td>类别名称</td>
			<td>父类别ID</td>
			<td>类别等级</td>
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
			<td align="center"><%= c.getId() %></td>
			<td><%= preStr + c.getName() %></td>
			<td align="center"><%= c.getPid() %></td>
			<td align="center"><%= c.getGrade() %></td>
			<td><a href="CategoryAdd.jsp?pid=<%= c.getId() %>">添加子类</a> 
			 | <a href="CategoryModify.jsp?id=<%= c.getId() %>">编辑该类</a>
			<% if(c.isLeaf()) { %>
			 | <a href="ProductAdd.jsp?categoryid=<%= c.getId() %>">添加产品</a>
			 | <a href="CategoryDelete.jsp?id=<%= c.getId() %>">删除子类</a></td>
			<% } %>
		</tr>
	<%
	}
	%>
	</table>
</body>
</html>