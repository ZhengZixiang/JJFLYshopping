<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
int id = Integer.parseInt(request.getParameter("id"));
Category c = Category.loadById(id);
String action = request.getParameter("action");
if(action != null && action.trim().equals("modify")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	c.modify(name, descr);
	response.sendRedirect("CategoryList.jsp");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>类别修改CategoryModify</title>
</head>
<body>
	<form action="CategoryModify.jsp" method="post" >
		<input type="hidden" name="action" value="modify" />
		<input type="hidden" name="id" value="<%= id %>">
		<table align="center" border="1">
		<tr>
			<td>类别名称：</td>
			<td><input type="text" name="name" size="30" maxlength="30" value="<%= c.getName() %>"></td>
		</tr>
		<tr>
			<td>类别描述：</td>
			<td><textarea rows="5" cols="80" name="descr"><%= c.getDescr() %></textarea></td>
		</tr>
		<tr>
			<td colspan = 2>
				<input type="submit" value="修改"></input>
				<input type="reset" value="重置"></input>
			</td>
		</tr>
		</table>
	</form>
</body>
</html>