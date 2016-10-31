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
			<c:url value="/lease_call_read" var="lease_call_read"></c:url>
			<sform:form action="#" method="post" modelAttribute="heavyEquipmentCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table class="lease_request_table">
				<tr>
					<td class="lease_label"><sform:label path="companyName">회사명</sform:label>
						<span>${heavyEquipmentCompany.companyName}</span>
					</td>
					<td class="lease_label"><sform:label path="representName">대표자</sform:label>
						<span>${heavyEquipmentCompany.representName}</span>
					</td>
					<td class="lease_label">
						<sform:label path="representPhone">대표연락처</sform:label>
						<span>${heavyEquipmentCompany.representPhone}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label"><sform:label path="address">소재지</sform:label>
						<span>${heavyEquipmentCompany.address}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label">
					<sform:label path="heavyEquipmentList">중장비 목록</sform:label>
						<span>중장비 목록</span>
					</td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<sform:form id="lease_request_form" action="${lease_call_read }" method="post" modelAttribute="leaseRequest">
			<fieldset>
			<legend>임대신청</legend>
			<table class="lease_request_lease_table">
				<tr>
					<td class="lease_label">
					<sform:label path="idNumber">필요차량</sform:label>
					</td>
					<td colspan="2" class="heavyEquipmentArea" >
						<sform:select path="idNumber" style="width: 350px;">
							<sform:options items="${idNumbers}"/>
						</sform:select>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">기간</sform:label>
					</td>
					<td colspan="2" class="fromToDate">
						<label>시작일자</label><sform:input path="fromDate" type="date"/>
						<label>종료일자</label><sform:input path="toDate" type="date"/>
						<span></span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToPrice">
						<sform:input path="price" type="number"/>단위(만원)
					</td>
				</tr>
				<tr>
					<td colspan="3" class="priceCheck"></td>
				</tr>
			</table>
			</fieldset>
			<br>
			<fieldset>
				<legend>참고사항</legend>
				<textarea></textarea>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_request"> <i class="icon-pencil"></i>신청</button>
				<button id="lease_request_cancel"><i class="icon-link"></i>취소</button>
			</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
 	<c:url value="/lease_call" var="lease_call"/>
 	$(document).on("click","#lease_request_cancel",function(e) {
   		e.preventDefault();
   		$("#lease_request_form").attr("action","${lease_call}");
   		$("#lease_request_form").submit();
 	});
 	
 	$("#price").on("blur",function(){
 		var priceReg = /^[1-9][0-9]*$/;
 		var price = $("#price").val();
 		if(!priceReg.test(price)){
 			$(".priceCheck").html("공백 & 음수는 입력이 불가능합니다.");
 			$("#price").focus();
 			return false;
 		}else{
 			$(".priceCheck").html("");
 		}
 	});
 	$("#lease_request").on("click",function(e){
 		e.preventDefault();
 		var priceReg = /^[1-9][0-9]*$/;
 		var price = $("#price").val();
 		if(!priceReg.test(price)){
 			$(".priceCheck").html("공백 & 음수는 입력이 불가능합니다.");
 			$("#price").focus();
 			return false;
 		}else{
			if(confirm("확인 클릭시 수정이 불가능합니다.")==true){
				$("#lease_request_form").submit();
			}else{
				return false;
			}
 		}
 	});
 </script>
</html>