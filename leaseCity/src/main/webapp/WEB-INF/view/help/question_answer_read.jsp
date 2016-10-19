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
		<div class="help_read_main">
			<c:url value="/board_write" var="board_write"/>
			<div class="help_read_main_inner">
			<sform:form id="board_read_form" action="${board_write }" method="post" modelAttribute="answer">
			<div class="board_read_line">
				<table class="board_read_table">
					<tr>
						<td><span>글쓴이</span></td>
						<td><span>2016.10.12</span></td>
						<td><span>조회수</span></td>
					</tr>
						<tr><td colspan='6' class='boardLine'></td></tr>
					<tr>
						<td colspan="3"><span>제목제목제목제목제목</span></td>
					</tr>
					<tr><td colspan="3" class='boardLine'></td></tr>
					<tr class="board_read_comment">
						<td colspan="3"><span></span></td>
					</tr>
				</table>
				<div style="text-align: left; padding: 10px;">
				<span>댓글 xx개</span>
				</div>
				
			</div>
			
			</sform:form>
			</div>
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