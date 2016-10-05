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
		<img alt="" src="<%=request.getContextPath()%>/images/logo/logo.png">
		<div class="inner">
			<sform:form method="post" modelAttribute="user" action="#">
				<fieldset>
					<legend>로그인</legend>
					<div class="inner1">
						<sform:label path="userId">아이디</sform:label>
						<sform:input path="userId" type="text" />
						<br>
						<sform:label path="password">비밀번호</sform:label>
						<sform:input path="password" type="password" />
						<br>
					</div>
					<div class="inner2">
						<sform:button>로그인</sform:button>
					</div>
					<sform:button>회원가입요청</sform:button>
					<sform:button>아이디찾기</sform:button>
					<sform:button>비밀번호찾기</sform:button>
				</fieldset>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>