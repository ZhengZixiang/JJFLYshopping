<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
int id = Integer.parseInt(request.getParameter("id"));
Product p = ProductMgr.getInstance().loadById(id);
List<Category> categories = Category.getCategories();

String action = request.getParameter("action");
if(action != null && action.trim().equals("modify")) {
	String name = request.getParameter("name");
	String descr = request.getParameter("descr");
	double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
	double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
	int categoryId  = Integer.parseInt(request.getParameter("categoryid"));
	
	Category c = Category.loadById(categoryId);
	if(!c.isLeaf()) {
		out.println("非子类下不得添加新产品！");
		return;
	}
	
	p.setName(name);
	p.setDescr(descr);
	p.setNormalPrice(normalPrice);
	p.setMemberPrice(memberPrice);
	p.setCategoryId(categoryId);
	boolean successful = ProductMgr.getInstance().updateProduct(p);
	if(successful) {
%>
		<script type="text/javascript">
			alert("修改成功！");
			window.location.replace("ProductList.jsp");
		</script>
<%
	} else {
%>
		<script type="text/javascript">
			alert("修改失败！请再次检查所填信息！");
		</script>
<%
	}
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品修改ProductModify</title>
<script type="text/javascript">
var arrLeaf = new Array();
function checkcategory() {
	if(arrLeaf[document.form.categoryid.selectedIndex] == "leaf") {
		return true;	
	} else {
		alert("不能在子类下添加新产品！");
		document.form.category.focus();
		return false;
	}
}
</script>
</head>
<body>
	<form action="ProductModify.jsp" method="post" onsubmit="return checkcategory()">
		<input type="hidden" name="action" value="modify" />
		<input type="hidden" name="id" value="<%= id %>">
		<table align="center" border="1">
		<tr>
			<td>产品名称：</td>
			<td><input type="text" name="name" size="30" maxlength="30" value="<%= p.getName() %>"></td>
		</tr>
		<tr>
			<td>产品描述：</td>
			<td><textarea rows="5" cols="80" name="descr"><%= p.getDescr() %></textarea></td>
		</tr>
		<tr>
			<td>市场价：</td>
			<td><input type="text" name="normalprice" size="30" maxlength="30" value="<%= p.getNormalPrice() %>"></td>
		</tr>
		<tr>
			<td>会员价：</td>
			<td><input type="text" name="memberprice" size="30" maxlength="30" value="<%= p.getMemberPrice() %>"></td>
		</tr>
		<tr>
			<td>产品类别：</td>
			<td><select name="categoryid">
				<option value="0">所有类别</option>
				<script type="text/javascript">
					arrLeaf[0] = "notleaf";
				</script>
				<% 
				int index = 1;
				for(Iterator<Category> it = categories.iterator(); it.hasNext(); ) {
					Category c = it.next();
					String preStr = "";
					for(int i = 1; i < c.getGrade(); i++) {
						preStr = "--" + preStr;
					}
				%>

					<option value="<%= c.getId() %>" <%= p.getCategoryId() == c.getId()?"selected" : "" %> > <%= preStr + c.getName() %></option>
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
				<input type="submit" value="修改"></input>
				<input type="reset" value="重置"></input>
			</td>
		</tr>
		</table>
	</form>
</body>
</html>