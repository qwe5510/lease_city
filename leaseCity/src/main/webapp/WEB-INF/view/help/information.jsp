<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<c:url value="/FAQ" var="FAQ"/>
	<c:url value="/question_answer" var="question_answer"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1">
			<h2></h2>
			<br>
			</div>
			<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_advice" href="#"><img id="help_advice_img" src="<%=request.getContextPath()%>/images/help/help_menu3_1.png"></a></li>
			<li><a id="help_question" href="${question_answer }"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu4.png"></a></li>
			</ul>
		</div>
		<div class="help_main">
			<div>
				<p class="lease">임대신청</p>
				<ul class="hide" style="display: none;">
					<li><img id="help_advice_img" src="<%=request.getContextPath()%>/images/help/help_menu3_1.png"></li>
					<li>설명2</li>
					<li>설명3</li>
				</ul>
			</div>
			<div>
				<p>임대요청</p>
				<ul style="display: none;"> 
					<li>설명1</li>
					<li>설명2</li>
					<li>설명3</li>
				</ul>
			</div>
			<div>
				<p>임대양도</p>
				<ul style="display: none;">
					<li>설명1</li>
					<li>설명2</li>
					<li>설명3</li>
				</ul>
			</div>
			<div>
				<p>중기업체조회</p>
				<ul style="display: none;">
					<li>설명1</li>
					<li>설명2</li>
					<li>설명3</li>
				</ul>
			</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
	});
	
	$("#help_question").on("mouseover",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
	});
	
	$("#help_question").on("mouseout",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
	});
	$(document).ready(function(){
		$(".lease").on("click",function(){
			console.log("들어옴");
			var submenu =$(this).next("ul");
			console.log(submenu);
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
		});
	});
</script>
</html>