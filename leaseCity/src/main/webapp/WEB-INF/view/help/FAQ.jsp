<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath() %>/css/accordionImageMenu.css" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<c:url value="/information" var="information"/>
	<c:url value="/question_answer" var="question_answer"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1">
			<h2></h2>
			<br>
			</div>
			<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="#"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2_1.png"></a></li>
			<li><a id="help_advice" href="${information }"><img id="help_advice_img" src="<%=request.getContextPath()%>/images/help/help_menu3.png"></a></li>
			<li><a id="help_question" href="${question_answer }"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu4.png"></a></li>
			</ul>
		</div>
		<div class="help_main">
			<ul id='menu'>
				<li><a id="a1" href='#'><span>title 1</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a2" href='#'><span>title 2</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a2"href='#'><span>title 3</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a3" href='#'><span>title 4</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a4" href='#'><span>title 4</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a5" href='#'><span>title 4</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
				<li><a id="a6" href='#'><span>title 4</span><img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" /></a></li>
			</ul>
			<div class="bb" style="display: none;">
			<img id="cc" src="<%=request.getContextPath()%>/images/img/img1.jpg">
			</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/accordion/jquery-ui-1.10.3.custom.min.js"></script>
<script src="js/accordion/jquery.accordionImageMenu.js"></script>
<script>
	$("#help_question").on("mouseover",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
	});
	
	$("#help_question").on("mouseout",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
	});
	
	$("#help_advice").on("mouseover",function(){
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
	});
	
	$("#help_advice").on("mouseout",function(){
		$("#help_advice_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
	});
	
	$(document).ready(function() {
		$('#menu').AccordionImageMenu();
	});
	
	$(document).ready(function(){
		$("#a1").on("click",function(){
			console.log("a1");
			var submenu =$(".bb");
			console.log("맨처음",submenu.is());
			if(submenu.is(":visible")){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img1.jpg'>");
                submenu.slideDown();
                
            }
		});
		
		$("#a2").on("click",function(){
			console.log("a2");
			var submenu =$(".bb");
			console.log(submenu);
			console.log(submenu.is(":visible"));
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img2.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a3").on("click",function(){
			console.log("a3");
			var submenu =$(".bb");
			console.log(submenu);
			console.log(submenu.is(":visible"));
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img3.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a4").on("click",function(){
			console.log("a4");
			var submenu =$(".bb");
			console.log(submenu);
			console.log(submenu.is(":visible"));
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img4.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a5").on("click",function(){
			console.log("a5");
			var submenu =$(".bb");
			console.log(submenu);
			console.log(submenu.is(":visible"));
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img5.jpg'>");
                submenu.slideDown();
            }
		});
		$("#a6").on("click",function(){
			console.log("a6");
			var submenu =$(".bb");
			console.log(submenu);
			console.log(submenu.is(":visible"));
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img6.jpg'>");
                submenu.slideDown();
            }
		});
	});
</script>
</html>