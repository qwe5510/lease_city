<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
			<c:url value="/lease_request_read" var="lease_request_read"></c:url>
			<sform:form action="#" method="post" modelAttribute="constructionCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table>
				<tr>
					<td><sform:label path="companyName">회사명</sform:label></td>
					<td><sform:label path="representName">대표자</sform:label></td>
				</tr>
				<tr>
					<td><sform:label path="companyCategory">회사분류</sform:label></td>
					<td><sform:label path="address">소재지</sform:label></td>
				</tr>
				<tr>
					<td><sform:label path="licenseList">자격증목록</sform:label></td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<sform:form id="lease_request_form" action="${lease_request_read }" method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대신청</legend>
			<table>
				<tr>
					<td><sform:label path="leaseCategory">공사업종</sform:label></td>
					<td><sform:label path="address">작업장소</sform:label></td>
				</tr>
				<tr>
					<td><sform:label path="equipmentCategory">필요차량</sform:label></td>
					<td><sform:label path="regDate">기간</sform:label></td>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
			</table>
			</fieldset>
			<br>
			<fieldset>
				<legend>참고사항</legend>
				<textarea></textarea>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_write"> <i class="icon-pencil"></i>작성</button>
				<button id="lease_write_cancel"><i class="icon-link"></i>취소</button>
			</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>