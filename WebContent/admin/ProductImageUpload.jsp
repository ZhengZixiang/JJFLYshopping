<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<% 
String strId = request.getParameter("id");
if(strId == null || strId.trim().equals("")) {
	out.println("您选择的商品有错！不允许上传！");
	return;
}
int id = Integer.parseInt(strId);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品图片上传ProductImageUpload</title>
</head>
<body>
   <form name="myform" action="<%= request.getContextPath() %>/FileUploadServlet" method="post" enctype="multipart/form-data">
   		<input type="hidden" name="id" value="<%= id %>"/>
   		<table border="1" align="center">
			<tr><th colspan="2">图片上传</th></tr>
			<tr>
       			<td>图片ID:</td>
       			<td><%= id %><br></td>
       		</tr>
       		<tr>
       			<td>描述:</td>
       			<td><input type="text" name="descr" size="15"/><br></td>
       		</tr>
       		<tr>
       			<td>文件:</td>
       			<td><input type="file" name="file"/></tr>
       		<tr>
       			<td colspan="2" align="center"><input type="submit" value="上传"></td>
       		</tr>
		</table>
    </form>
</body>
</html>