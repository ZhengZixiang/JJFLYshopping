<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
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
	<table align="left" border="1">
		<tr>
			<th colspan="2">订单信息</th>
		</tr>
		<tr>
			<td>订单ID</td>
			<td><%= so.getId() %></td>
		</tr>
		<tr>
			<td>用户ID</td>
			<td><%= so.getUser().getId() %></td>
		</tr>
		<tr>
			<td>用户名</td>
			<td><%= so.getUser().getUsername() %></td>
		</tr>
		<tr>
			<td>送货地址</td>
			<td><%= so.getAddr() %></td>
		</tr>
		<tr>
			<td>下单时间</td>
			<td><%= so.getOdate() %></td>
		</tr>
		<tr>
			<td>订单状态</td>
			<td><%= so.getStatus() %></td>
		</tr>
	</table>
	<table align="right" border="1">
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