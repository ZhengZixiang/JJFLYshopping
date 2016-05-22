<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>

<!DOCTYPE html>

<html>	
<head>
<title>UserLogin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<meta name="keywords" content="Flat Dark Web Login Form Responsive Templates, Iphone Widget Template, Smartphone login forms,Login form, Widget Template, Responsive Templates, a Ipad 404 Templates, Flat Responsive Templates" />
<link href="css/style.css" rel='stylesheet' type='text/css' />
</head>

<body>

<%
String action = request.getParameter("action");

if(action != null && action.equals("login")) {
	String username = request.getParameter("username");
	String password = request.getParameter("password");

	User u = null;
	try {
		u = User.validate(username, password);
	} catch (UserNotFoundException e) {
		out.println("User Not Found!");
		return;
	} catch (PasswordNotCorrectException e) {
		out.println("Password Not Correct!");
		return;
	}

	session.setAttribute("user", u);
	response.sendRedirect("SelfService.jsp");
}
%>

 <!--SIGN UP-->
 <h1>狂拽酷炫吊炸天的前台登录页面</h1>
<div class="login-form">
	<div class="close"> </div>
		<div class="head-info">
			<label class="lbl-1"> </label>
			<label class="lbl-2"> </label>
			<label class="lbl-3"> </label>
		</div>
			<div class="clear"> </div>
	<div class="avtar">
		<img src="images/avtar.png" />
	</div>
			<form action="Login.jsp" method="post">
					<input name="action" type="hidden" value="login"/>
					<input name="username" type="text" class="text" placeholder="用户名">
					<div class="key">
						<input name="password" type="password"  placeholder="密码"/>
					</div>
					<div class="signin">
						<input type="submit" value="登录" >
					</div>
			</form>
</div>
 <div class="copy-rights">
					<p>Copyright &copy; 2015.郑子相 All rights reserved.</p>
			</div>

</body>
</html>