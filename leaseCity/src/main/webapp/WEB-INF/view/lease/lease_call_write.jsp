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
			
			<sform:form action="#" method="post" modelAttribute="constructionCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table class="lease_request_read_table">
				<tr>
					<td class="lease_label"><sform:label path="companyName">회사명</sform:label>
						<span>${constructionCompany.companyName}</span>
					</td>
					<td class="lease_label"><sform:label path="representName">대표자</sform:label>
						<span>${constructionCompany.representName}</span>
					</td>
					<td class="lease_label">
						<sform:label path="representPhone">
						대표연락처
						</sform:label>
						<span>
						<c:choose>
							<c:when test="${!empty constructionCompany.representPhone}">
								${constructionCompany.representPhone}
							</c:when>
							<c:otherwise>
								미입력
							</c:otherwise>
						</c:choose>
						</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="companyCategory">회사분류</sform:label>
						<span>${constructionCompany.companyCategory}</span>
					</td>
					<td colspan="2" class="lease_label"><sform:label path="address">소재지</sform:label>
						<span>${constructionCompany.address}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label"><sform:label path="licenseList">자격증목록</sform:label></td>
				</tr>
				
				<tr>
					<td colspan="3" style="padding: 0px; margin: 0px;">
						<table border="1" style="width: 100%">
							<tr>
								<th>자격증 이름</th>
								<th>발급처</th>
								<th>발급 날짜</th>
							</tr>
							<c:forEach var="license" items="${constructionCompany.licenseList}">
							<fmt:formatDate value="${license.licenseDate}" pattern="YYYY-MM-dd" var="StrDate"/>
							
							<tr>
								<td>${license.licenseName}</td>
								<td>${license.licenser}</td>
								<td>${StrDate}</td>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			
			<c:url value="/leaseCallWrite" var="leaseCallWrite"></c:url>
			<sform:form id="lease_call_write_form" action="${leaseCallWrite }" 
								method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대요청</legend>
			<table class="lease_request_lease_table">
				<tr>
					<td style="width: 90px;" class="lease_label"><sform:label path="leaseCategory">공사업종</sform:label>
					</td>
					<td class="leaseCategory">
							<sform:checkbox path="leaseCategory" value="토건" label="토건"/>
							<sform:checkbox path="leaseCategory" value="토목" label="토목" />
							<sform:checkbox path="leaseCategory" value="건축" label="건축"/>
							<sform:checkbox path="leaseCategory" value="산업설비" label="산업설비"/>
							<sform:checkbox path="leaseCategory" value="토공" label="토공"/>
							<sform:checkbox path="leaseCategory" value="철콘" label="철콘"/>
							<sform:checkbox path="leaseCategory" value="금속구조" label="금속구조"/>
							<sform:checkbox path="leaseCategory" value="철강" label="철강"/>
							<sform:checkbox path="leaseCategory" value="시설물" label="시설물" />
							<sform:checkbox path="leaseCategory" value="주택건설" label="주택건설" />
							<sform:checkbox path="leaseCategory" value="문화재" label="문화재" />
							<sform:checkbox path="leaseCategory" value="해외" label="해외" />
							<sform:checkbox path="leaseCategory" value="기타" label="기타" />
					</td>
				</tr>
				<tr>
					<td colspan="3" class="constructionAddress lease_label">
						<sform:label path="address">작업장소</sform:label>
						<sform:input path="address" readonly="true" style="background:white;"/>
						<input type="button" value="검색" id="conAddressSearch"/>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="equipmentCategory" >필요차량</sform:label>
					</td>
					<td colspan="2" class="equipmentCategoryList">
						<sform:checkbox path="equipmentCategory" value="트럭" label="트럭" />
						<sform:checkbox path="equipmentCategory" value="로더" label="로더"/>
						<sform:checkbox path="equipmentCategory" value="그레이더" label="그레이더"/>
						<sform:checkbox path="equipmentCategory" value="트랙" label="트랙"/>
						<sform:checkbox path="equipmentCategory" value="스크레이퍼" label="스크레이퍼"/>
						<sform:checkbox path="equipmentCategory" value="스키더" label="스키더"/>
						<sform:checkbox path="equipmentCategory" value="물질핸들러" label="물질핸들러"/>
						<sform:checkbox path="equipmentCategory" value="벌목용장비" label="벌목용장비"/>
						<sform:checkbox path="equipmentCategory" value="휠도저" label="휠도저"/>
						<sform:checkbox path="equipmentCategory" value="굴삭기" label="굴삭기"/>
						<sform:checkbox path="equipmentCategory" value="펌프카" label="펌프카"/>
						<sform:checkbox path="equipmentCategory" value="기타" label="기타"/>
					</td>
					
				</tr>
				<tr>
					<td class="lease_label">
					<sform:label path="regDate">기간</sform:label>
					</td>
					<td colspan="2" class="fromToDate">
						<sform:label path="fromDate">시작일자</sform:label>
						<input id="fromDate" name="strFromDate" type="date"/>
						<br>
						<sform:label path="toDate">종료일자</sform:label>
						<input id="toDate" name="strToDate" type="date"/>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="dateCheck"></td>
				</tr>
				<tr>
					<td class="lease_label">
					<sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToPrice">
						<sform:label path="fromPrice">최소금액</sform:label>
						<sform:input path="fromPrice" type="number" min="0"/><br>						
						<sform:input path="toPrice" type="number" min="0"/>단위(만원)
						<sform:label path="toPrice">최대금액</sform:label>
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
				<sform:textarea path="leaseCommentContent" cols="50" rows="5"/>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_call_write"> <i class="icon-pencil"></i>작성</button>
				<button id="lease_call_write_cancel"><i class="icon-list"></i>목록</button>
			</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$(document).on("click","#conAddressSearch",function(e) {
   		e.preventDefault();
   		var result = window.open("<%=request.getContextPath()%>/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
 	});
 
 	function jusoCallBack(roadFullAddr){
    	$("#address").val(roadFullAddr);
 	}
 	
 	<c:url value="/leaseCall" var="leaseCall"/>
 	$(document).on("click","#lease_call_write_cancel",function(e) {
   		e.preventDefault();
   		location.href="${leaseCall}";
 	});
 	
 	$("#fromPrice").on("blur",function(){
 		var priceReg = /^[1-9][0-9]*$/;
 		var lease_fromprice = $("#fromPrice").val();
 		if(!priceReg.test(lease_fromprice)){
 			$(".priceCheck").html("공백 또는 0값은 입력이 불가능합니다.");
 			$("#fromPrice").focus();
 			return false;
 		}else{
 			$(".priceCheck").html("");
 		}
 	});
 	$("#toPrice").on("blur",function(){
 		var lease_fromprice = $("#fromPrice").val();
 		var lease_toprice = $("#toPrice").val();
 		
 		if(lease_fromprice>lease_toprice){
 			$(".priceCheck").html("최소금액보다는 커야합니다.");
 			$("#toPrice").focus();
 			return false;
 		}else{
 			$(".priceCheck").html("");
 		}
 	})
 	$("#lease_call_write").on("click",function(e){
 		var priceReg = /^[1-9][0-9]*$/;
 		var lease_fromprice = $("#fromPrice").val();
 		var lease_toprice = $("#toPrice").val();

 		var fromDate = $("#fromDate").val();
 		var toDate = $("#toDate").val();
 		
 		if(!_jsDateCheck(fromDate,toDate)){
 			return false;
 		}else if(!priceReg.test(lease_fromprice)){
 			$(".priceCheck").html("최소금액보다는 커야합니다.");
 			$("#toPrice").focus();
 			return false;
 		}else if(lease_fromprice>lease_toprice){
 			$(".priceCheck").html("최소금액보다는 커야합니다.");
 			$("#toPrice").focus();
 			return false;
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