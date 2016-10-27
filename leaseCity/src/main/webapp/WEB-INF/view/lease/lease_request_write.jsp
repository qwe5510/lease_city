<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
			<c:url value="/lease_request_read" var="lease_request_read"></c:url>
			<sform:form action="#" method="post" modelAttribute="constructionCompany">
			<fieldset>
			<legend>기업개요</legend>
			<table class="lease_request_read_table">
				<tr>
					<td><sform:label path="companyName">회사명</sform:label>
						<span>대한건설</span>
					</td>
					<td><sform:label path="representName">대표자</sform:label>
						<span>대표자</span>
					</td>
				</tr>
				<tr>
					<td><sform:label path="companyCategory">회사분류</sform:label>
						<span>분류 분류</span>
					</td>
					<td><sform:label path="address">소재지</sform:label>
						<span>경기도 안양시 만안구 석수1동 대림아파트 113동 1803호</span>
					</td>
				</tr>
				<tr>
					<td colspan="2"><sform:label path="licenseList">자격증목록</sform:label>
						<span>자격증목록</span>
					</td>
				</tr>
			</table>
			</fieldset>
			</sform:form>
			<sform:form id="lease_request_form" action="${lease_request_read }" method="post" modelAttribute="leaseCall">
			<fieldset>
			<legend>임대신청</legend>
			<table class="lease_request_lease_table">
				<tr>
					<td style="width: 90px;"><sform:label path="leaseCategory">공사업종</sform:label>
					</td>
					<td style="width: 100px;">
						<sform:select path="leaseCategory">
							<sform:option value="토건">토건</sform:option>
							<sform:option value="토목">토목</sform:option>
							<sform:option value="건축">건축</sform:option>
							<sform:option value="산업설비">산업설비</sform:option>
							<sform:option value="토공">토공</sform:option>
							<sform:option value="철콘">철콘</sform:option>
							<sform:option value="금속구조">금속구조</sform:option>
							<sform:option value="철강">철강</sform:option>
							<sform:option value="시설물">시설물</sform:option>
							<sform:option value="주택건설">주택건설</sform:option>
							<sform:option value="문화재">문화재</sform:option>
							<sform:option value="해외">해외</sform:option>
							<sform:option value="기타">기타</sform:option>
						</sform:select>
					</td>
					<td style="width: 400px;">
					</td>
				</tr>
				<tr>
					<td colspan="3" class="constructionAddress"><sform:label path="address">작업장소</sform:label>
						<sform:input path="address"/>
						<input type="button" value="검색" id="conAddressSearch"/>
					</td>
				</tr>
				<tr>
					<td><sform:label path="equipmentCategory">필요차량</sform:label>
					</td>
					<td colspan="2" class="equipmentCategoryList">
						<sform:checkbox path="equipmentCategory" value="트럭" label="트럭" id="checked"/>
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
					<td><sform:label path="regDate">기간</sform:label>
					</td>
					<td colspan="2" class="fromToDate">
						<label>시작일자</label><sform:input path="fromDate" type="date"/>
						<label>종료일자</label> <sform:input path="toDate" type="date"/>
					</td>
				</tr>
				<tr>
					<td><sform:label path="regDate">금액</sform:label>
					</td>
					<td colspan="2" class="fromToDate">
						<label>최소금액</label>
						<label>최대금액</label>
					</td>
				</tr>
			</table>
			</fieldset>
			<br>
			<fieldset>
				<legend>참고사항</legend>
				<textarea></textarea>
			</fieldset>
			<div class="lease_write_bottom">
				<button id="lease_write"> <i class="icon-pencil"></i>작성</button>
				<button id="lease_write_cancel"><i class="icon-link"></i>취소</button>
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
    	$("#address").attr("reonly","");
 	}
 	<c:url value="/lease_request" var="lease_request"/>
 	$(document).on("click","#lease_write_cancel",function(e) {
   		e.preventDefault();
   		$("#lease_request_form").attr("action","${lease_request}");
   		$("#lease_request_form").submit();
 	});
</script>
</html>