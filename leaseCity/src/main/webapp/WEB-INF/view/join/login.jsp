<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="login">
		<img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
		<div class="inner">
			<sform:form method="post" modelAttribute="user" action="#">
				<fieldset>
					<legend>로그인</legend>
					<table>
						<tr>
							<th><sform:label path="userId">아이디</sform:label></th>
							<th><sform:input path="userId" type="text" /></th>
							<th rowspan="2"><sform:button class="loginBtn">로그인</sform:button>
						</tr>
						<tr>
							<th><sform:label path="password">비밀번호</sform:label></th>
							<th><sform:input path="password" type="password" /></th>
						</tr>
					</table>
					<div class="inner1">
						<a data-toggle="modal" href="#loginForm">회원가입인증</a> <a>아이디찾기</a> <a>비밀번호찾기</a>
					</div>
				</fieldset>
			</sform:form>
		</div>
	</div>
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
		<jsp:include page="../layout/footer.jsp"></jsp:include>
		<!--  Login form -->
		<div class="modal hide fade in" id="loginForm" aria-hidden="false">
			<div class="modal-header">
				<i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i>
				<h4>회원가입 인증</h4>
			</div>
			<!--Modal Body-->
			<div class="modal-body">
			<sform:form class="form-inline" method="post" modelAttribute="user" action="#">
				<sform:label path="representName">업체명</sform:label>
				<sform:input path="representName" type="text"/><br>
				<sform:label path="companyName">대표자명</sform:label>
				<sform:input class="pop" path="companyName" type="text" /><br>
				<sform:label path="email">Email</sform:label>
				<sform:input  class="pop" path="email" type="email" /><br>
				<sform:button>가입 요청</sform:button>
			</sform:form>
			</div>
			<!--/Modal Body-->
		</div>
		<!--  /Login form -->
		<script src="js/vendor/jquery-1.9.1.min.js"></script>
		<script src="js/vendor/bootstrap.min.js"></script>
		<script src="js/main.js"></script>
		<!-- Required javascript files for Slider -->
		<script src="js/jquery.ba-cond.min.js"></script>
		<script src="js/jquery.slitslider.js"></script>
		<!-- /Required javascript files for Slider -->
</body>
</html>