<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
						<span>대한건설</span>
					</td>
					<td class="lease_label"><sform:label path="representName">대표자</sform:label>
						<span>대표자</span>
					</td>
					<td class="lease_label">
						<sform:label path="representPhone">대표연락처</sform:label>
						<span>010-7799-4657</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="companyCategory">회사분류</sform:label>
						<span>분류 분류</span>
					</td>
					<td colspan="2" class="lease_label"><sform:label path="address">소재지</sform:label>
						<span>경기도 안양시 만안구 석수1동 대림아파트 113동 1803호</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="lease_label"><sform:label path="licenseList">자격증목록</sform:label>
						<span>자격증목록</span>
					</td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<c:url value="/lease_request" var="lease_request"></c:url>
			<sform:form id="lease_call_read_form" action="${lease_request }" method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대요청</legend>
			<table class="lease_request_lease_table">
				<tr>
					<td style="width: 90px;" class="lease_label"><sform:label path="leaseCategory">공사업종</sform:label>
					</td>
					<td colspan="2" class="leaseCategory">
							<span> 토건 토목 건축 산업설비</span>
					</td>
				</tr>
				<tr>
					<td colspan="3" class="constructionAddress"><sform:label path="address">작업장소</sform:label>
						<span>경기도 안양시 만안구 석수1동 대림아파트 113동 1803호</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="equipmentCategory">필요차량</sform:label>
					</td>
					<td colspan="2" class="equipmentCategoryList">
						<span>트럭 로더 그레이더 트랙</span>
					</td>
					
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">기간</sform:label>
					</td>
					<td colspan="2" class="fromToDate">
						<label>시작일자</label><span>2016.10.26</span>
						<label>종료일자</label><span>2016.11.10</span>
					</td>
				</tr>
				<tr>
					<td class="lease_label"><sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToPrice">
						<sform:label path="fromPrice">최소금액</sform:label><span>50</span>
						<sform:label path="toPrice">최대금액</sform:label><span>100</span>단위(만원)
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
				<span>참고사항!!!!</span>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_read"> <i class="icon-pencil"></i>임대신청</button>
				<button id="lease_read_cancel"><i class="icon-link"></i>취소</button>
			</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	<c:url value="/lease_call" var="lease_call"></c:url>
	$("#lease_read_cancel").on("click",function(e){
		e.preventDefault();
		$("#lease_call_read_form").attr("action","${lease_call}");
		$("#lease_call_read_form").submit();
	})
</script>
</html>