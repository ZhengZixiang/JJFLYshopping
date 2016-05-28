<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>

<%
User u = (User) session.getAttribute("user");
if(u == null) {
	out.println("<center>您尚未登录！若确认购买，则按市场价结算！</center>");
	out.println("<center><a href='Login.jsp'>登录账号</a>");
	out.println("<a href='Register.jsp'>注册账号</a></center>");
}
%>

<jsp:useBean id="cart" class="me.zzx.shopping.Cart" scope="session"></jsp:useBean>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>确认订单Confirm</title>
<script type="text/javascript" src="Script/regcheckdata.js"></script>
</head>

<body>
		<br/><br/>
		<table align="center" border="1">
		<tr>
			<th>商品ID</th>
			<th>商品名称</th>
			<th>商品数量</th>
			<th>商品价格（<%= (u==null?"市场价":"会员价") %>）</th>
		</tr>
		
		<%
		List<CartItem>items = cart.getItems();
		double totalPrice = 0;
		for(int i = 0; i < items.size(); i++) {
			CartItem ci = items.get(i);
			Product p = ProductMgr.getInstance().loadById(ci.getProductId());
			if(ci.getCount() <= 0) {
				items.remove(i);
				continue;
			}
			%>
			<tr>
				<td><%= ci.getProductId() %></td>
				<td><%= ProductMgr.getInstance().loadById(ci.getProductId()).getName() %></td>
				<td><%= ci.getCount() %></td>
				<td><%= (u==null?p.getNormalPrice():p.getMemberPrice()) %></td>
			</tr>
			<%
			totalPrice = ci.getCount() * (u==null?p.getNormalPrice():p.getMemberPrice());
		}
		%>
	</table>
	<center>共计：<%= totalPrice %>元</center>
	
	<br/>
	<br/>
	<%
	if(u!=null) {
		%>
		<center>欢迎您，<%= u.getUsername() %>！请确认您的送货信息。</center>
		<br/>
		<%
	}
	%>
	<form name="form" action="Order.jsp" method="post" onsubmit="return checkData()">
		<table width="750" align="center" border="1">
			<tr>
				<th colspan="2" align="center">送货信息</th>
			</tr>

			<tr>
				<td>送货地址：</td>
				<td>
					<textarea rows="12" cols="80" name="addr" ><%= (u==null?"":u.getAddr()) %></textarea>
				</td>
			</tr>

			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="确认订单"></input>
				</td>
			</tr>
			
		</table>
	</form>
	
</body>
</html>