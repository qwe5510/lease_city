<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>양도 직접 요청 | LEASE CITY</title>

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
			alert("요청한 서비스 실행에 실패하였습니다.")
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
	alert("해당 요청을 수락하였습니다.")
	window.opener.document.location.href = window.opener.document.URL;
	window.close();
	</script>
</c:if>

<c:if test="${!empty exitSign and exitSign == 'rejection'}">
	<script>
	alert("해당 요청을 거절하였습니다.")
	window.opener.document.location.href = window.opener.document.URL;
	window.close();
	</script>
</c:if>

<c:if test="${!empty ldc_message}">
	<script>
	alert("${ldc_message}");
	window.close();
	</script>
</c:if>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/main.css">
</head>
<body>
	<div class="leaseDirectCallArea">
		<fieldset>
		<legend style="font-size: 2em">임대 요청 정보</legend>
		<table>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">요청 제목</th>
				<td style="padding-left: 25px; font-size: 1em;">${leaseCall.leaseCommentTitle}</td>
			</tr>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">작업 장소</th>
				<td style="padding-left: 25px; font-size: 1.2em;">${leaseCall.address}</td>
			</tr>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">필요 차량 종류</th>
				<td style="padding-left: 25px; font-size: 1.2em;">${leaseCall.equipmentCategory}</td>
			</tr>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">임대 작업 종류</th>
				<td style="padding-left: 25px; font-size: 1.2em;">${leaseCall.leaseCategory}</td>
			</tr>
		</table>
		</fieldset>
		<br>
		<fieldset>
			<legend style="font-size: 2em">임대 직접 요청</legend>
			<table class="leaseDirectCallTable" style="width:100%">
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">업체명</th>
				<td style="padding-left: 25px; font-size: 1.3em;">${leaseDirectCall.companyName}</td>
			</tr>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">요청 차량 번호</th>
				<td style="padding-left: 25px; font-size: 1.3em;">${leaseDirectCall.callIdNumber}</td>
			</tr>
			<tr align="center">
				<th width="100px" style="font-size: 1.2em">요청 가격</th>
				<td style="padding-left: 25px; font-size: 1.3em;">${leaseDirectCall.fromPrice} ~ ${leaseDirectCall.toPrice} (만원)</td>
			</tr>
			
			<fmt:formatDate value="${leaseCall.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
			<fmt:formatDate value="${leaseCall.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
			
			<tr>
				<th width="100px" style="font-size: 1.2em">시작 날짜</th>
				<td id="fromCurtLine"style="padding-left: 25px; font-size: 1.3em;">${fromDate}</td>
			</tr>
			<tr>
				<th width="100px" style="font-size: 1.2em">종료 날짜</th>
				<td id="toCurtLine" style="padding-left: 25px; font-size: 1.3em;">${toDate}</td>
			</tr>
			</table>
		</fieldset>
		
		<fieldset>
			<legend>요청 내용</legend>
			${leaseCall.leaseCommentContent}
		</fieldset>
		
		<c:url value="/workManagement/leaseDirectCall/rejection" var="rejectionLDR"></c:url>
		<c:url value="/workManagement/leaseDirectCall/permission" var="permissionLDR"></c:url>
		<form id="LDRForm" action="${permissionLDR}" method="post">
		<div style="float: left; text-align: left; padding-left: 20px; padding-top: 25px;">
			<span class="dateCheck"></span>
			<br>
			<label for="fromDate">희망 시작 날짜</label>
			<input type="date" class="LDCInput" id="fromDate" name="fromDate">
			<br>
			<label for="toDate">희망 종료 날짜</label>
			<input type="date" class="LDCInput" id="toDate" name="toDate">
			<br>
			<label for="price" style="float:left; margin-top: 10px;">희망 가격</label>
			<input type="number" class="LDCInput" style="margin:0px; margin-left: 8px;" id="price" name="price" min="0">
			만원 (단위)
			<br>
			<span class="LDRpriceCheck"></span>
			<input type="hidden" name="callIdNumber" value="${leaseDirectCall.callIdNumber}" />
			<input type="hidden" name="leaseCallNo" value="${leaseCall.leaseCallNo}" />
			<input type="hidden" name="leaseDirectNo" value="${leaseDirectCall.leaseDirectNo}" />
		</div>		
		<button id="permissionBtn" class="leaseCallBtn">수락</button>
		<button id="rejectionBtn" class="leaseCallBtn">거절</button>
		
		</form>
	</div>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

	$("#permissionBtn").on("click", function(e){		
		var fromDate = $("#fromDate").val();
		var toDate = $("#toDate").val();
		
		var fromCurtLine = $("#fromCurtLine").html();
		var toCurtLine = $("#toCurtLine").html();
		
		var price = Number($("#price").val());
		var minPrice = Number(${leaseDirectCall.fromPrice});
		var maxPrice = Number(${leaseDirectCall.toPrice});
		
		if(!_jsDateCheck(fromDate, toDate, fromCurtLine, toCurtLine)){
			return false;
		}else if(price < minPrice || price > maxPrice){
			$(".LDRpriceCheck").css("color", "red");
			$(".LDRpriceCheck").html("희망가격이 요청가격의 한도를 벗어났습니다.");
			return false;
		}else if(price >= minPrice && price <= maxPrice){
			$(".LDRpriceCheck").html("");
		}
	})
	
	$("#rejectionBtn").on("click", function(e){
		$("#LDRForm").attr("action", "${rejectionLDR}");
	})
	
	function _jsDateCheck(fromDate, toDate, fromCurtLine, toCurtLine){
 	    var arySrtDt = fromDate.split("-"); // ex) 시작일자(2007-10-09)
 	    var aryEndDt = toDate.split("-"); // ex) 종료일자(2007-12-05)
 	    
 	    var aryFromCurtLine = fromCurtLine.split("-");
 	    var aryToCurtLine = toCurtLine.split("-");
 	     	  	
 		var startDt = new Date(Number(arySrtDt[0]),Number(arySrtDt[1])-1,Number(arySrtDt[2]));
	    var endDt	= new Date(Number(aryEndDt[0]),Number(aryEndDt[1])-1,Number(aryEndDt[2]));

 	    
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
 	  	
 	  	var fromCurtLineDt = new Date(Number(aryFromCurtLine[0]),Number(aryFromCurtLine[1])-1,Number(aryFromCurtLine[2]));
 	  	var toCurtLineDt = new Date(Number(aryToCurtLine[0]), Number(aryToCurtLine[1])-1, Number(aryToCurtLine[2]));
 	  	
 	  	fromSubCurtLineFromDt = Math.floor(startDt.valueOf()/(24*60*60*1000)- fromCurtLineDt.valueOf()/(24*60*60*1000));
 	  	fromSubCurtLineToDt = Math.floor(endDt.valueOf()/(24*60*60*1000)- fromCurtLineDt.valueOf()/(24*60*60*1000));
 	  	
 	  	toSubCurtLineFromDt = Math.floor(toCurtLineDt.valueOf()/(24*60*60*1000) - startDt.valueOf()/(24*60*60*1000));
 	  	toSubCurtLineToDt = Math.floor(toCurtLineDt.valueOf()/(24*60*60*1000) - endDt.valueOf()/(24*60*60*1000));
 	  	
 	  	
 	  	if(fromSubCurtLineFromDt < 0){
 	  		$(".dateCheck").css("color", "red");
 	  		$(".dateCheck").html("임대 요청 시작날짜보다 이전 일 수 없습니다.");
 	    	$("#fromDate").focus();
 	    	return false;
 	  	}else if(fromSubCurtLineToDt < 0){
 	  		$(".dateCheck").css("color", "red");
 	  		$(".dateCheck").html("임대 요청 시작날짜보다 이전 일 수 없습니다.");
 	    	$("#toDate").focus();
 	    	return false;
 	  	}
 	  	
 	  	if(toSubCurtLineFromDt < 0){
 	  		$(".dateCheck").css("color", "red");
 	  		$(".dateCheck").html("임대 요청 시작날짜보다 이후 일 수 없습니다.");
 	    	$("#fromDate").focus();
 	    	return false;
 	  	}else if(toSubCurtLineToDt < 0){
 	  		$(".dateCheck").css("color", "red");
 	  		$(".dateCheck").html("임대 요청 종료날짜보다 이후 일 수 없습니다.");
 	    	$("#toDate").focus();
 	    	return false;
 	  	}else{
 	  		$(".dateCheck").html("");
 	  	}
 	  	
 	  	return true;
 	}

</script>
</html>