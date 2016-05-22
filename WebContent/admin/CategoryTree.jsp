<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>类别树状表CategoryTree</title>
<link rel="StyleSheet" href="tree/dtree.css" type="text/css" />
<script type="text/javascript" src="tree/dtree.js"></script>

<% List<Category> categories = Category.getCategories();  %>
</head>
<body>
<div class="dtree">

	<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>

	<script type="text/javascript">
		<!--

		d = new dTree('d');
		
		d.add(0, -1, '所有类别');
		<%
		for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
			Category c = it.next();
		%>
		d.add(<%= c.getId() %>, <%= c.getPid()%>, '<%= c.getName() %>', 'CategoryAdd.jsp?pid=<%= c.getPid()%>', '添加子类');
		<%
		}
		%>

		document.write(d);
		
		d.getSelected().id;
		
		addListener("click", "t");

		//-->
	</script>

</div>
</body>
</html>