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
	<c:choose>
	<c:when test="${isUser == 'HeavyEquipment'}">
		<div class="transfer_header"></div>
	</c:when>
	<c:when test="${isUser == 'Construction'}">
		<div class="direct_call_header"></div>
	</c:when>
	<c:otherwise>
		<div class="heavy_equipment_header"></div>
	</c:otherwise>
	</c:choose>
	<br>
			<fieldset>
			<legend>기업개요</legend>
			<table class="heavy_request_table">
				<tr>
					<td class="lease_label">
						<label>회사명</label>
						<span>${HECUser.companyName}</span>
					</td>
					<td class="lease_label">
						<label>대표자</label>
						<span>${HECUser.representName}</span>
					</td>
					<td class="lease_label">
						<label>대표연락처</label>
						<span>
						<c:choose>
							<c:when test="${!empty HECUser.representPhone}">
								${HECUser.representPhone}
							</c:when>
							<c:otherwise>
								미입력
							</c:otherwise>
						</c:choose>
						</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label">
						<label>소재지</label>
						<span>${HECUser.address}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label">
						<label>중장비 목록</label>
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
							<c:forEach var="heavyEquipment" items="${HECUser.heavyEquipmentList}">
							<tr>
								<td>${heavyEquipment.equipmentCategory}</td>
								<td>${heavyEquipment.idNumber}</td>
								<td>${heavyEquipment.usedYesNo}</td>

								<c:choose>
									<c:when test="${heavyEquipment.usedYesNo eq 'Y'}">
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
			<br>
			
			<c:choose>
				<c:when test="${isUser eq 'HeavyEquipment'}">
				<c:url value="/leaseTransferWrite" var="leaseTransferWrite"></c:url>
					<sform:form action="${leaseTransferWrite}" method="post" modelAttribute="leaseTransfer">
					<fieldset>
						<legend>보유차량</legend>
						<table>
							<tr>
								<td>
									<label>양도 시킬 차량</label>
								</td>
								<td class="possessionheavyEquipment">
									<sform:select path="acceptIdNumber" style="width: 350px;">
										<sform:options items="${acceptIdNumbers}"/>
									</sform:select>
								</td>
							</tr>
							<tr>
								<td>
									<label>양도 할 차량</label>
								</td>
								<td class="possessionheavyEquipment">
									<sform:select path="acceptIdNumber" style="width: 350px;">
										<sform:options items="${sendIdNumbers}"/>
									</sform:select>
								</td>
							</tr>
							<tr>
								<td>
									<label>기간</label>
								</td>
								<td colspan="2" class="heavy_request_date">
									<label>시작일자</label><sform:input path="fromDate" type="date"/><br>
									<label>종료일자</label><sform:input path="toDate" type="date"/>
									<span></span>
								</td>
							</tr>
							<tr>
								<td colspan="3" class="dateCheck"></td>
							</tr>
							<tr>
								<td>
									<label>금액</label>
								</td>
								<td class="heavy_request_price">
									<sform:input type="number" path="price" min="0"></sform:input>
									<label>단위(만원)</label>
								</td>
							</tr>
						</table>
					</fieldset>
					<br>
					<fieldset>
						<legend>참고사항</legend>
						<textarea style="width: 720px;"></textarea>
					</fieldset>
					<div class="lease_write_bottom">
						<button id="transfer_confirm"> <i class="icon-pencil"></i>양도 신청</button>
						<button id="transfer_cancel"><i class="icon-remove"></i>취소</button>
					</div>
					</sform:form>
				</c:when>
				
				<c:when test="${isUser eq 'Construction'}">
					<c:url value="/leaseDirectCallWrite" var="directCallWrite"></c:url>
					<sform:form action="${directCallWrite}" method="post" modelAttribute="leaseDirectCall">
					<fieldset>
						<legend>보유차량</legend>
						<table>
							<tr>
								<td>
									<label>보유차량</label>
								</td>
								<td class="possessionheavyEquipment">
									<input type="radio" name="heavyEquipment" value="트럭"><label>트럭</label>
									<input type="radio" name="heavyEquipment" value="펌프카"><label>펌프카</label>
									<input type="radio" name="heavyEquipment" value="물질핸들러"><label>물질핸들러</label>
									<input type="radio" name="heavyEquipment" value="트럭"><label>트럭</label>
									<input type="radio" name="heavyEquipment" value="포크레인"><label>포크레인</label>
									<input type="radio" name="heavyEquipment" value="장갑차"><label>장갑차</label>
								</td>
							</tr>
							<tr>
								<td>
									<label>기간</label>
								</td>
								<td class="heavy_request_date">
									<label>시작날짜</label><input type="date">
									<label>종료날짜</label><input type="date">
								</td>
							</tr>
							<tr>
								<td>
									<label>금액</label>
								</td>
								<td class="heavy_request_price">
									<input type="number"><label>단위(만원)</label>
								</td>
							</tr>
						</table>
					</fieldset>
					<br>
					<fieldset>
						<legend>요청내용</legend>
						<textarea style="width: 720px;"></textarea>
					</fieldset>
					<div class="lease_write_bottom">
						<button id="heavy_request_confirm"> <i class="icon-pencil"></i>작성</button>
						<button id="heavy_request_cancel"><i class="icon-remove"></i>취소</button>
					</div>
					</sform:form>
				</c:when>
				<c:otherwise>
					<fieldset>
						<h1>당신은 관리자 입니다.</h1>
					</fieldset>
				</c:otherwise>
			</c:choose>
			
			
			
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

