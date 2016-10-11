<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class=join>
		<img src="<%=request.getContextPath()%>/images/login/join.png">
		<div class="input">
			<form method="post" action="#">
				<fieldset>
					<legend>기본정보 입력</legend>
					<table width="75%" cellpadding="0" cellspacing="0" align=center>
						<tr>
							<th><label class="join_input">아이디</label></th>
							<th><input type="text" placeholder="아이디" /></th>
						</tr>
						<tr>
							<th><label class="join_input">비밀번호</label></th>
							<th><input class="join_input" type="password" placeholder="패스워드" /></th>
						</tr>
						<tr>
							<th><label class="join_input">비밀번호확인</label></th>
							<th><input type="password" placeholder="패스워드 확인" /></th>
						</tr>
						<tr>
							<th><label class="join_input">업체명</label></th>
							<th><input type="text" placeholder="업체명" /></th>
						</tr>
						<tr>
							<th><label class="join_input">대표자명</label></th>
							<th><input type="text" placeholder="대표자명" /></th>
						</tr>
						<tr>
						</tr>
						<tr>
							<th><label class="join_input">대표자연락처</label></th>
							<th><input type="text" placeholder="대표자 연락처"></th>
						</tr>
						<tr>
							<th><label class="join_input">휴대폰연락처</label></th>
							<th><input type="text" placeholder="휴대폰 연락처"></th>
						</tr>
						<tr>
							<th><label class="join_input">Email</label></th>
							<th><input type="email" placeholder="Email"></th>
						</tr>
						<tr>
							<th><label class="join_input">주소</label></th>
							<th><input type="text" placeholder="주소"></th>
						</tr>
						<tr>
							<th><label class="join_input">업체선택</label></th>
							<th>
							<label for="company">건설업체</label> 
							<input type="radio"	name="company" id="CSC" value="건설업체" /> 
							<label for="중기업체">중기업체</label> 
							<input type="radio" name="company" id="HEC" value="중기업체" />
							</th>
						</tr>
					</table>
				</fieldset>
<<<<<<< HEAD
				
=======
>>>>>>> branch 'master' of https://github.com/qwe5510/lease_city.git
				<br>
				<fieldset>
					<legend>상세정보 입력</legend>
					<div class="companySelector">
						<h2>업체를 선택해주세요.</h2>
					</div>
				</fieldset>
				<br>
				<button>가입</button>
				<button>취소</button>
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#CSC").on("click",function(){
		$(".companySelector")
		.html("<table width='75%' cellpadding='0' cellspacing='0' align=center>"
		+"<tr><th><label class='join_input'>"+"연매출"+"</label></th><th><input type='text'placeholder='연매출'></th></tr>"
		+"<tr><th><label class='join_input'>"+"연수주량"+"</label></th><th><input type='text'placeholder='연 수주량'></th></tr>"
		+"<tr><th><label class='join_input'>"+"자격증"+"</label></th><th><input type='text'placeholder='자격증'></th></tr>"
		+"<tr><th><label class='join_input'>"+"회사규모"+"</label></th><th><input type='text'placeholder='회사 규모'></th></tr>"
		+"<tr><th><label class='join_input'>"+"회사분야"+"</label></th><th><input type='text'placeholder='회사 분야'></th></tr>"
		+"</table>");
	});
	$("#HEC").on("click",function(){
		$(".companySelector")
		.html("<input type='text' placeholder='차량 종류'>" +
		"<input type='text' placeholder='차량 크기'>"+
		"</th><th><input type='text' placeholder='차량 번호'>"+
		"<button id='btn1' >추가</button><br>");
	});	
	
	
	function add(e){
		e.preventDefault();
		console.log("add called");
	}
	
	$(document).on("click", "#btn1", function(e){
		e.preventDefault();
		$(".companySelector")
		.append("<input type='text' placeholder='차량 종류'><input type='text' placeholder='차량 크기'></th><th><input type='text' placeholder='차량 번호'><br>");
	})
	
	
</script>
</html>