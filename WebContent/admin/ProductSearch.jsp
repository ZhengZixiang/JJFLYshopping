<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ include file="_sessionCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品搜索ProductSearch</title>
<jsp:forward page="ProductSearch2.jsp"></jsp:forward>
<script type="text/javascript">
<!--
function checkdata() {
	with(document.forms["complex"]) {
		if(lownormalprice.value == null || lownormalprice.value == "") {
			lownormalprice.value = "-1";
		}
		if(highnormalprice.value == null || highnormalprice.value == "") {
			highnormalprice.value = "-1";
		}
		if(lowmemberprice.value == null || lowmemberprice.value == "") {
			lowmemberprice.value = "-1";
		}
		if(highmemberprice.value == null || highmemberprice.value == "") {
			highmemberprice.value = "-1";
		}
	}
}
-->
</script>
</head>
<%! private static final int PAGE_SIZE = 3; %>
<%
request.setCharacterEncoding("UTF-8");

List<Category> categories = Category.getCategories();

String action = request.getParameter("action");
if(action != null) {
	
	
	int pageCnt = 0;
	String keyword = null;
	double lowNormalPrice = -1;
	double highNormalPrice = -1;
	double lowMemberPrice = -1;
	double highMemberPrice = -1;
	String strStart = null;
	String strEnd = null;
	int categoryId = 0;
	List<Product> products = new ArrayList<Product>();
	String strAllIds = "";
	int [] categoryArr = null;

	int pageNo;
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
	
	if(action.trim().equals("simple")) {
		categoryId = Integer.parseInt(request.getParameter("categoryid"));
		keyword = request.getParameter("keyword");
		pageCnt = ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, null, null, pageNo, PAGE_SIZE);
		if(pageNo > pageCnt) {
			pageNo = pageCnt;
			ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, null, null, pageNo, PAGE_SIZE);
		}
	} else if (action.trim().equals("complex")){
		categoryId = Integer.parseInt(request.getParameter("categoryid"));
		keyword = request.getParameter("keyword");
		lowNormalPrice = Double.parseDouble(request.getParameter("lownormalprice"));
		highNormalPrice = Double.parseDouble(request.getParameter("highnormalprice"));
		lowMemberPrice = Double.parseDouble(request.getParameter("lowmemberprice"));
		highMemberPrice = Double.parseDouble(request.getParameter("highmemberprice"));
		strStart = request.getParameter("startdate");
		strEnd = request.getParameter("enddate");
		Date startDate;
		Date endDate;
		//Timestamp startDate;
		//Timestamp endDate;
		
		if(categoryId == 0) {
			categoryArr = null;
		} else {
			categoryArr = new int[1];
			categoryArr[1] = categoryId;
		}
		if(strStart == null || strStart.trim().equals("")) {
			startDate = null;
		} else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			startDate = format.parse(strStart);
			//startDate = Timestamp.valueOf(strStart);
		}
		if(strEnd == null || strEnd.trim().equals("")) {
			endDate = null;
		} else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			endDate = format.parse(strEnd);
			//endDate = Timestamp.valueOf(strEnd); 
		}
