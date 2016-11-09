<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>중기업체 조회 | LEASE CITY</title>
</head>
<body>

	<c:if test="${!empty HEC_message }">
		<script>
			alert('${HEC_message}');
		</script>
	</c:if>

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
	<c:url value="/lookupHeavy" var="lookupHeavy"></c:url>
	<sform:form action="${lookupHeavy}" method="get" modelAttribute="page">
	<div class="heavy_select">
		<sform:select path="search">
			<sform:option value="ADDRESS">지역</sform:option>
			<sform:option value="COMPANY_NAME">업체명</sform:option>
			<sform:option value="CREDIT">신용도</sform:option>
		</sform:select>
	</div>
	<div class="heavy_search">
	
	<c:choose>
		<c:when test="${!empty creditCheck}">
			<sform:select path="keyword">
				<sform:option value="0">0.00 ~ 0.99</sform:option>
				<sform:option value="1">1.00 ~ 1.99</sform:option>
				<sform:option value="2">2.00 ~ 2.99</sform:option>
				<sform:option value="3">3.00 ~ 3.99</sform:option>
				<sform:option value="4">4.00 ~ 4.99</sform:option>
				<sform:option value="5">만점</sform:option>
			</sform:select>
		</c:when>
		<c:otherwise>
			<sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
		</c:otherwise>
	</c:choose>
	</div>
	<div class="heavy_button">
		<sform:button>검색</sform:button>
	</div>
	</sform:form>
	
	<div>
		<table class="heavy_table" style="width: 700px">
			<tr>
				<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
			</tr>
			<tr>
				<th><span>신용도</span></th>
				<th><span>업체명</span></th>
				<th><span>대표자</span></th>
				<th><span>지역</span></th>
				<th><span>사용가능차량</span></th>
				<th><span>작업완료횟수</span></th>
			</tr>
			
			<tr>
				<td colspan="6" class="boardLine"></td>
			</tr>
			
			<c:url value="/lookupHeavy/read?equipmentId=" var="lookupHeavy"></c:url>
			<c:forEach var="HEC" items="${heavyEquipmentCompanies}">
			
			<fmt:formatNumber value="${HEC.creditGrade/5.0}" 
					type="percent" var="creditPercent">
			</fmt:formatNumber>
			<fmt:formatNumber value="${HEC.creditGrade}" 
					pattern="0.00" var="credit"></fmt:formatNumber>
			<tr align="center" class="HECArea">
				<td>
					<div class="credit-min-area">
					<i class="credit-max-area" style="width: ${creditPercent}">
					</i></div>
					<strong>${credit}</strong>
				</td>
				<td>
					<a href="${lookupHeavy}${HEC.userId}">
					<span>${HEC.companyName}</span>
					</a>
					</td>
					<td>
					<a href="${lookupHeavy}${HEC.userId}">
					<span>${HEC.representName}</span>
					</a>
				</td>
				<td><span>${HEC.address}</span></td>
				<td><span>${HEC.outputCategory}</span></td>
				<td><span>${HEC.outputWorkLog}건</span></td>
			</tr>
			</c:forEach>

			<c:if test="${!empty errorMsg}">
			<tr><th colspan="6"><span>${errorMsg}</span></th></tr>
			</c:if>
			<tr>
				<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
			</tr>
		</table>
		</div>
		<div style="float: left">
			<span><a id="moreViewPage" href="#">더 보기</a></span>
		</div>
	</div>
	</div>
	
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	var g_currentPage = 1;

	
	
	$(window).on("load", function(e){
		var totalCount = ${page.totalCount};
		
		if(totalCount <= 5){
			$("#moreViewPage").css("display", "none");
		}
	});
	
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
	
	
	$("#search").on("change",function(){
		var selected1 = $("#search option:selected").val();
		if(selected1=="CREDIT"){
			$(".heavy_search").html("<select id=\"keyword\"name=\"keyword\"><option value=\"0\">0.00~0.99</option><option value=\"1\">1.00~1.99</option><option value=\"2\">2.00~2.99</option><option value=\"3\">3.00~3.99</option><option value=\"4\">4.00~4.99</option><option value=\"5\">만점</option></select>");
		}else{
			
			$(".heavy_search").html("<input id=\"keyword\" name=\"keyword\" placeholder=\"검색어를 입력해주세요.\" type=\"text\">");
		}
	});
	$("span").on("click",function(){
		$("#heavy_form").submit();
	});
	
	<c:url value="/moreHECPageAjax" var="moreHECPageAjax"></c:url>
	$("#moreViewPage").on("click", function(e){
		e.preventDefault();		
		$.ajax({
			method:"GET",
			url:"${moreHECPageAjax}",
			data: {
				currentPage : ++g_currentPage,
				search : "${page.search}",
				keyword : "${page.keyword}"
			},
			success: function(map){
				var HECs = map.HECs;
				var pageCount = map.pageCount;
				var pageSize = map.pageSize;
				
				var str= "";
				
				$(HECs).each(function(idx, HEC){
					
					var creditPercent = (HEC.creditGrade / 5.0 * 100) + "%";
					var credit = HEC.creditGrade.toFixed(2);
					
					str += "<tr align=\"center\" class=\"HECArea\">";
					str += "<td><div class=\"credit-min-area\">";
					str += "<i class=\"credit-max-area\" style=\"width:" + creditPercent + "\">";
					str += "</i></div><strong> " + credit + "</strong></td>";
					str += "<td><a href=\"${lookupHeavy}"+ HEC.userId +"\"><span>";
					str += HEC.companyName + "</span></a></td>";
					str += "<td><a href=\"${lookupHeavy}"+ HEC.userId +"\"><span>";
					str += HEC.representName + "</span></a></td>";
					str += "<td><span>" + HEC.address + "</span></td>";
					str += "<td><span>" + HEC.outputCategory + "</span></td>";
					str += "<td><span>" + HEC.outputWorkLog + "건</span></td>";
				});
				
				$(".heavy_table tr:last-child").remove();
				
				$(".heavy_table")
				.append("<tr><td colspan=\"6\" class=\"boardLine\"></td></tr>")
				.append(str)
				.append("<tr><td colspan=\"6\" class=\"boardLine\" style=\"height: 4px !important;\"></td></tr>");
				
				
			},
			error : function(error){
				alert("더 이상 불러올 중기업체 정보가\n존재하지 않습니다.");
			}
		});
	});
</script>
</html>