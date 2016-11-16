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
	<div class="selection">
	<div class="selection_menu">
	</div>
	<div class="selection_main">
		<fieldset>
			<legend>기업개요</legend>
			<table class="lease_request_table">
				<tr>
					<td class="lease_label"><label>회사명</label>
						<span>${heavyEquipmentCompany.companyName}</span>
					</td>
					<td class="lease_label"><label>대표자</label>
						<span>${heavyEquipmentCompany.representName}</span>
					</td>
					<td class="lease_label">
						<label >대표연락처</label>
						<span>${heavyEquipmentCompany.representPhone}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label"><label >소재지</label>
						<span>${heavyEquipmentCompany.address}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label">
					<label >중장비 목록</label>						
					</td>
				</tr>
				<tr>
					<td colspan="3" style="padding: 0px; margin: 0px;">
						<table border="1" style="width: 100%">
							<tr>
								<th>차량 분류</th>
								<th>차량 번호</th>
								<th>사용 여부</th>
							</tr>
							<c:forEach var="heavyEquipment" items="${heavyEquipmentCompany.heavyEquipmentList}">
							<tr>
								<td>${heavyEquipment.equipmentCategory}</td>
								<td>${heavyEquipment.idNumber}</td>
								<td>${heavyEquipment.usedYesNo}</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			</fieldset>
			<div class="selection_3_bottom">
				<button id="selection_3_confirm">선발</button>
				<button id="selection_3_cancel">취소</button>
			</div>
			
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
	<c:url value="/selection_2" var="selection_2"/>
	$("#selection_3_confirm").on("click",function(){
		location.href="${selection_2}";
	})
	
	<c:url value="/selection" var="selection"/>
	$("#selection_3_cancel").on("click",function(){
		location.href="${selection}";
	})
</script>
</html>