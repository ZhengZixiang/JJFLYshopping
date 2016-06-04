<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>

<%
int id = Integer.parseInt(request.getParameter("id"));
StringBuffer buf = new StringBuffer();
if(id == 0) {
	buf.append("<option value='-1' selected>查询所有二级目录</option>\n");
} else {
	Category parent = Category.loadById(id);
	List<Category> children = parent.getChildren();
	for(int i = 0; i < children.size(); i++) {
		Category c = children.get(i);
		buf.append("<option value='" + c.getId() + "'>" + c.getName() + "</option>\n");
	}
	buf.insert(0, "<option value='-1' selected>请选择二级目录</option>\n");
}

response.setContentType("");
response.setHeader("Cache-control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
response.getWriter().write(buf.toString());
%>
