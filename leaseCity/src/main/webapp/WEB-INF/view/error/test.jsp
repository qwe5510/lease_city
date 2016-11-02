<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/main.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/sl-slide.css">

<c:url value="/images/credit/min_building.png" var="minBuilding"></c:url>
<c:url value="/images/credit/max_building.png" var="maxBuilding"></c:url>
<style>

div{
	display:inline-block;
	background: url("${minBuilding}") no-repeat;
	background-size: contain;
	text-align: left;
	vertical-align: middle;
	width: 75px;
	height: 15px;
}

i{
	display:block;
	background: url("${maxBuilding}") no-repeat;
	background-size: cover;
	width: 75px;
	height: 15px;
}

</style>
<body>

<div>
	<span id="test" class="credit_grade">
		<i style="width: 30%"></i>
	</span>
</div>

</body>
<script>
</script>
</html>