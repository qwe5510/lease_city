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
			<sform:form action="#" method="post" modelAttribute="ConstructionCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
				<tr>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<sform:form id="lease_request_form" action="${lease_request_read }" method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대신청</legend>
			<table>
				<tr>
				</tr>
				<tr>
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