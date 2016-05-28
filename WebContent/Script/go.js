/**
 * 
 */
var leftTime = 3000;
var operation;
function go(action) {
	leftTime -= 1000;
	
	if(action == "update")	operation = "修改成功！" + leftTime/1000 + "秒后返回购物车！";
	if(action == "order") 	operation = "订单提交成功！" + leftTime/1000 + "秒后返回购物车！";
	if(action == "register")operation = "注册成功！" + leftTime/1000 + "秒后返回首页！";
	
	document.getElementById("timeleft").innerText = operation;
	
	if(leftTime <= 0) {
		if(action == "update")	document.location.href="Cart.jsp";
		if(action == "order")	document.location.href="Cart.jsp";
		if(action == "register") document.location.href="index.jsp";
	}
}