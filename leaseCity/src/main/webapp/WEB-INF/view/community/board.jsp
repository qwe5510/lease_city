<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="leasecity.dto.community.Comment"%>
<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src='//uchat.co.kr/uchat.php' charset='UTF-8'></script>
<title>Insert title here</title>
</head>
<body>

<%
	Date todayDate = new Date();
	String today = DateUtil.getDateString(todayDate);
	request.setAttribute("today", today);
%>
	
	

	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="board">
		<div class="uchat">
			<script>
				u_chat({
					room : 'yhj123',
					chat_record : true,
					width : '400',
					height : '650',
					conversation_limi : true,
					in_sound : true,
					say_id : true
				});
			</script>
		</div>
		<div class="community">
			<img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
			<br>
			<br>
			<c:url value="/board_write" var="board_write"/>
			<sform:form method="post" modelAttribute="comment" action="${board_write }">
			<table class="communityTable">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="notify">
					<td>글번호</td>
					<td>분류</td>
					<td>제목</td>
					<td>글쓴이</td>
					<td>조회수</td>
					<td>날짜</td>
				</tr>
				
				<c:forEach var="comment" items="${comments}">
					
					<tr>
						<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					<tr class="boardShow">
						<td><c:out value="${comment.commentRowNum}" /></td>
						<td><c:out value="${comment.commentCategory}" /></td>
						<td class='communityTitle'>
							<c:out value="${comment.commentTitle}" />
						</td>
						<td><c:out value="${comment.userId}" /></td>
						<td><c:out value="${comment.hits}" /></td>					
						
						<fmt:formatDate value="${comment.regDate}"
								pattern="yyyy-MM-dd"
								var="strRegDate"/>
						
						<fmt:formatDate value="${comment.regDate}"
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
				
					
				
				<tr>
					<td colspan="6" class="boardLine" style="height: 3px !important;"></td>
				</tr>
				<tr>
				<th>
				<%
					for(int i=0;i<10;i++){
						out.print("<a>"+i+"</a>");
					}
				%>
				</th>
				<th>
					<button>글작성</button>
				</th>
				<tr>
			</table>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>


</html>