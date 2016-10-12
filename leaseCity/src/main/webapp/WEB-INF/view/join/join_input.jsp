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
			<form id="joinForm" method="post" action="<%=request.getContextPath() %>/login">
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
					<div class="heavy"></div>
					<div class="companySelector">
						<h2>업체를 선택해주세요.</h2>
					</div>
					<div class="checked"></div>
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
<script src="js/validation/lib/jquery.js"></script>
<script src="js/validation/dist/jquery.validate.js"></script>
<script>
	$("#CSC").on("click",function(){
		var str1 ="<label class='join_input'>"+ "연매출"+ "</label><input type='text'placeholder='연매출'>";
		var str2 ="<br><label class='join_input'>"+ "연수주량"+"</label><input type='text'placeholder='연 수주량'>";
		var str3 ="<br><div class='license'><label class='join_input'>"+"자격증"+"</label><input type='text'placeholder='자격증 명칭'>";
		var str4 ="<input type='text'placeholder='발급처'>"+"<input type='date'placeholder='발급시기'><button id='btn2'>"+"추가"+"</button></div>";
		var str5 ="<br><label class='join_input'>"+"회사규모"+"</label><input type='text'placeholder='회사 규모'>";
		var str6 ="<br><label class='join_input'>"+"회사분야"+"</label><br>";
		var str7 ="";
		var str8 ="";
		var arr = ["토건","토목","건축","산업설비","토공","철콘","금속구조","철강","시설물","주택건설","문화재","해외","기타"];
		for(var i of arr){
			str6+="<input type='checkbox' name='category' value='"+i+"'>"
				  +"<label class='category_input'>"+i+"</label>";
		}
		$(".heavy").html("");
		$(".companySelector").html(str1+str2+str3+str4+str5+str6);
	});

	$("#HEC").on("click",function() {
		var str1 = "<select id='type' name='type'>";
		var str2  = "<select id='size' name='size'>";
		var str3 = "<div class='companyHeavy'>";
		var str4 = "<button id='btn1'>추가</button></div>";
		var arr= ["차량선택","트럭","로더","그레이더","트랙","스크레이퍼","스키더","물질핸들러","벌목용장비","휠도저","굴삭기","펌프카"];
		var arr2= ["차량크기","소형","중형","대형"];
		for(var i of arr){
			str1+="<option value='"+i+"'>"+i+"</option>";
		}
		 for(var i of arr2){
			str2+="<option value='"+i+"'>"+i+"</option>";
		} 
		str1+="</select>";
		str2+="</select>";
		var text = "<input type='text' id='num' name='num' placeholder='차량 번호'>";
		
		var srt5 ="<lable clas='alarm'>알람여부 </lable>"
					+"<label class='help_input'>도움여부</label>"	
					+"<input type='checkbox' id='help' name='help' value='help'>";
		var str6 = "<label class='help_input'>정보공개</label>"	
					+"<input type='checkbox' id='info' name='info' value='info'>";	
		$(".heavy").html(srt5+str6);
		$(".companySelector").html(str3+str1+str2+text+str4);
	});
	$(document).on("click","#btn1",	function(e) {
		e.preventDefault();
		var type = $("#type").val();
		var size = $("#size").val();
		var num = $("#num").val();
		$(".checked").append("<div>중장비 : "+type+"  차량크기 : "+size+"  차량번호 : "+num+"</div>");
	});
	
	$(document).on("click","#btn2",	function(e) {
		e.preventDefault();
		$(".license").append("<div class='license_add'>"
		+"<input type='text'placeholder='자격증 명칭'><input type='text'placeholder='발급처'><input type='date'placeholder='발급시기'>"
		+"</div>");
	});
	var s = 0;
	$(document).on("click","#type",function(){
		var type = $("#type").val();
		var arr1 = ["장비크기","26m","32m","37m","43m","52m","58m","기타"];
		var arr2 = ["장비크기","10톤","20톤","30톤","40톤","기타"];
		var arr3 = ["장비크기","소형굴삭기","농용굴삭기","백호굴삭기","브레이커굴삭기","기타"];
		var arr4 = ["장비크기","소형","중형","대형"];
		var str1="";
		var str2="";
		var str3="";
		var str4="";
		for(var i of arr1){
			str1+="<option value='"+i+"'>"+i+"</option>";
		}
		for(var i of arr2){
			str2+="<option value='"+i+"'>"+i+"</option>";
		}
		for(var i of arr3){
			str3+="<option value='"+i+"'>"+i+"</option>";
		}
		for(var i of arr4){
			str4+="<option value='"+i+"'>"+i+"</option>";
		}
		if(type=="펌프카"){
			$("#size").html(str1);
		}else if(type=="트럭"){
			$("#size").html(str2);
		}else if(type=="굴삭기"){
			$("#size").html(str3);
		}else{
			$("#size").html(str4);
		}
	});
	$(document).on("click","#help",	function(e) {
		var help = $("#help").val();
		console.log(help);
	});
	
</script>
</html>