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
	<br><br><br><br>
		<c:url value="/lease_call_read" var="lease_call_read"></c:url>
			<sform:form action="#" method="post" modelAttribute="heavyEquipmentCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table class="heavy_request_table">
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
					<td colspan="3" class="lease_label"><sform:label path="address">소재지</sform:label>
						<span>경기도 안양시 만안구 석수1동 대림아파트 113동 1803호</span>
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
			<fieldset>
				<legend>참고사항</legend>
				<textarea style="width: 720px;"></textarea>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="heavy_request_confirm"> <i class="icon-pencil"></i>작성</button>
				<button id="heavy_request_cancel"><i class="icon-link"></i>취소</button>
			</div>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
</script>
</html>