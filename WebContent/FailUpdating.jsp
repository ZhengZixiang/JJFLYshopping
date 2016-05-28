<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="me.zzx.shopping.*" %>
<%@ page import="java.util.*" %>
 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刷新失败FailUpdating</title>

<script type="text/javascript">
	var leftTime = 3000;
	function go() {
		leftTime -= 1000;
		document.getElementById("timeleft").innerText = "修改失败！" + leftTime/1000 + "秒后返回购物车！";
		if(leftTime <= 0) {
			document.location.href="Cart.jsp";
		}
	}
</script>

</head>
<body>
	<div id="timeleft" align="center">修改失败！3秒后返回购物车！</div>
	<center>若没有跳转，请手动点击<a href='Cart.jsp'>回到购物车</a></center>
	<script type="text/javascript">
		setInterval(go, 1000);
	</script>
	
</body>
</html>