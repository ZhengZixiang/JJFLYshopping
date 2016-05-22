var tipStyle = "<font color='red' size='1'/>";

function checkData() {
	
	if(!checkUsername()) {
		form.username.focus();
		return false;
	}
	if(!checkPassword()) {
		form.password.focus();
		return false;
	}
	if(!checkPhone()) {
		form.phone.focus();
		return false;
	}
	
	return true;
}

function strlen(str) {
	var len;
	var i;
	len = 0;
	for (i=0; i<str.length; i++){
		if (str.charCodeAt(i) > 255) len+=2; 
		else len++;
	}
	return len;
}


function isIllegal(str) {
	var len;
	var i;
	len = 0;
	for (i=0; i<str.length; i++){
		if (str.charCodeAt(i) > 255) return true;
	}
	return false;
}

function whiteSpace(s) {
	var whitespace = " \t\n\r";
	var i;
	for (i = 0; i < s.length; i++){
		var c = s.charAt(i);
		if (whitespace.indexOf(c) >= 0) {
		  	return true;
		}
	}
	return false;
}

function isSsnString(ssn) {
	var re=/^[0-9a-z][\w-_.]*[0-9a-z]$/i;
	if(re.test(ssn))
		return true;
	else
		return false;

}

function checkSsn(gotoURL) {
	var ssn=form.username.value.toLowerCase();
	if (checkUserName(ssn)){
		var open_url = gotoURL + "?username=" + ssn;
		window.open(open_url,'','status=0,directories=0,resizable=0,toolbar=0,location=0,scrollbars=0,width=322,height=200');
	}
}

function checkUsername() {
	
	var ssn = form.username.value.toLowerCase();
	
	if(ssn == "") {
		document.getElementById("unErr").innerHTML = tipStyle + "\*请输入用户名！";
		form.username.focus();
		return false;
	}
	if(ssn.length < 3 || ssn.length > 20) {
		document.getElementById("unErr").innerHTML = tipStyle + "\*请正确输入用户名，用户名长度为3-20位！";
		form.username.focus();
		return false;
	}
	if(whiteSpace(ssn)) {
		document.getElementById("unErr").innerHTML = tipStyle + "\*请正确输入用户名，用户名中不能有空格！";
		form.username.focus();
		return false;
	}
	if(!isSsnString(ssn)) {
		document.getElementById("unErr").innerHTML = tipStyle + "\*用户名不正确！用户名由a-z、0-9、.、-或下划线组成，以数字或字母开头结尾，不区分大小写！";
		form.username.focus();
		return false;
	}
	
	document.getElementById("unErr").innerHTML = "";
	return true;
}

function checkPhone() {
	phoneNum = form.phone.value;
	if(phoneNum == "") {
		document.getElementById("phoneErr").innerHTML = tipStyle + "\*请输入电话！";
		form.phone.focus();
		return false;
	}
	
	for(var i = 0; i < phoneNum.length; ++i) {
		if(phoneNum[i] < '0' || phoneNum[i] > '9') {
			document.getElementById("phoneErr").innerHTML = tipStyle + "\*请输入纯数字！";
			form.phone.focus();
			return false;
		}
	}
	
	document.getElementById("phoneErr").innerHTML="";
	return true;
}


function checkPassword() {
	
	if(form.username.value == "") {
		document.getElementById("unErr").innerHTML = tipStyle + "\*请先输入用户名！";
		form.username.focus();
		return false;
	}
	
	if(form.password.value == "") {
		document.getElementById("passwordErr").innerHTML = tipStyle + "\*请输入密码！";
		form.password.focus();
		return false;
	}
	
	if(strlen(form.password.value)<6 || strlen(form.password.value)>16) {
		document.getElementById("passwordErr").innerHTML = tipStyle + "\*请正确输入密码，长度为6-16位！仅可用英文、数字、特殊字符！";
		form.password.focus();
		return false;
	}
	
	if(isIllegal(form.password.value)) {
		document.getElementById("passwordErr").innerHTML = tipStyle + "\*您的密码中包含了非法字符！仅可用英文、数字、特殊字符！";
		form.password.focus();
		return false;
	}
	
	if(form.password.value == form.username.value) {
		document.getElementById("passwordErr").innerHTML = tipStyle + "\*用户名和密码不能相同！";
		form.password.focus();
		return false;
	}
	
	document.getElementById("passwordErr").innerHTML = "";
	
	if(form.password2.value == "") {
		document.getElementById("passwordErr2").innerHTML = tipStyle + "\*请输入确认密码！";
		form.password2.focus();
		return false;
	}
	
	if(form.password2.value != form.password.value) {
		document.getElementById("passwordErr2").innerHTML = tipStyle + "\*两次密码输入不一致！";
		form.password2.focus();
		return false;
	}
	
	document.getElementById("passwordErr2").innerHTML = "";
	
	return true;
}
