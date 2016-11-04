<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="leasecity.dto.user.*"%>
<!DOCTYPE html>
<html>
<head>
<title>lease City</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="myinfo">
	<div class="myinfo_0">
	<div class="myinfo_1">
	<c:url value="/history" var="history"></c:url>
	<c:url value="/mypage_identify" var="mypage_identify"></c:url>
	<c:url value="/withdrawal_agree_01" var="withdrawal_agree_01"></c:url>
		<a href="${mypage_identify}"><img id="myInfo1" src="<%=request.getContextPath()%>/images/mypage/개인정보.png"/></a>
	</div>
	<div class="myinfo_2">
		<a href="${history }"><img id="myInfo2" src="<%=request.getContextPath()%>/images/mypage/이용내역.png" /></a>
	</div>
	<div class="myinfo_3"> 
		<a href="${withdrawal_agree_01 }"><img id="myInfo3" src="<%=request.getContextPath()%>/images/mypage/회원탈퇴.png" /></a>
	</div>
	<div>
		<img src="<%=request.getContextPath()%>/images/mypage/표지판.png"/>
	</div>
	</div>
	</div>
	<!--Bottom-->
	<section id="bottom" class="main">
		<!--Container-->
		<div class="container">

			<!--row-fluids-->
			<div class="row-fluid">

				<!--Contact Form-->
				<div class="span3">
					<ul class="unstyled address">
						<li><img
							src="<%=request.getContextPath()%>/images/logo/logo2.png" /></li>
					</ul>
				</div>
				<!--End Contact Form-->

				<!--Important Links-->
				<div id="tweets" class="span3">
					<h4>CopyRighter</h4>
					<div>
						<ul class="arrow">
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
						</ul>
					</div>
				</div>
				<!--Important Links-->

				<!--Archives-->
				<div id="archives" class="span3">
					<h4>Our Company's</h4>
					<div>
						<ul class="arrow">
							<li>construction company's</li>
							<li>heavy equipment company's</li>
						</ul>
					</div>
				</div>
				<!--End Archives-->

				<div class="span3">
					<h4>Building</h4>
					<div class="row-fluid first">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build1.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build2.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build3.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build4.png"
								alt="" /></li>
						</ul>
					</div>
					<div class="row-fluid">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build5.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build6.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build7.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build8.png"
								alt="" /></li>
						</ul>
					</div>
				</div>
			</div>
			<!--/row-fluid-->
		</div>
		<!--/container-->

	</section>
	<!--/bottom-->
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>


<c:url value="/images/mypage/개인정보2.png" var="hoverMyInfo1"></c:url>
<c:url value="/images/mypage/개인정보.png" var="MyInfo1"></c:url>
<c:url value="/images/mypage/이용내역2.png" var="hoverMyInfo2"></c:url>
<c:url value="/images/mypage/이용내역.png" var="MyInfo2"></c:url>
<c:url value="/images/mypage/회원탈퇴2.png" var="hoverMyInfo3"></c:url>
<c:url value="/images/mypage/회원탈퇴.png" var="MyInfo3"></c:url>

$("#myInfo1").hover(
		function(){$(this).attr("src", "${hoverMyInfo1}");},
		function(){$(this).attr("src", "${MyInfo1}");});
		
$("#myInfo2").hover(
		function(){$(this).attr("src", "${hoverMyInfo2}");},
		function(){$(this).attr("src", "${MyInfo2}");});
		
$("#myInfo3").hover(
		function(){$(this).attr("src", "${hoverMyInfo3}");},
		function(){$(this).attr("src", "${MyInfo3}");});
		


</script>
</html>