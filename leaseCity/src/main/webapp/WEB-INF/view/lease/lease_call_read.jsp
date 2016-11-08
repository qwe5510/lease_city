<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>임대 요청 확인 | LEASE CITY</title>

<c:if test="${!empty lease_message }">
	<script>
		alert('${lease_message }');
	</script>
</c:if>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="lease">
		<div class="lease_menu">
      	<div class="lease_menu_inner"></div>
        </div>
        <c:url value="/lookupHeavy" var="lookupHeavy"></c:url>
        <ul class="lease_menu_ul">
			<li class="lease_menu_first"><a id="lease_call"><img id="lease_call_img" src="<%=request.getContextPath()%>/images/lease/lease_menu2_1.png"></a></li>
			<li><a id="lease_lookup" href="${lookupHeavy}"><img id="lease_lookup_img" src="<%=request.getContextPath()%>/images/lease/lease_menu3.png"></a></li>
	    </ul>	
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
						<span>${constructionCompany.companyCategory }</span>
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
			<c:url value="/leaseCall/leaseRequest" var="leaseRequest"></c:url>
			<sform:form id="lease_call_read_form" action="${leaseRequest}" method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대요청</legend>
			<table class="lease_request_lease_table">
				<tr>
					<td style="width: 90px;" class="lease_label"><sform:label path="leaseCategory">공사업종</sform:label>
					</td>
					<td colspan="2" class="leaseCategory">
							<span>${leaseCall.leaseCategory}</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="constructionAddress"><sform:label path="address">작업장소</sform:label>
						<span>${leaseCall.address}</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="equipmentCategory">필요차량</sform:label>
					</td>
					<td colspan="2" class="equipmentCategoryList">
						<span>${leaseCall.equipmentCategory}</span>
					</td>
					
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">기간</sform:label>
					</td>
					
					<fmt:formatDate value="${leaseCall.fromDate}" pattern="YYYY-MM-dd" var="strFromDate"/>
					<fmt:formatDate value="${leaseCall.toDate}" pattern="YYYY-MM-dd" var="strToDate"/>
					
					<td colspan="2" class="fromToDate">
						<span>${strFromDate}</span>
						 ~ 
						<span>${strToDate}</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToPrice">
						<span>${leaseCall.fromPrice}</span>
						 ~ 
						<span>${leaseCall.toPrice}</span>(만원)
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
				<span>${leaseCall.leaseCommentContent}</span>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_read"> <i class="icon-pencil"></i>임대신청</button>
				<button id="lease_read_cancel"><i class="icon-list"></i>목록</button>
			</div>
			<sform:hidden path="leaseCallNo"/>
			<sform:hidden path="equipmentCategory"/>
			<sform:hidden path="fromDate"/>
			<sform:hidden path="toDate"/>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

<c:url value="/images/lease/lease_menu3_1.png" var="lookupHeavyHover"></c:url>
<c:url value="/images/lease/lease_menu3.png" var="lookupHeavyNormal"></c:url>
<c:url value="/images/lease/lease_menu2_1.png" var="leaseCallHover"></c:url>
<c:url value="/images/lease/lease_menu2.png" var="leaseCallNormal"></c:url>
	$("#lease_lookup").hover(
		function(){
			$("#lease_call_img").attr("src", "${leaseCallNormal}")
			$("#lease_lookup_img").attr("src", "${lookupHeavyHover}");
		},
		function(){
			$("#lease_call_img").attr("src", "${leaseCallHover}")
			$("#lease_lookup_img").attr("src", "${lookupHeavyNormal}");
		});

	<c:url value="/leaseCall" var="leaseCall"></c:url>
	$("#lease_read_cancel").on("click",function(e){
		e.preventDefault();
		location.href="${leaseCall}";		
	})
</script>
</html>