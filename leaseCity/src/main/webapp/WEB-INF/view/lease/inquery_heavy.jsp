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
	<br><br><br>
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
		<c:url value="/heavy_request" var="heavy_request"></c:url>
		<sform:form id="heavy_form" method="post" modelAttribute="heavyEquipmentCompany" action="${heavy_request }">
		<table class="heavy_table">
			<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
			<tr>
				<td>
					<sform:label path="creditGrade">신용도</sform:label>
				</td>
				<td>
					<sform:label path="companyName">업체명</sform:label>
				</td>
				<td>
					<sform:label path="representName">대표자</sform:label>
				</td>
				<td>
					<sform:label path="address">지역</sform:label>
				</td>
				<td>
					<sform:label path="heavyEquipmentList">사용가능차량</sform:label>
				</td>
				<td>
					<label>작업완료횟수</label>
				</td>
			</tr>
			<tr>
				<td colspan="6" class="boardLine"></td>
			</tr>
			<tr>
				<td>
					<span>*****</span>
				</td>
				<td>
					<span>대한건설</span>
				</td>
				<td>
					<span>장필식</span>
				</td>
				<td>
					<span>안양</span>
				</td>
				<td>
					<span>펌프카외 3종</span>
				</td>
				<td>
					<span>10건</span>
				</td>
			</tr>
		</table>
		</sform:form>
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
	$("span").on("click",function(){
		$("#heavy_form").submit();
	});
</script>
</html>