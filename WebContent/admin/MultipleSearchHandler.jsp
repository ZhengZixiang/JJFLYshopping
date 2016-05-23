<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MultipleSearchHandler</title>
</head>


<body>

	<%! private static final int PAGE_SIZE = 3; %>
	<%
	request.setCharacterEncoding("UTF-8");
	
	String action = request.getParameter("action");
	int categoryId = Integer.parseInt(request.getParameter("categoryid"));
	String keyword = request.getParameter("keyword");
	String strAllIds = "";
	String[] strCategoryIds = request.getParameterValues("categoryid");
	List<Product> products = null;
	int [] categoryArr;
	int pageNo;
	int pageCnt = 0;
	String strPageNo = request.getParameter("pageno");
	if(strPageNo == null || strPageNo.equals("")) {
		pageNo = 1;
	} else {
		try {
			 pageNo = Integer.parseInt(strPageNo);
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
	}
	if(pageNo <= 0) {
		pageNo = 1;
	}
	if(strCategoryIds == null || strCategoryIds.length == 0) {
		categoryArr = null;
	} else {
		categoryArr = new int[strCategoryIds.length];
		for(int i=0; i < categoryArr.length; i++) {
			categoryArr[i] = Integer.parseInt(strCategoryIds[i]);
			strAllIds += "&categoryid=" + strCategoryIds[i];
		}
		
		products = new ArrayList<Product>();
		pageCnt = ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, -1, -1, -1, -1, null, null, pageNo, PAGE_SIZE);
		if(pageNo > pageCnt) {
			pageNo = pageCnt;
			ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, -1, -1, -1, -1, null, null, pageNo, PAGE_SIZE);
		}
	}
	%>
			
	<!-- display the result table about search -->
	<center>搜索结果</center>
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
				<td><%= p.getCategoryId() %></td> 
				<td><a href="ProductDelete.jsp?id=<%= p.getId() %>" target="detail">产品删除</a> | <a href="ProductModify.jsp?id=<%= p.getId() %>">产品修改</a></td>
			</tr>
		<%
		}
		%>
	</table>
		
	<div align="center">
		<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
		<% if(pageNo != 1) { %>
		<a href="ProductSearch2.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageNo-1 %>">上一页</a>
		<% } %>
		<% if(pageNo != pageCnt) {%>
		<a href="ProductSearch2.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageNo+1 %>">下一页</a>
		<% } %>
		<a href="ProductSearch2.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageCnt %>">尾页</a>
	</div>
	
	<center>
	<form name="pageselect" action="ProductSearch2.jsp" method="get">
		<input type="hidden" name="action" value="<%= action %>"/>
		<input type="hidden" name="keyword" value="<%= keyword %>"/>
		<% for(int i = 0; i < categoryArr.length; i++){ %>
			<input type="hidden" name="categoryid" value="<%= categoryArr[i] %>"/>
		<% } %>
		<select name="pageno" onchange="document.pageselect.submit()">
		<% for(int i = 1; i <= pageCnt; i++) { %>
				<option value="<%= i %>" <%= (i == pageNo) ? "selected" : "" %>>第<%= i %>页</option>
		<% } %>
		</select>
	</form>
	</center>

</body>
</html>