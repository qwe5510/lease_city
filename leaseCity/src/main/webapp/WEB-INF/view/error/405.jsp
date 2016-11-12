<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/bootstrap.min.css">

<style>
body {
	background: url(<%=request.getContextPath()%>/images/405.png) no-repeat center top;
	vertical-align: middle;
	padding-top: 450px;
}

.label{
	position:relative;
	left: 47%;
	border: solid 5px black;
	border-radius: 20px/30%;
}
</style>
<title>405 ERROR | LEASE CITY</title>
</head>
<body>

<span class="label" style="padding: 20px; background-color: #f5db12;">
<a style="font-size: 2em;" href="<%=request.getContextPath()%>/index">
메인화면으로 이동</a></span>

</body>
</html>