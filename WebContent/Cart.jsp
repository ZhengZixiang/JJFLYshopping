<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>

    
<%--
Cart cart = (Cart)session.getAttribute("cart");
if(cart == null) {
	cart = new Cart();
	session.setAttribute("cart", cart);
}
//Java code above could be replaced by JSP code like beneath
--%>

<jsp:useBean id="cart" class="me.zzx.shopping.Cart" scope="session"></jsp:useBean>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车Cart</title>
</head>
<body>
	<center><h1>购物车</h1></center>
	<br>
	
<form action="CartUpdate.jsp" method="get">
	<table align="center" border="1">
		<tr>
			<th>商品ID</th>
			<th>商品名称</th>
			<th>商品数量</th>
			<th>商品价格</th>
			<th>商品总价</th>
			<th>操作</th>
		</tr>
		
		<%
		List<CartItem>items = cart.getItems();
		for(int i = 0; i < items.size(); i++) {
			CartItem ci = items.get(i);
			if(ci.getCount() <= 0) {
				items.remove(i);
				continue;
			}
			%>
			<tr>
				<td><%= ci.getProductId() %></td>
				<td><%= ProductMgr.getInstance().loadById(ci.getProductId()).getName() %></td>
				<td><input size="6" maxlength="8" type="text" value="<%= ci.getCount() %>" name="p<%= ci.getProductId()%>"></td>
				<td><%= ci.getPrice() %></td>
				<td><%= ci.getTotalPrice() %></td>
				<td><a href="DeleteItem.jsp?id=<%= ci.getProductId() %>">删除此项</a></td>
			</tr>
			<%
		}
		%>

	</table>
	<center>共计：<%= cart.getTotalPrice() %>元</center>
	
	<br>
	<center><input align="middle" type="submit" value="修改商品数量"/> <input type="button" value="提交订单" onclick="document.location.href='Confirm.jsp'"/></center>
</form>
</body>
</html>