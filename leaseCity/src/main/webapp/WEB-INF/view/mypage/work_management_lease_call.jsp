<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업 관리 | LEASE CITY</title>

<c:if test="${!empty leaseCall_message}">
	<script>
		alert("${leaseCall_message}");
	</script>
</c:if>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="selection">
	<div class="selection_main">
	
		<fmt:formatDate value="${leaseCall.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
		<fmt:formatDate value="${leaseCall.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
	
		<fieldset style="display: inline-block; margin-bottom: 30px;">
			<legend>요청글 정보</legend>
			<table class="leaseCallCheckTable" style="font-size: 1.2em;">
			<tr>
				<th>요청글 제목</th>
				<td>${leaseCall.leaseCommentTitle}</td>
			</tr>
			<tr>
				<th>작업 장소</th>
				<td>${leaseCall.address}</td>
			</tr>
			<tr>
				<th>임대 작업 분류</th>
				<td>${leaseCall.leaseCategory}</td>
			</tr>
			<tr>
				<th>필요 차량 종류</th>
				<td>${leaseCall.equipmentCategory}</td>
			</tr>
			<tr>
				<th>작업 기한</th>
				<td><strong>${fromDate}</strong>부터 <strong>${toDate}</strong>>까지</td>
			</tr>
			<tr>
				<th>지급 금액</th>
				<td><strong>${leaseCall.fromPrice}</strong> ~ <strong>${leaseCall.toPrice}</strong>만원(단위)</td>
			</tr>
			</table>
		</fieldset>
		
		<fieldset style="display: inline-block; margin-bottom: 30px;">
			<legend>선발 중기업체 목록</legend>
			<table class="leaseCallCheckTable">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr>
					<th>업체명</th>
					<th>대표자명</th>
					<th>차량</th>
					<th>기간</th>
					<th>금액(만원)</th>
					<th>선발 날짜</th>
				</tr>
				
				<c:forEach var="leaseRequest" items="${choiceRequests}">
				<fmt:formatDate value="${leaseRequest.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
				<fmt:formatDate value="${leaseRequest.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
				<fmt:formatDate value="${leaseRequest.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
				<tr>
					<td colspan="6" class="boardLine"></td>
				</tr>
				<tr>
					<th>${leaseRequest.companyName}</a></th>
					<th>${leaseRequest.representName}</a></th>
					<th>${leaseRequest.equipmentCategory} ${leaseRequest.idNumber}</th>
					<th>${fromDate} ~ ${toDate}</th>
					<th>${leaseRequest.price}</th>
					<th>${regDate}</th>
				</tr>
				</c:forEach>
				<c:if test="${!empty choiceErrorMsg}">
					<tr>
						<td colspan="6" class="boardLine"></td>
					</tr>
					<tr>
						<td colspan="6">${choiceErrorMsg}</td>
					</tr>
				</c:if>
			</table>
		</fieldset>
		<fieldset style="display: inline-block;">
			<legend>대기 중기업체 목록</legend>
			<table class="leaseCallCheckTable">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr>
					<th>업체명</th>
					<th>대표자명</th>
					<th>차량</th>
					<th>기간</th>
					<th>금액(만원)</th>
					<th>비고</th>
				</tr>
				
				<c:forEach var="leaseRequest" items="${standByRequests}">
				<fmt:formatDate value="${leaseRequest.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
				<fmt:formatDate value="${leaseRequest.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
				<tr>
					<td colspan="6" class="boardLine"></td>
				</tr>
				<tr>
					<th>${leaseRequest.companyName}</th>
					<th>${leaseRequest.representName}</th>
					<th>${leaseRequest.equipmentCategory} ${leaseRequest.idNumber}</th>
					<th>${fromDate} ~ ${toDate}</th>
					<th>${leaseRequest.price}</th>
					<th>
						<input type="hidden" value="${leaseRequest.leaseRequestNo}" >
						<a data-toggle="modal" data-backdrop="static" data-keyboard="false" class="label" href="#requestView" >
						내용 보기
						</a>
					</th>
				</tr>

				<!-- Modal Form Top -->
				<div class="modal hide fade in" id="requestView">
				<i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i>
					<!--Modal Body-->
					<div style="font-size: 1.5em;">
						<h4 style="color:black;">다음 임대 신청을 선발 하시겠습니까?</h4>
						<span>업체명 : </span>					
						<span>${leaseRequest.companyName}</span><br>
						<span>대표자명 : </span>
						<span>${leaseRequest.representName}</span><br>
						<span>차량 : </span>
						<span>${leaseRequest.equipmentCategory} ${leaseRequest.idNumber}</span><br>
						<span>기간 : </span>
						<span>${fromDate} ~ ${toDate}</span><br>
						<span>금액 : </span>
						<span>${leaseRequest.price} (만원)</span><br>
					</div>
					<c:url value="/workManagement/leaseCall/choice"	var="leaseCallChoice"></c:url>
					<form class="form-inline" method="post"	action="${leaseCallChoice}">
							<button id="requestChoice" class="leaseCallBtn viewBtn">선발</button>
							<button id="requestReject" class="leaseCallBtn viewBtn">거절</button>
							<input type="hidden" name="leaseRequestNo" value="${leaseRequest.leaseRequestNo}">
							<input type="hidden" name="leaseCallNo" value="${leaseRequest.leaseCallNo}">
					</form>
				</div>
				<!-- Modal Form Bottom -->

				</c:forEach>
				
				<c:if test="${!empty standByErrorMsg}">
					<tr>
						<td colspan="6" class="boardLine"></td>
					</tr>
					<tr>
						<td colspan="6">${standByErrorMsg}</td>
					</tr>
				</c:if>
			</table>
		</fieldset>
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

<c:url value="/workManagement/leaseCall/reject"	var="leaseCallRejection"></c:url>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
$("#requestReject").on("click", function(e){
	$(".form-inline").attr("action", "${leaseCallRejection}");
})

</script>
</html>