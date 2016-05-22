<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品列表ProductList</title>
</head>
<body>
	<center>产品列表</center>
<%!
private static final int PAGE_SIZE = 3;
%>
<%
//get all products
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

List<Product> products = new ArrayList<Product>();
int pageCnt = ProductMgr.getInstance().getProducts(products, pageNo, PAGE_SIZE);
if(pageNo > pageCnt) {
	pageNo = pageCnt;
}
%>
	<table border="1" align="center">
		<tr>
			<td>ID</td>
			<td>Name</td>
			<td>Descr</td>
			<td>NormalPrice</td>
			<td>MemberPrice</td>
			<td>Pdate</td>
			<td>CategoryId</td>
			<td>Action</td>
		</tr>
	<%
	for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
		Product p = it.next();
	%>
		<tr>
			<td><%= p.getId() %></td>
			<td><%= p.getName() %></td>
			<td><%= p.getDescr() %></td> 
			<td><%= p.getNormalPrice() %></td>
			<td><%= p.getMemberPrice() %></td>
			<td><%= p.getPdate() %></td> 
			<td><%= p.getCategory().getName() %></td> 
			<td><a href="ProductDelete.jsp?id=<%= p.getId() %>" target="detail">产品删除</a> | <a href="ProductModify.jsp?id=<%= p.getId() %>">产品修改</a></td>
		</tr>
	<%
	}
	%>
	</table>
	
	<div align="center">
		<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
		<% if(pageNo != 1) { %>
		<a href="ProductList.jsp?pageno=<%= pageNo-1 %>">上一页</a>
		<% } %>
		<% if(pageNo != pageCnt) {%>
		<a href="ProductList.jsp?pageno=<%= pageNo+1 %>">下一页</a>
		<% } %>
		<a href="ProductList.jsp?pageno=<%= pageCnt %>">尾页</a>
	</div>

	<center>
	<form name="form" action="ProductList.jsp" method="get" style="">
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