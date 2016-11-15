<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="myinfo">
		<div class="mypage_menu"></div>
		<div class="mypage_main">
			<span><b>회원탈퇴</b> 화면입니다.</span><br>
			<br> <span><b>회원탈퇴</b>를 하시면 더이상 서비스를 이용할 수 없습니다.<br>
			<br>
			<b>신중히</b> 생각해주시기 바랍니다.</span> <br>
			<br>
			<h3>회원 탈퇴하시겠습니까?</h3>
			<c:url value="/withdrawalCheckAjax" var="withdrawalCheckAjax"></c:url>
			<c:url value="/index" var="index"></c:url>
			<form id="mypageForm" method="get" action="${index}">
				<div>
					<label for="password">비밀번호</label> <input id="password"
						name="password" type="password" /> <span class="password"></span>
				</div>
				<div>
					<label for="password2">비밀번호확인</label> <input id="password2"
						name="password2" type="password" />
				</div>
				<button id="withdrawal_agree_confirm">탈퇴</button>
				<button id="withdrawal_agree_cancel">취소</button>
			</form>
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
	<c:url value="/index" var="index"></c:url>
	<c:url value="/withdrawalCheckAjax" var="withdrawalCheckAjax"></c:url>
	$("#withdrawal_agree_confirm").on("click", function(e) {
		e.preventDefault();

		var password = $("#password").val();
		var password2 = $("#password2").val();

		if (password2 == "" || password == "") {
			$(".password").html("두 패스워드 값을 전부 입력해주세요.");
			$(".password").css("color", "#FF0000");
			return false;
		} else if (password != password2) {
			$(".password").html("패스워드가 일치하지 않습니다.");
			$(".password").css("color", "#FF0000");
			return false;
		} else {
			$(".password").html("");

			console.log("df");

			$.ajax({
				url : "${withdrawal_agree_confirm}",
				method : "GET",
				data : {
					password : password
				},
				success : function(res) {
					alert();
					if (res) {
						$("#mypageForm").submit();
					} else {
						alert("올바른 패스워드가 아닙니다.");
					}
				},
				error : function(error) {
					alert(error);
				}
			});
		}
	});
	$("#withdrawal_agree_cancel").on("click", function() {
		location.href = "${myinfo}";
	})
</script>
</html>