<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LEASE CALL | LEASE CITY</title>

<c:if test="${!empty lease_message }">
	<script>
		alert('${lease_message }');
	</script>
</c:if>

<%
	Date todayDate = new Date();
	String today = DateUtil.getDateString(todayDate);
	request.setAttribute("today", today);
%>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="lease">
		<div class="lease_menu">
		</div>
		<div class="lease_main">
			<table class="help_table">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="notify">
					<td class="td1">신용도</td>
					<td class="td2">분류</td>
					<td class="td3">제목</td>
					<td class="td4">글쓴이</td>
					<td class="td5">조회수</td>
					<td class="td6">날짜</td>
				</tr>
				<c:forEach var="leaseCall" items="${leaseCalls}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td>${leaseCall.tempGrade}</td>
                  <td>
                  ${leaseCall.leaseCategory}<br>
                  ${leaseCall.equipmentCategory}
                  </td>
                  <td class='leaseCallTitle'>
	                 <a href="<%=request.getContextPath() %>/leaseCall/read?leaseCallNo=${leaseCall.leaseCallNo}">
                     	${leaseCall.leaseCommentTitle}
                     </a>
	                 
                     <c:if test="${leaseCall.hits >= 100}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(leaseCall.choiceLRCount eq 0)}">
                     	<span class="label label-warning">
                     		선발 : ${leaseCall.choiceLRCount}
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(leaseCall.standByLRCount eq 0)}">
                     	<span class="label label-warning">
                     		대기 : ${leaseCall.standByLRCount}
                     	</span>
                     </c:if>
                     
                  </td>
                  <td><c:out value="${leaseCall.companyName}" /></td>
                  <td><c:out value="${leaseCall.hits}" /></td>               
                  
                  <fmt:formatDate value="${leaseCall.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                  <fmt:formatDate value="${leaseCall.regDate}"
                        pattern="hh:mm:ss"
                        var="strRegTime"/>
                  
                  <c:choose>
                  <c:when test="${strRegDate eq today}">
                     <td><c:out value="${strRegTime}" /></td>
                  </c:when>
                  <c:otherwise>
                     <td><c:out value="${strRegDate}" /></td>
                  </c:otherwise>
                  </c:choose>                           
               </tr>
            </c:forEach>
            
            <!-- 페이지가 아무것도 없을 시 출력 -->
            <c:if test="${empty page.totalPage and !empty errorMsg}">
               <tr>
                  <td colspan="6"><c:out value="${errorMsg}"></c:out></td>
               </tr>
            </c:if>
            
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr>
				<td style="text-align: center;">
					<a href="#" id="morePage" class="icon-plus"> 더 보기</a>
				</td>
				</tr>
				<tr class="board_write">
					<td colspan="5">
					</td>
					<td colspan="1">
					<c:url value="/leaseCall/write" var="leaseCallWrite"/>
					<a href="${leaseCallWrite}"><button><i class="icon-pencil"></i>글작성</button></a>
					</td>
				</tr>
			</table>
			<div class="boardSearch">
				<div class="boardBottom">
				<c:url value="/leaseCall" var="leaseCall"></c:url>
				<sform:form action="${leaseCall}" method="get" modelAttribute="page">
                     <sform:select path="search">
                        <sform:option value="AUTHOR">글쓴이</sform:option>
                        <sform:option value="TITLE">제목</sform:option>
                        <sform:option value="ADDRESS">지역</sform:option>
                        <sform:option value="CATEGORY">임대,차량</sform:option>
                     </sform:select>
                     <sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
                     <button id="boardBtn"><i class="icon-search"></i>검색</button>
                 </sform:form>
                  </div>
         	</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#morePage").on("click", function(e){
		e.preventDefault();	
		
		$.ajax({
			
		})
	});
</script>

</html>