<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>lease City</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class=join>
		<img src="<%=request.getContextPath()%>/images/login/join.png">
		<div class="input">
			<form id="joinForm" method="post" action="#">
				<fieldset>
					<legend>기본정보 입력</legend>
					<table width="75%" cellpadding="0" cellspacing="0" align=center>
						<tr>
							<th><label class="join_input">아이디</label></th>
							<th><input type="text" placeholder="아이디" /></th>
						</tr>
						<tr>
							<th><label class="join_input">비밀번호</label></th>
							<th><input class="join_input" type="password"
								placeholder="패스워드" /></th>
						</tr>
						<tr>
							<th><label class="join_input">비밀번호확인</label></th>
							<th><input type="password" placeholder="패스워드 확인" /></th>
						</tr>
						<tr>
							<th><label class="join_input">업체명</label></th>
							<th><input type="text" placeholder="업체명" value="<%=session.getAttribute("companyName") %>" readonly /></th>
						</tr>
						<tr>
							<th><label class="join_input">대표자명</label></th>
							<th><input type="text" placeholder="대표자명" value="<%=session.getAttribute("representName") %>" readonly/></th>
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
							<th><input type="email" placeholder="Email" value="<%=session.getAttribute("email") %>" readonly></th>
						</tr>
						<tr>
							<th><label class="join_input">주소</label></th>
							<th><input type="text" placeholder="주소"></th>
						</tr>
						<tr>
							<th><label class="join_input">업체선택</label></th>
							<th><label for="company">건설업체</label> <input type="radio"
								name="company" id="CSC" value="건설업체" /> <label for="중기업체">중기업체</label>
								<input type="radio" name="company" id="HEC" value="중기업체" /></th>
						</tr>
					</table>
				</fieldset>
				<br>
				<fieldset>
					<legend>상세정보 입력</legend>
					<div class="companySelector">
						<h2>업체를 선택해주세요.</h2>
					</div>
				</fieldset>
				<br>
				<button class="join_input_push">가입</button>
				<button class="join_input_push">취소</button>
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#CSC")
			.on("click",function() {$(".companySelector")
								.html("<label class='join_input'>"+ "연매출"+ "</label><input type='text'placeholder='연매출'>"
									+ "<br><label class='join_input'>"+ "연수주량"+"</label><input type='text'placeholder='연 수주량'>"
									+ "<br><div class='license'><label class='join_input'>"+"자격증"+"</label><input type='text'placeholder='자격증 명칭'>"
									+ "<input type='text'placeholder='발급처'>"+"<input type='date'placeholder='발급시기'><button id='btn2'>"+"추가"+"</button></div>"
									+ "<br><label class='join_input'>"+"회사규모"+"</label><input type='text'placeholder='회사 규모'>"
									+ "<br><label class='join_input'>"+"회사분야"+"</label><br>"
									+ "<input type='checkbox' name='category' value='토건'>"
									+ "<label class='category_input'>토건</label>"
									+ "<input type='checkbox' name='category' value='토목'>"
									+ "<label class='category_input'>토목</label>"
									+ "<input type='checkbox' name='category' value='건축'>"
									+ "<label class='category_input'>건축</label>"
									+ "<input type='checkbox' name='category' value='산업설비'>"
									+ "<label class='category_input'>산업설비</label>"
									+ "<input type='checkbox' name='category' value='토공'>"
									+ "<label class='category_input'>토공</label>"
									+ "<input type='checkbox' name='category' value='철콘'>"
									+ "<label class='category_input'>철콘</label>"
									+ "<input type='checkbox' name='category' value='금속구조'>"
									+ "<label class='category_input'>금속구조</label>"
									+ "<input type='checkbox' name='category' value='철강'>"
									+ "<label class='category_input'>철강</label>"
									+ "<input type='checkbox' name='category' value='시설물'>"
									+ "<label class='category_input'>시설물</label>"
									+ "<input type='checkbox' name='category' value='주택건설'>"
									+ "<label class='category_input'>주택건설</label>"
									+ "<input type='checkbox' name='category' value='문화재'>"
									+ "<label class='category_input'>문화재</label>"
									+ "<input type='checkbox' name='category' value='해외'>"
									+ "<label class='category_input'>해외</label>"
									+ "<input type='checkbox' name='category' value='기타'>"
									+ "<label class='category_input'>기타</label>"
									);
					});

	$("#HEC").on("click",function() {
		$(".companySelector")
			.html("<div class='companyHeavy'><select id='type' name='type'><option value=''>차량선택</option>"
					+"<option value='트럭'>트럭</option>"
					+"<option value='로더'>로더</option>"
					+"<option value='그레이더'>그레이더</option>"
					+"<option value='트랙'>트랙</option>"
					+"<option value='스크레이퍼'>스크레이퍼</option>"
					+"<option value='스키더'>스키더</option>"
					+"<option value='물질핸들러'>물질 핸들러</option>"
					+"<option value='벌목용장비'>벌목용 장비</option>"
					+"<option value='휠도저'>휠 도저</option>"
					+"<option value='굴삭기'>굴삭기</option>"
					+"<option value='펌프카'>펌프카</option></select>"
					+ "<select id='size' name='size'><option value=''>차량 크기</option>"
					+"<option value='소'>소</option>"
					+"<option value='중'>중</option>"
					+"<option value='대'>대</option></select>"
					+ "<input type='text' placeholder='차량 번호'>"
					+ "<button id='btn1'>추가</button></div>");
	});

	$(document).on("click","#btn1",	function(e) {
		e.preventDefault();
		$(".companySelector").append(
				"<div class='companyHeavy'><select id='type' name='type'><option value=''>차량선택</option>"
				+"<option value='트럭'>트럭</option>"
				+"<option value='로더'>로더</option>"
				+"<option value='그레이더'>그레이더</option>"
				+"<option value='트랙'>트랙</option>"
				+"<option value='스크레이퍼'>스크레이퍼</option>"
				+"<option value='스키더'>스키더</option>"
				+"<option value='물질핸들러'>물질 핸들러</option>"
				+"<option value='벌목용장비'>벌목용 장비</option>"
				+"<option value='휠도저'>휠 도저</option>"
				+"<option value='굴삭기'>굴삭기</option>"
				+"<option value='펌프카'>펌프카</option></select>"
				+"<select id='size' name='size'><option value=''>차량 크기</option>"
				+"<option value='소형'>소형</option>"
				+"<option value='중형'>중형</option>"
				+"<option value='대형'>대형</option></select>"
				+"<input type='text' placeholder='차량 번호'></div>");
	});
	$(document).on("click","#btn2",	function(e) {
		e.preventDefault();
		$(".license").append("<div class='license_add'>"
		+"<input type='text'placeholder='자격증 명칭'><input type='text'placeholder='발급처'><input type='date'placeholder='발급시기'>"
		+"</div>");
	});
	
	$(document).on("click","#type",	function(){
		var type = $("#type").val();
		console.log("들어옴!");
		if(type=="펌프카"){
			$("#size").html("<option value=''>"+"장비크기"+"</option>"
					+"<option value='26m'>"+"26m"+"</option>"
					+"<option value='32m'>"+"32m"+"</option>"
					+"<option value='37m'>"+"37m"+"</option>"
					+"<option value='43m'>"+"43m"+"</option>"
					+"<option value='52m'>"+"52m"+"</option>"
					+"<option value='58m'>"+"58m"+"</option>"
					+"<option value='기타'>"+"기타"+"</option>");
		}else if(type=="트럭"){
			$("#size").html("<option value=''>"+"장비크기"+"</option>"
					+"<option value='10톤'>"+"10톤이상"+"</option>"
					+"<option value='20톤'>"+"20톤이상"+"</option>"
					+"<option value='30톤'>"+"30톤이상"+"</option>"
					+"<option value='40톤'>"+"40톤이상"+"</option>"
					+"<option value='기타'>"+"기타"+"</option>");
		}else if(type=="굴삭기"){
			$("#size").html("<option value=''>"+"장비크기"+"</option>"
					+"<option value='소형굴삭기'>"+"소형굴삭기"+"</option>"
					+"<option value='농용굴삭기'>"+"농용굴삭기"+"</option>"
					+"<option value='백호굴삭기'>"+"백호굴삭기"+"</option>"
					+"<option value='브레이커굴삭기'>"+"브레이커 굴삭기"+"</option>"
					+"<option value='기타'>"+"기타"+"</option>");
		}else{
			$("#size").html("<option value=''>"+"장비크기"+"</option>"
					+"<option value='소형'>"+"소형"+"</option>"
					+"<option value='중령'>"+"중형"+"</option>"
					+"<option value='대형'>"+"대형"+"</option>"
					+"<option value='기타'>"+"기타"+"</option>");
		}
	});
	
</script>
</html>