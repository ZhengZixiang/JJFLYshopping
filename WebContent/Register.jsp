<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	if(action != null && action.trim().equals("register")) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
//System.out.println(username + password + phone + addr);
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setPhone(phone);
		u.setAddr(addr);
		u.setRdate(new java.util.Date(System.currentTimeMillis()));
		u.save();
		out.println("Congratulation! Register Successfully!");
		return;
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RegisterPage</title>
</head>
<body>
	<form name="form" action="Register.jsp" method="post" onsubmit="return checkData()">
		<input type="hidden" name="action" value="register"/>
		<table width="750" align="center" border="2">
			<tr>
				<th colspan="2" align="center">用户注册</th>
			</tr>

			<tr>
				<td>用户名：</td>
				<td>
					<input type="text" name="username" size="30" maxlength="30" onblur="checkUsername()">
					<span id="unErr"></span>
				</td>
			</tr>
			<tr>
				<td>密码：</td>
				<td>
					<input type="password" name="password" size="20" maxlength="16" onblur="checkPassword()">
					<span id="passwordErr"></span>
				</td>
			</tr>
			<tr>
				<td>确认密码：</td>
				<td>
					<input type="password" name="password2" size="20" maxlength="16" onblur="checkPassword()">
					<span id="passwordErr2"></span>
				</td>
			</tr>

			<tr>
				<td>电话：</td>
				<td>
					<input type="text" name="phone" size="30" maxlength="13" onblur="checkPhone()">
					<span id="phoneErr"></span>
				</td>
			</tr>

			<tr>
				<td>送货地址：</td>
				<td>
					<textarea rows="5" cols="80" name="addr" ></textarea>
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