<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>임대 양도 | LEASE CITY</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/main.css">

<c:url value="/index" var="index"></c:url>

<c:choose>
	<c:when test="${!empty exitSign and exitSign == 'Error'}">
		<script>
			alert("로그인 세션이 만료되었습니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
	<c:when test="${!empty exitSign and exitSign == 'NotFoundDataError'}">
		<script>
			alert("요청한 데이터를 찾을 수 없습니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
	<c:when test="${!empty exitSign and exitSign == 'ServiceError'}">
		<script>
			alert("존재하지 않는 차량번호가 존재합니다. \\n 해당 양도메세지는 자동으로 삭제됩니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
	<c:when test="${!empty exitSign and exitSign == 'RemoveError'}">
		<script>
			alert("데이터 삭제 도중 에러가 발생하였습니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
	<c:when test="${!empty exitSign and exitSign == 'WriteError'}">
		<script>
			alert("데이터 기록 도중 에러가 발생하였습니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
	<c:when test="${!empty exitSign and exitSign == 'ChangeValueFailError'}">
		<script>
			alert("데이터 값의 조작 도중 에러가 발생하였습니다.")
			window.opener.document.location.href = "${index}";
			window.close();
		</script>
	</c:when>
</c:choose>

<c:if test="${!empty exitSign and exitSign == 'permission'}">
	<script>
	alert("양도 요청을 수락하였습니다.")
	window.opener.document.location.href = window.opener.document.URL;
	window.close();
	</script>
</c:if>

<c:if test="${!empty exitSign and exitSign == 'rejection'}">
	<script>
	alert("양도 요청을 거절하였습니다.")
	window.opener.document.location.href = window.opener.document.URL;
	window.close();
	</script>
</c:if>

<c:if test="${!empty transfer_message}">
	<script>
	alert("${transfer_message}");
	window.close();
	</script>
</c:if>

</head>
<body>
	<div class="leaseTransferArea">
		<fieldset>
			<legend style="font-size: 2em">임대 양도 정보</legend>
			<table style="width: 100%">
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">중장비 종류</th>
					<td width="150px" style="padding-left: 25px; font-size: 1.4em;">${leaseTransfer.equipmentCategory}</td>
				</tr>
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">신청 업체명</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${leaseTransfer.sendCompanyName}</td>
				</tr>
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">양도 하는 차량 (상대차량)</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${leaseTransfer.sendIdNumber}</td>
				</tr>
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">양도 받을 차량 (본인차량)</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${leaseTransfer.acceptIdNumber}</td>
				</tr>
				<fmt:formatDate value="${leaseTransfer.fromDate}" pattern="yyyy-MM-dd" var="fromDate" />
				<fmt:formatDate value="${leaseTransfer.toDate}" pattern="yyyy-MM-dd" var="toDate" />
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">시작 날짜</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${fromDate}</td>
				</tr>
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">종료 날짜</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${toDate}</td>
				</tr>
				<tr align="center">
					<th width="100px" style="font-size: 1.2em">제시 가격</th>
					<td style="padding-left: 25px; font-size: 1.4em;">${price}</td>
				</tr>
			</table>
		</fieldset>
		<br>
		<fieldset>
			<legend style="font-size: 2em">양도 내용</legend>
				${leaseTransfer.content}
		</fieldset>
		
		<c:url value="/workManagement/transfer/permission" var="transferPermission"></c:url>
		<c:url value="/workManagement/transfer/rejection" var="transferRejection"></c:url>
		<form id="transferForm" method="post" action="${transferPermission}">
			<button id="permissionBtn" class="transferBtn">수락</button>
			<button id="rejectionBtn" class="transferBtn">거절</button>
			<input type="hidden" name="leaseTransferNo" value="${leaseTransfer.leaseTransferNo}" />
		</form>
		
	</div>
</body>

<script src="http://code.jquery.com/jquery.js"></script>
<script>

$("#rejectionBtn").on("click", function(){
	$("#transferForm").attr("action", "${transferRejection}");
})

</script>
</html>