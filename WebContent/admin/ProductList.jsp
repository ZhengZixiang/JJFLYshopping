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
			<th colspan="8">产品列表</th>
		</tr>
		<tr align="center">
			<td>产品ID</td>
			<td>产品名称</td>
			<td>产品描述</td>
			<td>市场价</td>
			<td>会员价</td>
			<td>上市时间</td>
			<td>产品类别</td>
			<td>操作</td>
		</tr>
	<%
	for(Iterator<Product> it = products.iterator(); it.hasNext(); ) {
		Product p = it.next();
	%>
		<tr align="center">
			<td><%= p.getId() %></td>
			<td><%= p.getName() %></td>
			<td><%= p.getDescr() %></td> 
			<td><%= p.getNormalPrice() %></td>
			<td><%= p.getMemberPrice() %></td>
			<td><%= p.getPdate() %></td> 
			<td><%= p.getCategory().getName() %></td> 
			<td>
				<a href="ProductDelete.jsp?id=<%= p.getId() %>" target="detail">产品删除</a>
				 | <a href="ProductModify.jsp?id=<%= p.getId() %>">产品修改</a>
				 | <a href="ProductImageUpload.jsp?id=<%= p.getId() %>" target="detail">上传图片</a>	 
			</td>
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