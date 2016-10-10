<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
					<input type="text" placeholder="아이디를 입력해주세요"/>
					<button>중복확인</button>
					<br>
					<input type="password" placeholder="패스워드"/>
					<br>
					<input type="password" placeholder="패스워드 확인"/>
					<br>
					<input type="text" placeholder="업체명"/>
					<br>
					<input type="text" placeholder="대표자명"/>
					<br>
					<input type="tel" placeholder="대표자 연락처">
					<br>
					<input type="tel" placeholder="휴대폰 연락처">
					<br>
					<input type="email" placeholder="Email">
					<br>
					<input type="text">
					<br>
					<label for="company">건설업체</label>
					<input type="radio" name="company" value="건설업체"/>
					<label for="중기업체">중기업체</label>
					<input type="radio" name="company" value="중기업체"/>
				</fieldset>
				<br>
				<fieldset>
					<legend>상세정보 입력</legend>
					ㅁㄴㅇㅁㄴㅇ ㅁㄴㅇㅁㄴㅇ ㅁㄴㅇㅁㄴㅇ ㅁㄴㅇㅁㄴㅇ
				</fieldset>
				<br>
				<button>가입</button>
				<button>취소</button>
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>