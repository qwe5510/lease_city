<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<c:url value="/information" var="information"/>
	<c:url value="/FAQ" var="FAQ"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1">
			<h2></h2>
			<br>
			</div>
			<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_advice" href="${information }"><img id="help_advice_img" src="<%=request.getContextPath()%>/images/help/help_menu3.png"></a></li>
			<li><a id="help_question" href="#"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu4_1.png"></a></li>
			</ul>
		</div>
		<div class="help_main">
			<table class="help_table">
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="notify">
					<td class="td1">글번호</td>
					<td class="td2">분류</td>
					<td class="td3">제목</td>
					<td class="td4">글쓴이</td>
					<td class="td5">조회수</td>
					<!-- <td class="td6"><a href="#">날짜<i class="icon-sort"></i></a></td> -->
					<%-- <c:choose>
						<c:when test="${!empty page.keyword and page.order eq 'ASC'}">
							<td>날짜<a
								href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=DESC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:when test="${!empty page.keyword}">
							<td>날짜<a
								href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=ASC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:when test="${page.order eq 'ASC' }">
							<td>날짜<a
								href="<%=request.getContextPath()%>/board?order=DESC"><i
									class="icon-sort"></i></a></td>
						</c:when>
						<c:otherwise>
							<td>날짜<a
								href="<%=request.getContextPath()%>/board?order=ASC"><i
									class="icon-sort"></i></a></td>
						</c:otherwise>
					</c:choose> --%>
				</tr>
				<tr>
					<td colspan="6" class="boardLine" style="height: 4px !important;"></td>
				</tr>
				<tr class="board_write">
					<td colspan="5">
					</td>
					<td colspan="1">
					<c:url value="/question_answer_write" var="question_answer_write"/>
					<a href="${question_answer_write}"><button><i class="icon-pencil"></i>글작성</button></a>
					</td>
				</tr>
				<tr>
					<td colspan="6" class="boardLine" style="height: 3px !important;"></td>
				</tr>
			</table>
			<sform:form method="post" modelAttribute="page" action="#">
				<div class="boardPage">
						<a><i class="icon-arrow-left"></i>이전</a>
						<%
						for(int i=0;i<10;i++){
							out.print("<a>"+i+"</a>");
						}
						%>
						<a>다음<i class="icon-arrow-right"></i></a>
				</div>
				</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
	});
	
	$("#help_advice").on("mouseover",function(){
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
	});
	
	$("#help_advice").on("mouseout",function(){
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
	});
</script>
</html>