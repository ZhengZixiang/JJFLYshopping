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

List<SalesOrder> orders = OrderMgr.getInstance().getOrders(u);
if(orders == null) {
	out.println("未查询到订单！");
	return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的订单UserOrder</title>
</head>
<body>
	<table border="1" align="center">
		<tr>
			<th colspan="5">订单信息</th>
		</tr>
		<tr>
			<td>订单ID</td>
			<td>送货地址</td>
			<td>下单时间</td>
			<td>订单状态</td>
			<td>操作</td>
		</tr>
		<%
		for(Iterator<SalesOrder> it = orders.iterator(); it.hasNext(); ) {
			SalesOrder so = it.next();
		%>
			<tr>
				<td><%= so.getId() %></td>
				<td><%= so.getAddr() %></td> 
				<td><%= so.getOdate() %></td>
				<td><%= (so.getStatus()==0?"未处理":so.getStatus()==1?"已处理":"废单") %></td>
				<td><a href="UserOrderDetailShow.jsp?id=<%= so.getId() %>">订单详情</a></td>
			</tr>
		<%
		}
		%>
	</table>
</body>
</html>