<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>    


<%--
Cart cart = (Cart) session.getAttribute("cart");
if(cart == null) {
	cart = new Cart();
	session.setAttribute("cart", cart);
}
--%>

<jsp:useBean id="cart" class="me.zzx.shopping.Cart" scope="session"></jsp:useBean>

<%
request.setCharacterEncoding("UTF-8");
int id = Integer.parseInt(request.getParameter("id"));
Product p = ProductMgr.getInstance().loadById(id);
CartItem ci = new CartItem();
ci.setProductId(id);
ci.setPrice(p.getNormalPrice());//check user whether logged in 
ci.setCount(1); 
cart.add(ci);
response.sendRedirect("Cart.jsp");
%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购买Buy</title>
</head>
<body>

</body>
</html>