<c:url value="/lookupHeavy" var="lookupHeavy"></c:url>
$("#transfer_confirm").on("click", function(e){
	var toDate = $("#toDate").val();
	var fromDate = $("#fromDate").val();
	
	if(!_jsDateCheck(fromDate,toDate)){
		return false;
	}else{$(".dateCheck").html("");}
});

<c:url value="/lookupHeavy" var="lookupHeavy"></c:url>
$("#transfer_cancel").on("click", function(e){
	e.preventDefault();
	location.href="${lookupHeavy}";
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
    var endDt   = new Date(Number(aryEndDt[0]),Number(aryEndDt[1])-1,Number(aryEndDt[2]));
    
    
    subFromDt    = Math.floor(startDt.valueOf()/(24*60*60*1000) - today.valueOf()/(24*60*60*1000));
      subToDt    = Math.floor(endDt.valueOf()/(24*60*60*1000) - today.valueOf()/(24*60*60*1000));
      
       if(subFromDt < 0){
    	  $(".dateCheck").css("color", "red");
          $(".dateCheck").html("오늘보다 이전으로 잡을 수 없습니다.");
          $("#toDate").focus();
      	  return false; 
    }else if(subToDt < 0){
    	$(".dateCheck").css("color", "red");
        $(".dateCheck").html("오늘보다 이전으로 잡을 수 없습니다.");
        $("#toDate").focus();
        return false;
    }
     
     if(fromDate == "" && toDate == ""){
    	 $(".dateCheck").css("color", "red");
        $(".dateCheck").html("날짜가 공백입니다 날짜를 설정 해주세요.");
        $("#fromDate").focus();
        return false;
     }
     else if(fromDate == ""){
    	 $(".dateCheck").css("color", "blue");
        $(".dateCheck").html("시작 날짜를 설정 해주세요.");
        $("#fromDate").focus();
        return false;
     }else if(toDate == ""){
        console.log("통과");
        $(".dateCheck").css("color", "blue");
        $(".dateCheck").html("종료 날짜를 설정 해주세요.");
        $("#toDate").focus();
        return false;
     }
     
      resultDt = Math.floor(endDt.valueOf()/(24*60*60*1000)- startDt.valueOf()/(24*60*60*1000));
  
      if(resultDt < 0 ){
    	$(".dateCheck").css("color", "red");
        $(".dateCheck").html("종료날짜가 시작날짜보다 나중이어야 합니다.");
        $("#toDate").focus();
        return false; 
     }
      
      return true;
 }

</script>
</html>