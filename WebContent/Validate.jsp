<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
    
<% 
String username = request.getParameter("username");
String msg;
if(UserManager.usernameExists(username)) {
	msg = "existent";
} else {
	msg = "notexistent";
}
response.setContentType("text/xml");
response.setHeader("Cache-control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
response.getWriter().write("<msg>" + msg + "</msg>");
%>    
