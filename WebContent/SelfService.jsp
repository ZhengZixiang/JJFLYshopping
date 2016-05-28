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
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户自服务SelfService</title>
</head>
<body>
<center>
	<a href="UserModify.jsp">账号信息修改</a>
	 | <a href="UserOrder.jsp">我的订单</a>
	 | <a href="LogOut.jsp">退出当前账号</a>
</center>
</body>
</html>