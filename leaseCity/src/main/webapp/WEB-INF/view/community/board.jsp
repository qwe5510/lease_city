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
					width : '300',
					height : '300',
					conversation_limi : true,
					in_sound : true,
					say_id : true,
					skin : 1,
					mb_list_height : '50'
				});
			</script>
		</div>
		<div class="community">
			<img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
			<br>
			<br>
			
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
					<td>날짜<a href="#"><i class="icon-sort"></i></a></td>
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
				<tr class="board_write">
					<td colspan="5">
					</td>
					<td colspan="1">
					<c:url value="/board_write" var="board_write"/>
					<a href="${board_write}"><button><i class="icon-pencil"></i>글작성</button></a>
					</td>
				</tr>
				<tr>
					<td colspan="6" class="boardLine" style="height: 3px !important;"></td>
				</tr>
			</table>
			<div class="boardSearch">
			<div class="boardPage" style="display: inline-block;">
				
				<!-- 이전 페이지, 다음 페이지 변수 선언 -->
				<fmt:parseNumber 
					value="${(((page.currentPage-1)/10)-(((page.currentPage-1)/10)%1))*10}" 
					var="prevPage">
				</fmt:parseNumber>
				<fmt:parseNumber 
					value="${prevPage+11}" 
					var="nextPage">
				</fmt:parseNumber>
					
				<c:choose>
				<c:when test="${prevPage > 0}">
					<a href="<%=request.getContextPath()%>/board?currentPage=${prevPage}">
					<i class="icon-arrow-left">이전</i></a>
				</c:when>
				<c:otherwise>
				<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
				</c:otherwise>
				</c:choose>				
				
				<c:choose>
					<c:when test="${(nextPage-1) >= page.totalPage }">
						<c:forEach var="i" begin="${prevPage+1}" end = "${page.totalPage}">
							<c:choose>
								<c:when test="${i eq page.currentPage}">
									<b><c:out value="${i}"></c:out></b>
								</c:when>
								<c:otherwise>
									<a href="<%=request.getContextPath()%>/board?currentPage=${i}">
										<c:out value="${i}"></c:out>
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<c:forEach var="i" begin="${prevPage+1}" end = "${nextPage-1}">
							<c:choose>
								<c:when test="${i eq page.currentPage}">
									<b><c:out value="${i}"></c:out></b>
								</c:when>
								<c:otherwise>
									<a href="<%=request.getContextPath()%>/board?currentPage=${i}">
										<c:out value="${i}"></c:out>
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
					
				<c:choose>
				<c:when test="${nextPage <= page.totalPage}">
					<a href="<%=request.getContextPath()%>/board?currentPage=${nextPage}">
					다음<i class="icon-arrow-right"></i></a>
				</c:when>
				<c:otherwise>
					<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
				</c:otherwise>
				</c:choose>
			</div>
			
			<%-- <c:url value="" var=""/> --%>
			<sform:form method="post" modelAttribute="page" action="#">
						
						<div class="boardBottom">
							<sform:select path="search">
								<sform:option value="COMPANY_NAME">글쓴이</sform:option>
								<sform:option value="TITLE">제목</sform:option>
								<sform:option value="TITLE_AND_CONTENT">제목+내용</sform:option>
								<sform:option value="LOCAL ">지역명</sform:option>
							</sform:select>
							<sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
							<button><i class="icon-search"></i>검색</button>
						</div>
			</sform:form>
			</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>


</html>