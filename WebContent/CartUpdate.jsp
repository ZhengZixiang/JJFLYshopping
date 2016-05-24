<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>

<%
request.setCharacterEncoding("UTF-8");

Cart cart = (Cart) session.getAttribute("cart");
List<CartItem> items = cart.getItems();
for(Iterator<CartItem> it = items.iterator(); it.hasNext(); ) {
	CartItem ci = it.next();
	String strCount = request.getParameter("p" + ci.getProductId());
	if(strCount != null || !strCount.trim().equals("")) {
		try {
			ci.setCount(Integer.parseInt(strCount));
		} catch(NumberFormatException e) {
			return;
		}
	}
}
%>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>购物车刷新CartUpdate</title>

<script type="text/javascript">
	var leftTime = 3000;
	function go() {
		leftTime -= 1000;
		document.getElementById("timeleft").innerText = "修改成功！" + leftTime/1000 + "秒后返回购物车！";
		if(leftTime <= 0) {
			document.location.href="Cart.jsp";
		}
	}
</script>

</head>
<body>
	<div id="timeleft" align="center">修改成功！3秒后返回购物车！</div>
	<center>若没有成功，请手动点击<a href='Cart.jsp'>回到购物车</a></center>
	<script type="text/javascript">
		//3秒后调用一次go
		//setTimeout(go, 3000);
		//每隔1秒调用一次go
		setInterval(go, 1000);
	</script>
	
</body>
</html>