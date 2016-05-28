<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
int id = Integer.parseInt(request.getParameter("id"));
SalesOrder so = OrderMgr.getInstance().loadById(id);
String action = request.getParameter("action");
if(action != null && action.equals("modify")) {
	int status = Integer.parseInt(request.getParameter("status"));
	so.setStatus(status);
	so.updateStatus();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单修改OrderModify</title>
</head>
<body>
	<form name="form" method="get" action="OrderModify.jsp">
		<input type="hidden" name="action" value="modify"/>
		<input type="hidden" name="id" value="<%= id %>"/>
		<table align="center" border="1">
			<tr>
				<th colspan="2">订单修改</th>
			</tr>
			<tr>
				<td>订单ID</td>
				<td><%= so.getId() %></td>
			</tr>
			<tr>
				<td>订单状态</td>
				<td>
				<select name="status">
					<option value="0">未处理</option>
					<option value="1">已处理</option>
					<option value="2">废单</option>
				</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="确定"/>
				</td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
	<!--
		for(var i = 0; option = document.getElementsByTagName("option")[i]; i++) {
				if(option.getAttribute("value") == <%= so.getStatus() %>) {
					option.setAttribute("selected", true); 
				}
		}
	-->
	</script>
</body>
</html>