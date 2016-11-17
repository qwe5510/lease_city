<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="leasecity.dto.user.*"%>
<!DOCTYPE html>
<html>
<head>
<title>관리 페이지 | LEASE CITY</title>

<c:if test="${!empty ctrl_message }">
	<script>
		alert('${ctrl_message}');
	</script>
</c:if>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="admininfo">
		<div class="admininfo_inner">
			<h3>가입 요청 대기자 명단</h3>
			<table class="stanByUserList" style="width: 100%">
				<tr align="center">
					<th>업체명</th>
					<th>대표자명</th>
					<th>이메일명</th>
					<th>승인 여부</th>
				</tr>

				<c:forEach var="standByUser" items="${standByUsers}">
					<tr>
						<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					<tr>
						<td>${standByUser.companyName}</td>
						<td>${standByUser.representName}</td>
						<td>${standByUser.email}</td>
						<td>
							<c:url value="/ctrlpage/permission" var="permission"></c:url>
							<c:url value="/ctrlpage/rejection" var="rejection"></c:url>
							<form id="STBForm" action="${permission}" method="post" style="margin:0px !important;">								<button id="userPermission" class="label">수락</button>
								<button id="userRejection" class="label">거절</button>
								<input type="hidden" name="companyName" value="${standByUser.companyName}">
								<input type="hidden" name="representName" value="${standByUser.representName}">
								<input type="hidden" name="email" value="${standByUser.email}">
							</form>
						</td>
					</tr>
				</c:forEach>
				
				<c:if test="${!empty standByUserErrorMsg}">
				<tr>
					<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr>
					<td colspan="4">${standByUserErrorMsg}</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div>
	<!--Bottom-->
	<section id="bottom" class="main">
		<!--Container-->
		<div class="container">

			<!--row-fluids-->
			<div class="row-fluid">

				<!--Contact Form-->
				<div class="span3">
					<ul class="unstyled address">
						<li><img
							src="<%=request.getContextPath()%>/images/logo/logo2.png" /></li>
					</ul>
				</div>
				<!--End Contact Form-->

				<!--Important Links-->
				<div id="tweets" class="span3">
					<h4>CopyRighter</h4>
					<div>
						<ul class="arrow">
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
						</ul>
					</div>
				</div>
				<!--Important Links-->

				<!--Archives-->
				<div id="archives" class="span3">
					<h4>Our Company's</h4>
					<div>
						<ul class="arrow">
							<li>construction company's</li>
							<li>heavy equipment company's</li>
						</ul>
					</div>
				</div>
				<!--End Archives-->

				<div class="span3">
					<h4>Building</h4>
					<div class="row-fluid first">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build1.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build2.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build3.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build4.png"
								alt="" /></li>
						</ul>
					</div>
					<div class="row-fluid">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build5.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build6.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build7.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build8.png"
								alt="" /></li>
						</ul>
					</div>
				</div>
			</div>
			<!--/row-fluid-->
		</div>
		<!--/container-->

	</section>
	<!--/bottom-->
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

$("#userRejection").on("click", function(){
	$("#STBForm").attr("action", "${rejection}");
});

</script>
</html>