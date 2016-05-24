<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>

<%  
request.setCharacterEncoding("UTF-8");
int id;
try {
	id = Integer.parseInt(request.getParameter("id"));
} catch(NumberFormatException e) {
	out.println("产品信息发生错误！");
	return;
}
Product p = ProductMgr.getInstance().loadById(id);

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品信息ProductDetailShow</title>
</head>
<body>
	<form name="form" action="UserModify.jsp" method="post" onsubmit="return checkData()">
		<input type="hidden" name="action" value="modify"/>
		<table width="750" align="center" border="2">
			<tr>
				<th colspan="2" align="center">产品信息</th>
			</tr>

			<tr>
				<td>产品名称：</td>
				<td><%= p.getName() %></td>
			</tr>
			
			<tr>
				<td>产品描述：</td>
				<td><%= p.getDescr() %></td>
			</tr>

			<tr>
				<td>市场价：</td>
				<td><%= p.getNormalPrice() %></td>
			</tr>
			
			<tr>
				<td>市场价：</td>
				<td><%= p.getMemberPrice() %></td>
			</tr>
		</table>
		
		<div align="center">
			<a href="Buy.jsp?id=<%= p.getId() %>" >购买</a>
		</div>
	</form>
	<script type="text/javascript" src="Script/regcheckdata.js"></script>
</body>
</html>