<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ include file="_sessionCheck.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除商品ProductDelete</title>
</head>
<body>
<%
int id = Integer.parseInt(request.getParameter("id"));
int [] idArray = new int [1];
idArray[0] = id;
if (ProductMgr.getInstance().deleteProductsById(idArray)) {
	out.println("<center>删除商品成功！</center>");
} else {
	out.println("<center>删除商品失败！</center>");
}
%>	
</body>
</html>