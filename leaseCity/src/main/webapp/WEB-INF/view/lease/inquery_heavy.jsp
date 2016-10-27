<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="lease">
	<div class="lease_menu">
	</div>
	<div class="lease_main">
	<br><br>
	<div class="heavy_select">
		<select name="heavy_category" id="heavy_category">
			<option value="aa">지역</option>
			<option value="bb">업체명</option>
			<option value="cc">신용도</option>
		</select>
	</div>
	<div class="heavy_search">
		<input id="heavy_search" type="text" placeholder="검색어를 입력해주세요."/>
	</div>
	<div class="heavy_button">
		<input type="button" value="검색">
	</div>
	<div>
	</div>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#heavy_category").on("click",function(){
		var selected1 = $("#heavy_category option:selected").val();
		if(selected1=="cc"){
			$(".heavy_search").html("<select><option>asd</option><option>asd</option><option>asd</option></select>");
		}else{
			$(".heavy_search").html("<input id='heavy_search' type='text' placeholder='검색어를 입력해주세요.'/>");
		}
	});
</script>
</html>