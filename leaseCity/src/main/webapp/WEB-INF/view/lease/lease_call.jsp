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
					<td class="td6"><a href="#">날짜<i class="icon-sort"></i></a></td>
					<%-- <c:choose>
						<c:when test="${!empty page.keyword and page.order eq 'ASC'}">
							<td>날짜<a
								href="<%=request.getContextPath()%>/question_answer?search=${page.search}&keyword=${page.keyword}&order=DESC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:when test="${!empty page.keyword}">
							<td>날짜<a
								href="<%=request.getContextPath()%>/question_answer?search=${page.search}&keyword=${page.keyword}&order=ASC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:when test="${page.order eq 'ASC' }">
							<td>날짜<a
								href="<%=request.getContextPath()%>/question_answer?order=DESC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:otherwise>
							<td>날짜<a
								href="<%=request.getContextPath()%>/question_answer?order=ASC"><i
									class="icon-sort"></i></a></td>
						</c:otherwise>
					</c:choose> --%>
				</tr>
				<c:forEach var="comment" items="${Q_AND_A}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td><c:out value="${comment.commentRowNum}" /></td>
                  <td><c:out value="${comment.commentCategory}" /></td>
                  <td class='communityTitle'>
                  
                  <c:choose>
	                  <c:when test="${!empty page.keyword and !empty page.order}">
	                    <a href="<%=request.getContextPath() %>/question_answer_read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.order}">
	                    <a href="<%=request.getContextPath() %>/question_answer_read?currentPage=${page.currentPage}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.keyword}">
	                    <a href="<%=request.getContextPath() %>/question_answer_read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:otherwise>
	                    <a href="<%=request.getContextPath() %>/question_answer_read?currentPage=${page.currentPage}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:otherwise>
               		</c:choose>

                      <c:if test="${comment.hits >= 100}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(comment.replyCount eq 0)}">
                     	<span class="label label-warning">
                     		+${comment.replyCount}
                     	</span>
                     </c:if>
                  </td>
                  <td><c:out value="${comment.companyName}" /></td>
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
            
            <c:if test="${empty page.totalPage and !empty errorMsg }">
               <tr>
                  <td colspan="6"><c:out value="${errorMsg}"></c:out></td>
               </tr>
            </c:if>
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="board_write">
					<td colspan="5">
					</td>
					<td colspan="1">
					<c:url value="/lease_call_write" var="lease_call_write"/>
					<a href="${lease_call_write}"><button><i class="icon-pencil"></i>글작성</button></a>
					</td>
				</tr>
				<tr>
					<td colspan="6" class="boardLine" style="height: 3px !important;"></td>
				</tr>
			</table>
			<div class="boardSearch">
				<div>더보기...</div>
				<div class="boardBottom">
				<sform:form action="#" method="post" modelAttribute="page">
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
</html>