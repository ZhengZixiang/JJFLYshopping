<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="_sessionCheck.jsp" %>

<html>
	<script language="javascript">
		state = 0 ;
		menuState = 0;
		mainState = 0;
	</script>
	
	<link rel="stylesheet" type="text/css" href="script/index.css"/>
	<head>
		<title>JJFlyShopping后台管理平台</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	</head>
 	<frameset rows="29,*" border="0" cols="*">
  		<frame name="top" scrolling="NO" noresize src="top.html">
  	  	<frameset cols="20%,*"  border="0"  rows="*" scrolling="NO" name="mleft">
    		<frame src="menu.html" frameborder=NO border="0" scrolling="NO" >
     		<frameset rows="20,100%,*" name="content"  frameborder="1" framespacing="1" cols="*">
	     		<frame src="title.html"  frameborder="0" noresize scrolling="NO" name="mtitle">
				<frame src=""   frameborder="0" name="main" marginwidth="0" marginheight="0" scrolling="YES">
				<frame src=""   frameborder="0" name="detail">
	    	</frameset>
	  	</frameset>
	</frameset>
	
	<noframes>
	</noframes>
</html>