//System.out.println(categoryId + "==" + keyword + "==" + lowNormalPrice + "==" + highNormalPrice + "==" + lowMemberPrice + "==" + highMemberPrice + "==" + startDate + "==" + endDate); 
		
		pageCnt = ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, PAGE_SIZE);
		if(pageNo > pageCnt) {
			pageNo = pageCnt;
			ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, PAGE_SIZE);
		}
	} else if(action.trim().equals("multiple")) {
		String[] strCategoryIds = request.getParameterValues("categoryid");
		keyword = request.getParameter("keyword");
		if(strCategoryIds == null || strCategoryIds.length == 0) {
			categoryArr = null;
		} else {
			categoryArr = new int[strCategoryIds.length];
			for(int i=0; i < categoryArr.length; i++) {
				categoryArr[i] = Integer.parseInt(strCategoryIds[i]);
				strAllIds += "&categoryid=" + strCategoryIds[i];
			}
			pageCnt = ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, null, null, pageNo, PAGE_SIZE);
			if(pageNo > pageCnt) {
				pageNo = pageCnt;
				ProductMgr.getInstance().searchProducts(products, categoryArr, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, null, null, pageNo, PAGE_SIZE);
			}
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
		
		
		<!-- deal with page selection from simple search -->
		<% 	if(action != null && action.equals("simple")) {%>
		<div align="center">
			<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
			<% if(pageNo != 1) { %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&categoryid=<%= categoryId %>&pageno=<%= pageNo-1 %>">上一页</a>
			<% } %>
			<% if(pageNo != pageCnt) {%>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&categoryid=<%= categoryId %>&pageno=<%= pageNo+1 %>">下一页</a>
			<% } %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&categoryid=<%= categoryId %>&pageno=<%= pageCnt %>">尾页</a>
		</div>

		<center>
		<form name="pageselect" action="ProductSearch.jsp" method="get">
			<input type="hidden" name="action" value="<%= action %>"/>
			<input type="hidden" name="keyword" value="<%= keyword %>"/>
			<input type="hidden" name="categoryid" value="<%= categoryId %>"/>
			<select name="pageno" onchange="document.pageselect.submit()">
			<% for(int i = 1; i <= pageCnt; i++) { %>
					<option value="<%= i %>" <%= (i == pageNo) ? "selected" : "" %>>第<%= i %>页</option>
			<% } %>
			</select>
		</form>
		</center>
		<% } %>
		
		
		<!-- deal with page selection from complex search -->		
		<% 	if(action != null && action.equals("complex")) {%>
		<div align="center">
			<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
			<% if(pageNo != 1) { %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&lownormalprice=<%= lowNormalPrice %>&highnormalprice=<%= highNormalPrice %>&lowmemberprice=<%= lowMemberPrice %>&highmemberprice=<%= highMemberPrice %>&startdate=<%= strStart %>&enddate=<%= strEnd %>&categoryid=<%= categoryId %>&pageno=<%= pageNo-1 %>">上一页</a>
			<% } %>
			<% if(pageNo != pageCnt) {%>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&lownormalprice=<%= lowNormalPrice %>&highnormalprice=<%= highNormalPrice %>&lowmemberprice=<%= lowMemberPrice %>&highmemberprice=<%= highMemberPrice %>&startdate=<%= strStart %>&enddate=<%= strEnd %>&categoryid=<%= categoryId %>&pageno=<%= pageNo+1 %>">下一页</a>
			<% } %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %>&lownormalprice=<%= lowNormalPrice %>&highnormalprice=<%= highNormalPrice %>&lowmemberprice=<%= lowMemberPrice %>&highmemberprice=<%= highMemberPrice %>&startdate=<%= strStart %>&enddate=<%= strEnd %>&categoryid=<%= categoryId %>&pageno=<%= pageCnt %>">尾页</a>
		</div>
		<center>
		<form name="pageselect" action="ProductSearch.jsp" method="get">
			<input type="hidden" name="action" value="<%= action %>"/>
			<input type="hidden" name="keyword" value="<%= keyword %>"/>
			<input type="hidden" name="lownormalprice" value="<%= lowNormalPrice %>"/>
			<input type="hidden" name="highnormalprice" value="<%= highNormalPrice %>"/>
			<input type="hidden" name="lowmemberprice" value="<%= lowMemberPrice %>"/>
			<input type="hidden" name="highmemberprice" value="<%= highMemberPrice %>"/>
			<input type="hidden" name="startdate" value="<%= strStart %>"/>
			<input type="hidden" name="enddate" value="<%= strEnd %>"/>
			<input type="hidden" name="categoryid" value="<%= categoryId %>"/>
			<select name="pageno" onchange="document.pageselect.submit()">
			<% for(int i = 1; i <= pageCnt; i++) { %>
					<option value="<%= i %>" <%= (i == pageNo) ? "selected" : "" %>>第<%= i %>页</option>
			<% } %>
			</select>
		</form>
		</center>
		<% } %>

		
		<!-- deal with page selection from multiple search -->
		<% 	if(action != null && action.equals("multiple")) {%>
		<div align="center">
			<font>共<%= pageCnt %>页  第<%= pageNo %>页</font>
			<% if(pageNo != 1) { %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageNo-1 %>">上一页</a>
			<% } %>
			<% if(pageNo != pageCnt) {%>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageNo+1 %>">下一页</a>
			<% } %>
			<a href="ProductSearch.jsp?action=<%= action %>&keyword=<%= keyword %><%= strAllIds %>&pageno=<%= pageCnt %>">尾页</a>
		</div>

		<center>
		<form name="pageselect" action="ProductSearch.jsp" method="get">
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
		<% } %>

			
			
			
<%
	return;
}
%>


