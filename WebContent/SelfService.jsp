<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%  
	User u = (User) session.getAttribute("user");
	if(u == null) {
		out.println("You haven't logged in!");
		return;
	}
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	if(action != null && action.trim().equals("modify")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setAddr(addr);
		u.update();
		out.println("Congratulation! Modify Successfully!");
		return;
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户修改UserModify</title>
</head>
<body>
	<form name="form" action="UserModify.jsp" method="post" onsubmit="return checkData()">
		<input type="hidden" name="action" value="modify"/>
		<table width="750" align="center" border="2">
			<tr>
				<th colspan="2" align="center">用户修改</th>
			</tr>

			<tr>
				<td>用户名：</td>
				<td>
					<input type="text" name="username" size="30" maxlength="30" onblur="checkUsername()" value="<%= u.getUsername() %>">
					<span id="unErr"></span>
				</td>
			</tr>
			
			<tr>
				<td>电话：</td>
				<td>
					<input type="text" name="phone" size="30" maxlength="13" onblur="checkPhone()" value="<%= u.getPhone() %>">
					<span id="phoneErr"></span>
				</td>
			</tr>

			<tr>
				<td>送货地址：</td>
				<td>
					<textarea rows="12" cols="80" name="addr" ><%= u.getAddr() %></textarea>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<input type="submit" value="提交"></input>
					<input type="reset" value="重置"></input>
				</td>
			</tr>
			
		</table>
	</form>
	<script type="text/javascript" src="Script/regcheckdata.js"></script>
</body>
</html>