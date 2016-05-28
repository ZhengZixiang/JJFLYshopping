<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>

<%@ include file="_sessionCheck.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String strPid = request.getParameter("pid");
	int pid = 0;
	if(strPid != null && !strPid.trim().equals("")) {
		pid = Integer.parseInt(strPid);
	}
	String action = request.getParameter("action");
	if(action != null && action.trim().equals("add")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		if(pid == 0) {
			Category.addTopCategory(name, descr);
		} else {
			//Category.addChildCategory(pid, name, descr);
			Category parent = Category.loadById(pid);
			Category child = new Category();
			child.setId(-1);
			child.setName(name);
			child.setDescr(descr);
			parent.addChild(child);
		}
		out.println("Congratulation! Category Add Successfully!");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DeleteUserPage</title>
</head>
<body>

	<form action="CategoryAdd.jsp" method="post" >
		<input type="hidden" name="action" value="add" />
		<input type="hidden" name="pid" value="<%= pid %>">
		<table align="center" border="1">
		<tr>
		<% if(pid == 0) { %>
		<th colspan="2">添加根类别</th>
		<% } else { %>
		<th colspan="2">添加子类别</th>
		<% } %>
		</tr>
		<tr>
			<td>类别名称：</td>
			<td><input type="text" name="name" size="30" maxlength="30"></td>
		</tr>
		<tr>
			<td>类别描述：</td>
			<td><textarea rows="5" cols="80" name="descr"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="reset" value="重置"></input>
				<input type="submit" value="提交"></input>
			</td>
		</tr>
		</table>
	</form>
</body>
</html>