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
<title>产品搜索第二代ProductSearch2</title>
<script>
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
	if(action.trim().equals("simple")) {
%>
		<jsp:forward page="SimpleSearchHandler.jsp"></jsp:forward>
<%
	} else if (action.trim().equals("complex")){
%>
		<jsp:forward page="ComplexSearchHandler.jsp"></jsp:forward>
<%
	} else if(action.trim().equals("multiple")) {
%>
		<jsp:forward page="MultipleSearchHandler.jsp"></jsp:forward>
<%
	} 
}
%>


<body>
	<center style="font-size: 20px">第二代产品搜索引擎</center><br>
	<form name="simple" action="ProductSearch2.jsp" method="get">
	<input type="hidden" name="action" value="simple"/>
	<table border="1" align="center">
		<tr>
			<th colspan="2">简单搜索</th>
		</tr>
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
	
	<br>
	<form name="multiple" action="ProductSearch.jsp" method="get">
	<input type="hidden" name="action" value="multiple"/>
	<table border="1" align="center">
		<tr>
			<th colspan="2">多选搜索</th>
		</tr>
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
	
	<br>
	<form name="complex" action="ProductSearch.jsp" method="post" onsubmit="checkdata()">
	<input type="hidden" name="action" value="complex"/>
	<table border="1" align="center">
		<tr><th colspan="2">高级搜索</th></tr>
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