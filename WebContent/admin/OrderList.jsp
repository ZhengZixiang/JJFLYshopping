<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表OrderList</title>
</head>
<body>
<%!
private static final int PAGE_SIZE = 3;
%>

<%
String strPageNo = request.getParameter("pageno");
int pageNo;
if(strPageNo == null || strPageNo == "") {
	pageNo = 1;
} else {
	try {
		pageNo = Integer.parseInt(strPageNo);
	} catch (NumberFormatException e) {
		pageNo = 1;
	}
}
if (pageNo <= 0) {
	pageNo = 1;
}

List<SalesOrder> orders = new ArrayList<SalesOrder>();
int pageCnt = OrderMgr.getInstance().getOrders(orders, pageNo, PAGE_SIZE);
if(pageNo > pageCnt) {
	pageNo = pageCnt;
}
%>
	<table border="1" align="center">
		<tr>
			<th colspan="6">订单列表</th>
		</tr>
		<tr align="center">
			<td>订单ID</td>
			<td>用户ID</td>
			<td>送货地址</td>
			<td>下单时间</td>
			<td>订单状态</td>
			<td>操作</td>
		</tr>
	<%
	for(Iterator<SalesOrder> it = orders.iterator(); it.hasNext(); ) {
		SalesOrder so = it.next();
	%>
		<tr align="center">
			<td><%= so.getId() %></td>
			<td><%= so.getUser().getUsername() %></td>
			<td><%= so.getAddr() %></td> 
			<td><%= so.getOdate() %></td>
			<td><%= so.getStatus()==0?"未处理":so.getStatus()==1?"已处理":"废单" %></td> 
			<td><a href="OrderDetailShow.jsp?id=<%= so.getId() %>" target="detail">订单明细</a> | <a href="OrderDelete.jsp?id=<%= so.getId() %>" target="detail">订单删除</a> | <a href="OrderModify.jsp?id=<%= so.getId() %>">订单修改</a></td>
		</tr>
	<%
	}
	%>
	</table>
	
	<div align="center">
		<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
		<% if(pageNo != 1) { %>
		<a href="OrderList.jsp?pageno=<%= pageNo-1 %>">上一页</a>
		<% } %>
		<% if(pageNo != pageCnt) {%>
		<a href="OrderList.jsp?pageno=<%= pageNo+1 %>">下一页</a>
		<% } %>
		<a href="OrderList.jsp?pageno=<%= pageCnt %>">尾页</a>
	</div>

	<center>
	<form name="form" action="OrderList.jsp" method="get" style="">
		<select name="pageno" onchange="document.form.submit()">
			<%
			for(int i = 1; i <= pageCnt; i++) {
			%>
			<option value="<%= i %>" <%= (i == pageNo) ? "selected" : "" %>>第<%= i %>页</option>
			<%
			}
			%>
		</select>
	</form>
	</center>
</body>
</html> 