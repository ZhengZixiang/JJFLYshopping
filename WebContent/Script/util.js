var request;
function changeCategory() {
	var id = document.cform.category1.options[document.cform.category1.selectedIndex].value;
	var url = "ChangeCategory.jsp?id=" + escape(id);
	if(window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if(window.ActiveXObject) {
		request = new ActiveXObject("Microsoft XMLHTTP");
	}
	request.open("GET", url, true);
	request.onreadystatechange = callback;
	request.send(null);
}

function callback() {
	if(request.readyState == 4) {
		if(request.status == 200) {
			document.cform.category2.innerHTML = request.responseText;
		} else {
			alert("服务器出现了点小问题，正在玩命修复中！");
		}
	}	
}