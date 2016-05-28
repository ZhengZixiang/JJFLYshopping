<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
    
<%  
User u = (User) session.getAttribute("user");
if(u == null) {
	out.println("You haven't logged in!");
	return;
}
request.setCharacterEncoding("UTF-8");
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情OrderDetailShow</title>
</head>
<body>
<table align="center" border="1">
	<tr>
		<th>商品ID</th>
		<th>商品名称</th>
		<th>商品单价</th>
		<th>商品数量</th>
	</tr>
	
	<%
	List<SalesItem>items = so.getItems(so);
	double totalPrice = 0;
	for(int i = 0; i < items.size(); i++) {
		SalesItem si = items.get(i);
		%>
		<tr>
			<td onmouseover="showProductInfo('<%= si.getProduct().getDescr() %>')"><%= si.getProduct().getId() %></td>
			<td><%= si.getProduct().getName() %></td>
			<td><%= si.getUnitPrice() %></td>
			<td><%= si.getPcount() %></td>
		</tr>
		<%
		totalPrice += si.getUnitPrice() * si.getPcount();
	}
	%>
	<tr>
		<td colspan="4"><center>共计：<%= totalPrice %>元</center></td>
	</tr>	
</table>
</body>
</html>