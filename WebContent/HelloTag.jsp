<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/hellotaglib" prefix="mytag"%>
<%@ taglib uri="/producttaglib" prefix="product"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HelloTag</title>
</head>
<body>
<mytag:hellotag/>
<product:list/>
</body>
</html>