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
	<c:url value="/help/qna" var="qna"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1"></div>
		</div>
		<ul class="help_menu_ul">
			<li class="help_menu_first"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2_1.png"></li>
			<li><a id="help_question" href="${qna}"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu3.png"></a></li>
		</ul>
		
		<div class="cssload-cssload-wrap2">
			<div class="cssload-wrap">
				<div class="cssload-overlay"></div>
				<div class="cssload-cogWheel cssload-one">

					<div class="cssload-cog cssload-one"></div>
					<div class="cssload-cog cssload-two"></div>
					<div class="cssload-cog cssload-three"></div>
					<div class="cssload-cog cssload-four"></div>
					<div class="cssload-cog cssload-five"></div>
					<div class="cssload-center"></div>
				</div>
				<h5 style="margin-top: 40px; color: black;">loading</h5>
				<div class="cssload-cogWheel cssload-two">

					<div class="cssload-cog cssload-one"></div>
					<div class="cssload-cog cssload-two"></div>
					<div class="cssload-cog cssload-three"></div>
					<div class="cssload-cog cssload-four"></div>
					<div class="cssload-cog cssload-five"></div>
					<div class="cssload-center"></div>
				</div>
			</div>
		</div>


		<div class="help_main" style="display: none;">
			<ul id='menu'>
				<li><a id="a1" href='#'><b class="faq_bold">임대요청</b><span>임대요청</span><img
								src="<%=request.getContextPath()%>/images/FAQ/임대요청.png"
								alt="" /></a></li>
				<li><a id="a2" href='#'><b class="faq_bold">임대신청</b><span>임대신청</span><img
								src="<%=request.getContextPath()%>/images/FAQ/임대신청.png"
								alt="" /></a></li>
				<li><a id="a3"href='#'><b class="faq_bold">직접신청</b><span>임대직접신청</span><img
								src="<%=request.getContextPath()%>/images/FAQ/직접신청.png"
								alt="" /></a></li>
				<li><a id="a4" href='#'><b class="faq_bold">양도</b><span>임대양도</span><img
								src="<%=request.getContextPath()%>/images/FAQ/양도.png"
								alt="" /></a></li>
				<li><a id="a5" href='#'><b class="faq_bold">ID/Pass</b><span>id/pass찾기</span><img
								src="<%=request.getContextPath()%>/images/FAQ/아이디패스.png"
								alt="" /></a></li>
				<li><a id="a6" href='#'><b class="faq_bold">채팅방</b><span>채팅방이용</span><img
								src="<%=request.getContextPath()%>/images/FAQ/채팅방.png"
								alt="" /></a></li>
				<li><a id="a7" href='#'><b class="faq_bold">평가</b><span>평가하기</span><img
								src="<%=request.getContextPath()%>/images/FAQ/평가.png"
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
<script src="<%=request.getContextPath() %>/js/accordion/jquery-ui-1.10.3.custom.min.js"></script>
<script src="<%=request.getContextPath() %>/js/accordion/jquery.accordionImageMenu.js"></script>
<script>




	$("#help_question").on("mouseover",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
	});
	
	$("#help_question").on("mouseout",function(){
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
	});
	$(document).ready(function() {
		$('#menu').AccordionImageMenu();
	});
	var submenu =$(".bb");
	$(document).ready(function(){
		$("#a1").on("click",function(){
			if(submenu.is(":visible")){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img1.jpg'>");
                submenu.slideDown();
                
            }
		});
		
		$("#a2").on("click",function(){
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img2.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a3").on("click",function(){
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img3.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a4").on("click",function(){
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img4.jpg'>");
                submenu.slideDown();
            }
		});
		
		$("#a5").on("click",function(){
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<div class='search'><p id='idSearch'>아이디찾기</p><ul style='display: none;'><li><img src='<%=request.getContextPath()%>/images/FAQ/아이디1.PNG'></li><li><img src='<%=request.getContextPath()%>/images/FAQ/아이디2.PNG'></li></ul>"
            	+"</div><div class='search'><p id='passSearch'>비밀번호찾기</p><ul style='display: none;'><li><img src='<%=request.getContextPath()%>/images/FAQ/비밀번호1.PNG'></li><li><img src='<%=request.getContextPath()%>/images/FAQ/비밀번호2.PNG'></li></ul></div>");
                submenu.slideDown();
            }
		});
		$("#a6").on("click",function(){
			if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
            	$(".bb").html("<img src='<%=request.getContextPath()%>/images/FAQ/채팅방1.PNG'>"
            			+"<br><img src='<%=request.getContextPath()%>/images/FAQ/채팅방2.PNG'>");
                submenu.slideDown();
            }
		});
	
	$("#a7").on("click",function(){
		if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
        	$(".bb").html("<img src='<%=request.getContextPath()%>/images/img/img6.jpg'>");
            submenu.slideDown();
        }
	});
});
	$(document).ready(function(){
		 $(document).on("click","#idSearch",function(){
			console.log("들어옴");
			var idmenu =$(this).next("ul");
			if( idmenu.is(":visible") ){
				idmenu.slideUp();
            }else{
            	idmenu.slideDown();
            }
		});
		$(document).on("click","#passSearch",function(){
				console.log("들어옴");
				var idmenu =$(this).next("ul");
				if( idmenu.is(":visible") ){
					idmenu.slideUp();
	           }else{
	           	idmenu.slideDown();
	           }
			});
		
		setTimeout(function(){
			$(".cssload-cssload-wrap2").css("display", "none");
			$(".help_main").css("display", "block");
		}, 500);
		
		
	});

</script>
</html>