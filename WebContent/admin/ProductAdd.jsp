<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	List<Category> categories = Category.getCategories();
	String action = request.getParameter("action");
	if(action != null && action.trim().equals("add")) {
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
		double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));
//System.out.println(request.getParameter("categoryid"));
/* 		if(categoryId == 0) {
			out.println("非叶子结点下不能添加产品");
			return;
		}
		Category c = Category.loadById(categoryId);
		if(!c.isLeaf()) { 
			out.println("非叶子结点下不能添加产品");
			return;
		} */
		
		Product p = new Product();
		p.setName(name);
		p.setDescr(descr);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		p.setPdate(new Timestamp(System.currentTimeMillis()));
		p.setCategoryId(categoryId);
		ProductMgr.getInstance().addProduct(p);
		
		out.println("Congratulation! Product Add Successfully!");
		return;
	}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品添加ProductAdd</title>

<script type="text/javascript">
	var arrLeaf = new Array();
	<!--
	function checkcategory() {
		if(arrLeaf[document.form.categoryid.selectedIndex] == "leaf") {
			return true;	
		} else {
			alert("不能在子类下添加新产品！");
			document.form.category.focus();
			return false;
		}
	}
	-->
</script>

</head>
<body>
	<center>产品添加</center>
	<form action="ProductAdd.jsp" method="post" name="form" onsubmit="return checkcategory()">
		<input type="hidden" name="action" value="add" />
		<table align="center" border="1">
		<tr>
			<td>产品名称：</td>
			<td><input type="text" name="name" size="30" maxlength="30"></td>
		</tr>
		<tr>
			<td>产品描述：</td>
			<td><textarea rows="5" cols="80" name="descr"></textarea></td>
		</tr>
		<tr>
			<td>市场价：</td>
			<td><input type="text" name="normalprice" size="30" maxlength="30"></td>
		</tr>
		<tr>
			<td>会员价：</td>
			<td><input type="text" name="memberprice" size="30" maxlength="30"></td>
		</tr>
		<tr>
			<td>产品类别：</td>
			<td><select name="categoryid">
				<option value="0">所有类别</option>
				<script type="text/javascript">
					arrLeaf[0] = "notleaf";
				</script>
				
				<% 
				int cId;
				int index = 1;
				try {
					cId = Integer.parseInt(request.getParameter("categoryid"));
				} catch (NumberFormatException e) {
					cId = -1;
				}
				for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
					Category c = it.next();
					String preStr = "";
					for(int i = 1; i < c.getGrade(); i++) {
						preStr = "--" + preStr;
					}
				%>

					<option value="<%= c.getId() %>" <%= cId == c.getId()?"selected" : "" %> > <%= preStr + c.getName() %></option>
					<script type="text/javascript">
						arrLeaf[<%= index %>] = <%= c.isLeaf() %>?"leaf":"notleaf";
					</script>
					
				<%
					index++;
				}
				%>
			</select></td>
		</tr>
		<tr>
			<td colspan = 2>
				<input type="submit" value="提交"></input>
				<input type="reset" value="重置"></input>
			</td>
		</tr>
		</table>
	</form>
</body>
</html>