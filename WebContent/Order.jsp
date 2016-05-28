<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.sql.*" %>

<jsp:useBean id="cart" class="me.zzx.shopping.Cart" scope="session"></jsp:useBean>

<%
User u = (User) session.getAttribute("user");
if(u == null) {
	u = new User();
	u.setId(-1);
}

if(cart == null) {
	out.println("<center>没有任何购物项！<a href='index.jsp'>返回首页</a></center>");
	return;
}

request.setCharacterEncoding("UTF-8");
String addr = request.getParameter("addr");
SalesOrder so = new SalesOrder();
so.setCart(cart);
so.setAddr(addr);
so.setOdate(new Timestamp(System.currentTimeMillis()));
so.setUser(u);
so.setStatus(0);
so.save();

session.removeAttribute("cart");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单Order</title>
<script type="text/javascript" src="Script/go.js"></script>
</head>
<body>
	<div id="timeleft" align="center">订单提交成功！谢谢您在本站购物！3秒后返回购物车！</div>
	<center>若没有跳转，请手动点击<a href="Cart.jsp">回到购物车</a></center>
	<script type="text/javascript">
		setInterval("go('order')", 1000);
	</script>
</body>
</html>