<!-- Initial search page -->
<body>
	<center>简单搜索</center>
	<form name="simple" action="ProductSearch.jsp" method="get">
	<input type="hidden" name="action" value="simple"/>
	<table border="1" align="center">
		<tr>
			<td>选择类别</td>
			<td><select name="categoryid">
			<option value="0" selected>所有类别</option>
			<% for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) { 
				Category c = it.next();
				String preStr = "";
				for(int i = 1; i < c.getGrade(); i++) {
					preStr = "--" + preStr;
				}
			%>
				<option value="<%= c.getId() %>"><%= preStr + c.getName() %></option>
			<% } %>
			</select></td>
		</tr>
		<tr>
			<td>关键字</td>
			<td><input type="text" name="keyword" size="30" maxlength="30"></input></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="搜索"></input></td>
		</tr>
	</table>
	</form>
	
	<br><br>
	<center>多选搜索</center>
	<form name="multiple" action="ProductSearch.jsp" method="get">
	<input type="hidden" name="action" value="multiple"/>
	<table border="1" align="center">
		<tr>
			<td>选择类别</td>
			<td>
			<%
				for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
					Category c = it.next();
			%>
					<input type="checkbox" name="categoryid" value="<%= c.getId() %>"/><%= c.getName() %>
			<%
				}
			%>
			</td>
		</tr>
		<tr>
			<td>关键字</td>
			<td><input type="text" name="keyword" size="30" maxlength="30"></input></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="搜索"></input></td>
		</tr>
	</table>
	</form>
	
	<br><br>
	<center>高级搜索</center>
	<form name="complex" action="ProductSearch.jsp" method="post" onsubmit="checkdata()">
	<input type="hidden" name="action" value="complex"/>
	<table border="1" align="center">
		<tr>
			<td>选择类别</td>
			<td><select name="categoryid">
			<option value="0" selected>所有类别</option>
			<% 
			for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) { 
				Category c = it.next();
				String preStr = "";
				for(int i = 1; i < c.getGrade(); i++) {
					preStr = "--" + preStr;
				}
			%>
				<option value="<%= c.getId() %>"><%= preStr + c.getName() %></option>
			<% 
			}
			%>
			</select></td>
		</tr>
		<tr>
			<td>关键字</td>
			<td><input type="text" name="keyword" size="30" maxlength="30"></input></td>
		</tr>
		<tr>
			<td>市场价</td>
			<td><input type="text" name="lownormalprice" size="8" maxlength="10"/> ~ <input type="text" name="highnormalprice" size="8" maxlength="10"/></td>
		</tr>
		<tr>
			<td>会员价</td>
			<td><input type="text" name="lowmemberprice" size="8" maxlength="10"/> ~ <input type="text" name="highmemberprice" size="8" maxlength="10"/></td>
		</tr>
		<tr>
			<td>上市日期</td>
			<td><input type="text" name="startdate" size="8" maxlength="10"/> ~ <input type="text" name="enddate" size="8" maxlength="10"/></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="搜索"></input></td>
		</tr>
	</table>
	</form>
</body>
</html>