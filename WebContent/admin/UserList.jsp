<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UserListPage</title>
</head>
<body>
<%
//get all users
List<User> users = UserManager.getUsers();
%>
	<table border="2" align="center">
		<tr>
			<th colspan="6">用户列表</th>
		</tr>
		<tr align="center">
			<td>用户ID</td>
			<td>用户名</td>
			<td>电话</td>
			<td>地址</td>
			<td>注册时间</td>
			<td>操作</td>
		</tr>
	<%
	for(Iterator<User> it = users.iterator(); it.hasNext(); ) {
		User u = it.next();
	%>
		<tr align="center">
			<td><%= u.getId() %></td>
			<td><%= u.getUsername() %></td>
			<td><%= u.getPhone() %></td>
			<td><%= u.getAddr() %></td>
			<td><%= u.getRdate() %></td> 
			<td><a href="DeleteUser.jsp?id=<%= u.getId() %>" target="detail">用户删除</a></td>
		</tr>
	<%
	}
	%>
	</table>
</body>
</html>