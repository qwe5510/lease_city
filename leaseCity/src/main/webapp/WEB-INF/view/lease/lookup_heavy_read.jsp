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
		<div class="lease_menu_inner"></div>
	</div>
	<c:url value="/leaseCall" var="leaseCall"></c:url>
    <ul class="lease_menu_ul">
		<li class="lease_menu_first"><a id="lease_call" href="${leaseCall}"><img id="lease_call_img" src="<%=request.getContextPath()%>/images/lease/lease_menu2.png"></a></li>
		<li><a id="lease_lookup"><img id="lease_lookup_img" src="<%=request.getContextPath()%>/images/lease/lease_menu3_1.png"></a></li>
	</ul>
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
						<legend>양도 신청</legend>
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
						<legend>임대 요청 선택</legend>
						<table>
							<tr>
								<td colspan="2">
									<label>요청 차량 선택</label>
									<sform:select path="${CallIdNumber}" style="width: 350px;">
										<sform:options items="${acceptIdNumbers}"/>
									</sform:select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<label>요청 대상 선택</label>
									<sform:select path="leaseCallNo" style="width: 500px;">
										<sform:options items="${leaseCallTitles}"/>
									</sform:select>
								</td>
							</tr>
							
							<tr>
								<td width="50px">
									<label>필요 차량 종류</label>
								</td>
								<td>
									<span id="equipmentCategory" style="font-size: 1.5em;">${leaseCalls[0].equipmentCategory}</span>
								</td>
							</tr>
							<tr>
								<td width="50px">
									<label>임대 기한</label>
								</td>
								<td>
									<fmt:formatDate value="${leaseCalls[0].toDate}" pattern="yyyy-MM-dd" var="toDate"></fmt:formatDate>
									<fmt:formatDate value="${leaseCalls[0].fromDate}" pattern="yyyy-MM-dd" var="fromDate"></fmt:formatDate>
									<span id="fromToDate" style="font-size: 1.5em;">${fromDate} ~ ${toDate}</span>
								</td>
							</tr>		
							<tr>
								<td width="50px">
									<label>주소</label>
								</td>
								<td>
									<span id="address" style="font-size: 1.5em;">${leaseCalls[0].address}</span>
								</td>
							</tr>
						</table>
					</fieldset>
					<br>
					<fieldset>
						<legend>요청 내용</legend>
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

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};

//날짜에 관한 스크립트 함수

<c:url value="/images/lease/lease_menu3_1.png" var="lookupHeavyHover"></c:url>
<c:url value="/images/lease/lease_menu3.png" var="lookupHeavyNormal"></c:url>
<c:url value="/images/lease/lease_menu2_1.png" var="leaseCallHover"></c:url>
<c:url value="/images/lease/lease_menu2.png" var="leaseCallNormal"></c:url>
	$("#lease_call").hover(
		function(){
			$("#lease_call_img").attr("src", "${leaseCallHover}")		
			$("#lease_lookup_img").attr("src", "${lookupHeavyNormal}");
	},
	function(){
		$("#lease_call_img").attr("src", "${leaseCallNormal}")
		$("#lease_lookup_img").attr("src", "${lookupHeavyHover}");
});

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
 
 <c:url value="/callInfoChange" var="callInfoChange"></c:url>
 $("#leaseCallNo").on("change", function(){
	 $.ajax({
		url: "${callInfoChange}",
		method: "GET",
		data: {
			callNoData : $(this).val()
		},
		success: function(leaseCall){
			
			console.log(leaseCall);
			
			var fromDate = new Date(leaseCall.fromDate).format("yyyy-MM-dd");
			var toDate = new Date(leaseCall.toDate).format("yyyy-MM-dd");
			
			$("#equipmentCategory").html(leaseCall.equipmentCategory);
			$("#fromToDate").html(fromDate + " ~ " + toDate);
			$("#address").html(leaseCall.address);
		},
		error: function(xhr, status, error){
			alert("유효하지 않은 요청글 정보입니다.");
		},
	 });
 });

</script>
</html>