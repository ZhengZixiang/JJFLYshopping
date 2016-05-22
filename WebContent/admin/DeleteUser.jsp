<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>

<%@ include file="_sessionCheck.jsp" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	UserManager.deleteUser(id);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DeleteUserPage</title>
</head>
<body>
	删除成功！
	<script type="text/javascript">
		<!--
		window.parent.main.document.location.reload();
		-->
	</script>
</body>
</html>