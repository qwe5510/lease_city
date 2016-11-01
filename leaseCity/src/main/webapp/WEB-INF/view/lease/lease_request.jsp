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
					</td>
				</tr>
				<tr>
					<td colspan="3" style="padding: 0px; margin: 0px;">
						<table border="1" style="width: 100%">
							<tr>
								<th>차량 분류</th>
								<th>차량 번호</th>
								<th>사용 여부</th>
								<th>신청 가능 여부</th>
							</tr>
							<c:forEach var="heavyEquipment" items="${heavyEquipmentCompany.heavyEquipmentList}">
							<tr>
								<td>${heavyEquipment.equipmentCategory}</td>
								<td>${heavyEquipment.idNumber}</td>
								<td>${heavyEquipment.usedYesNo}</td>

								<c:choose>
									<c:when test="${heavyEquipment.checkRequest eq 'N'}">
										<td style="background-color: red; color: white;">
											신청 불가
										</td>
									</c:when>
									
									<c:otherwise>
										<td style="background-color: blue; color: white;">
											신청 가능
										</td>
									</c:otherwise>
								</c:choose>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<c:url value="/leaseCall/RequestWrite" var="leaseRequestWrite"></c:url>
			<sform:form id="lease_request_form" action="${leaseRequestWrite}" method="post" modelAttribute="leaseRequest">
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
						<label>시작일자</label><sform:input path="fromDate" type="date"/><br>
						<label>종료일자</label><sform:input path="toDate" type="date"/>
						<span></span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="dateCheck"></td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToPrice">
						<sform:input path="price" type="number" min="0"/><h4 style="margin-top: 25px; color: black;">만원(단위)</h4>
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
				<sform:hidden path="leaseCallNo"/>
			</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
 	<c:url value="/leaseCall/read?leaseCallNo=${leaseRequest.leaseCallNo}" var="leaseCallRead"/>
 	$(document).on("click","#lease_request_cancel",function(e) {
   		e.preventDefault();
   		location.href="${leaseCallRead}";
 	});
 	
 	$("#price").on("blur",function(){
 		var priceReg = /^[1-9][0-9]*$/;
 		var price = $("#price").val();
 		if(!priceReg.test(price)){
 			$(".priceCheck").html("공백 입력은 불가능합니다.");
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
 		
 		var toDate = $("#toDate").val();
 		var fromDate = $("#fromDate").val();
 		
 		if(!_jsDateCheck(fromDate,toDate)){
 			return false;
 		}
 		else if(!priceReg.test(price)){
 			$(".priceCheck").html("공백 입력은 불가능합니다.");
 			$("#price").focus();
 			return false;
 		}
 		else{
			if(confirm("확인 클릭시 수정이 불가능합니다.")==true){
				$("#lease_request_form").submit();
			}else{
				return false;
			}
 		}
 	});
 	
 	$("#toDate").on("blur", function(e){
 		var toDate = $(this).val();
 		var fromDate = $("#fromDate").val();
 		
 		if(!_jsDateCheck(fromDate,toDate)){
 		}else{$(".dateCheck").html("");}
 	});
 	
 	$("#fromDate").on("blur", function(e){
 		var toDate = $("#toDate").val();
 		var fromDate = $(this).val();
 		
 		if(!_jsDateCheck(fromDate,toDate)){
 			$(this).focus();
 		}else{$(".dateCheck").html("");}
 	});
 	
 	function _jsDateCheck(fromDate, toDate){
 	    var arySrtDt = fromDate.split("-"); // ex) 시작일자(2007-10-09)
 	    var aryEndDt = toDate.split("-"); // ex) 종료일자(2007-12-05)

 	  	var temp = new Date(); // temp
 	  	
 	  	var today = new Date(Number(temp.getFullYear()), Number(temp.getMonth()), Number(temp.getDate())); 	  	
 		var startDt = new Date(Number(arySrtDt[0]),Number(arySrtDt[1])-1,Number(arySrtDt[2]));
	    var endDt	= new Date(Number(aryEndDt[0]),Number(aryEndDt[1])-1,Number(aryEndDt[2]));
	    
	    
	    subFromDt 	= Math.floor(startDt.valueOf()/(24*60*60*1000) - today.valueOf()/(24*60*60*1000));
	   	subToDt 	= Math.floor(endDt.valueOf()/(24*60*60*1000) - today.valueOf()/(24*60*60*1000));
	   	
 	   	if(subFromDt < 0){
	   	 	$(".dateCheck").html("오늘보다 이전으로 잡을 수 없습니다.");
	    	$("#toDate").focus();
	    	return false; 
	    }else if(subToDt < 0){
	    	$(".dateCheck").html("오늘보다 이전으로 잡을 수 없습니다.");
	    	$("#toDate").focus();
	    	return false;
	    }
 	    
 	    if(fromDate == "" && toDate == ""){
 	    	$(".dateCheck").html("날짜가 공백입니다 날짜를 설정 해주세요.");
 	    	$("#fromDate").focus();
 	    	return false;
 	    }
 	    else if(fromDate == ""){
 	    	$(".dateCheck").html("시작 날짜를 설정 해주세요.");
 	    	$("#fromDate").focus();
 	    	return false;
 	    }else if(toDate == ""){
 	    	console.log("통과");
 	    	$(".dateCheck").html("종료 날짜를 설정 해주세요.");
 	    	$("#toDate").focus();
 	    	return false;
 	    }
 	    
 	  	resultDt = Math.floor(endDt.valueOf()/(24*60*60*1000)- startDt.valueOf()/(24*60*60*1000));
 	 
 	  	if(resultDt < 0 ){
 	    	$(".dateCheck").html("종료날짜가 시작날짜보다 나중이어야 합니다.");
 	    	$("#toDate").focus();
 	    	return false; 
 	    }
 	  	
 	  	return true;
 	}
 	
 	
 </script>
</html>