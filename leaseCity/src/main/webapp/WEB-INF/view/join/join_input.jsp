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
			<form id="joinForm" method="post" action="<%=request.getContextPath() %>/login" onsubmit="return validateform()">
				<fieldset>
					<legend>기본정보 입력</legend>
					<table>
						<tr>
							<td><label class="join_input">아이디</label></td>
							<td><input type="text" placeholder="아이디" name="userId" id="userId"/>
							<span id= "vali" class="userId">영어 숫자 혼용 6~15글자 </span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">비밀번호</label></td>
							<td><input class="join_input" type="password"
								placeholder="패스워드" name="password" id="password"  onblur="passvali()"/>
								<span id= "vali" class="password">영어 숫자 특수문자 혼용 8~16글자</span>
								</td>
						</tr>
						<tr>
							<td><label class="join_input">비밀번호확인</label></td>
							<td><input type="password" placeholder="패스워드 확인" id="password2" name="password2"  onblur="passvali()"/>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">업체명</label></td>
							<td><input type="text" name="companyName" id="companyName" placeholder="업체명" value="<%=session.getAttribute("companyName") %>" readonly /></td>
						</tr>
						<tr>
							<td><label class="join_input">대표자명</label></td>
							<td><input type="text" name="representName" id="representName" placeholder="대표자명" value="<%=session.getAttribute("representName") %>" readonly/></td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td><label class="join_input">대표자연락처</label></td>
							<td><input type="text" name="representPhone" id="representPhone" placeholder="ex)031471xxxx">
							<span id= "vali" class="representPhone">ex)031471xxxx</span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">휴대폰연락처</label></td>
							<td><input type="text" name="handPhone" id="handPhone" placeholder="ex)010xxxxxxxx">
							<span id= "vali" class="handPhone">ex)010xxxxxxxx</span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">Email</label></td>
							<td><input type="email" name="email" id="email" placeholder="Email" value="<%=session.getAttribute("email") %>" readonly></td>
						</tr>
						<tr>
							<td><label class="join_input">주소</label></td>
							<td><input type="text" name="zipNumber" id="zipNumber" placeholder="우편번호" readonly="readonly">
							<button id="addressSearch">주소검색</button>
							<span id= "vali" class="addressInput"></span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input"> </label></td>
							<td><div class="address"><input type="text" name="address" id="address" placeholder="주소" readonly="readonly"></div></td>
						</tr>
						<tr>
							<td><label class="join_input">URL</label></td>
							<td><input type="text" name="url" id="url" placeholder="홈페이지 주소">
							<span id= "vali" class="url"></span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">업체선택</label></td>
							<td><label for="company">건설업체</label> <input type="radio"
								name="company" id="CSC" value="건설업체" checked="checked"/> <label for="중기업체">중기업체</label>
								<input type="radio" name="company" id="HEC" value="중기업체" /></td>
								<td><div id="vali" class="company"></div></td>
						</tr>
					</table>
				</fieldset>
				<br>
				<fieldset>
					<legend>상세정보 입력</legend>
					<div class="heavy" ></div>
					<div class="companySelector">
					</div>
					<div class="numbervali"></div>
					<div class="checked"></div>
				</fieldset>
				<br>
				<input type="submit" formaction="<%=request.getContextPath() %>/join" formmethod="post" value="가입">
				<input type="submit" formaction="<%=request.getContextPath() %>/join_cancle" formmethod="get" value="취소">
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

//====================================================================================================================================================================================
//건설업체 상세정보 추가 
function cscInfoOutput(){
	var str1 ="<label class='join_input'>"+ "연매출"+ "</label><input id='sales' name='sales' type='number' placeholder='연매출'><span id= 'vali' class='sales'>단위(억)</span>";
	var str2 ="<br><label class='join_input'>"+ "연수주량"+"</label><input id='obtain' name='obtain' type='number'placeholder='연 수주량'><span id= 'vali' class='sales'>단위(건)</span>";
	var str3 ="<br><div class='license'><label class='join_input'>"+"자격증"+"</label><input type='text'placeholder='자격증 명칭'>";
	var str4 ="<input type='text'placeholder='발급처'>"+"<input type='date'placeholder='발급시기'><button id='btn2'>"+"추가"+"</button></div>";
	var str6 ="<br><label class='join_input'>"+"회사분야"+"</label><br>";
	var str7 ="";
	var str8 ="";
	var arr = ["토건","토목","건축","산업설비","토공","철콘","금속구조","철강","시설물","주택건설","문화재","해외","기타"];
	for(var i of arr){
		str6+="<input type='checkbox' name='category' value='"+i+"'>"
			  +"<label class='category_input'>"+i+"</label>";
	}
	$(".heavy").html("");
	$(".companySelector").html(str1+str2+str3+str4+str6);
}

//중기업체 상세정보 추가
function hecInfoOutput(){
	var str1 = "<select id='type' name='type'>";
	var str2  = "<select id='size' name='size'>";
	var str3 = "<div class='companyHeavy'>";
	var str4 = "<button id='btn1'>추가</button></div>";
	var arr= ["트럭","로더","그레이더","트랙","스크레이퍼","스키더","물질핸들러","벌목용장비","휠도저","굴삭기","펌프카"];
	var arr2= ["소형","중형","대형"];
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
}
//====================================================================================================================================================================================

	//건설업체, 중기업체에 대한 이벤트 처리.
	$("#CSC").on("click", cscInfoOutput);
	$("#HEC").on("click", hecInfoOutput);
	$(document).on("ready", cscInfoOutput);
	
//회원가입 양식검사.
function validateform() {
	var password = $("#password").val();
	var password2 = $("#password2").val();
	var userId = $("#userId").val();
	var representPhone = $("#representPhone").val();
	var handPhone =$("#handPhone").val();
	var url = $("#url").val();
	var address = $("#address").val();
	var sales = $("#sales").val();
	var obtain = $("#obtain").val();
	var num = $("#num").val();
	
	//ID 4글자 15글자
	var idRegExp = /^[a-zA-Z0-9_]{6,15}$/; 
	if(!idRegExp.test(userId)){
		$(".userId").html("아이디 조건 불일치 ");
		return false;
	}else if(idRegExp.test(userId)){
		$(".userId").html("아이디 조건이 일치합니다.");
	}
	
	//특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	if(!passRegExp.test(password)){
		$(".password").html("패스워드 조건 불일치");
		return false;
	}else if(password2==""){
		$(".password").html("패스워드 확인값을 입력해주세요.");
		return false;
	}else if(password != password2){
		$(".password").html("패스워드가 일치하지 않습니다.");
		return false;
	}else if(password == password2) {
		$(".password").html("패스워드가 확인되었습니다.")
	}	
	
	//일반전화 정규표현식
	var repreRegExp = /^(02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
	if(!repreRegExp.test(representPhone)){
		$(".representPhone").html("연락처 조건 불일치");
		return false;
	}else if(repreRegExp.test(representPhone)){
		$(".representPhone").html("연락처 조건 일치되었습니다.");
	}
	
	//핸드폰 정규표현식 01다음 숫자 0~9 숫자 포함
	var phoneRegExp = /^(01[016789]{1})[0-9]{7,8}$/;
	if(!phoneRegExp.test(handPhone)){
		$(".handPhone").html("연락처 조건 불일치");
		return false;
	}else if(phoneRegExp.test(handPhone)){
		$(".handPhone").html("연락처 조건 일치합니다.");
	}
	
	//url 정규 표현식 
	var urlRegExp = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w_\.-]*)*\/?$/;
	if(url==""){}
	else if(!urlRegExp.test(url)){
		$(".url").html("url 형식 불일치");
		return false;
	}else if(urlRegExp.test(url)){
		$(".url").html("url 형식 일치합니다.");
	}
	
	//주소 입력검사
	if(address==null || address==""){
		$(".addressInput").html("주소 필수입력");
		return false;
	}
	
	//연매출  공백검사
	if(sales==null || sales==""){
		$(".sales").append("연매출 필수 입력 억단위로 입력");
		return false;
	}
	//연 수주량 공백검사
	if(obtain==null || obtain==""){
		$(".obtain").append("연수주량 필수 입력 건단위로 입력");
		return false;
	}
	//중기업체 차량번호 공백검사
	if(num==null || num==""){
		$(".checked").html("차량번호를 입력해주세요.");
		return false;
	}
}

//password 검사
function passvali(){
	var password = $("#password").val();
	var password2 = $("#password2").val();
	
	//특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	if(!passRegExp.test(password)){
		$(".password").html("패스워드 조건 불일치");
		return false;
	}else if(password2==""){
		$(".password").html("패스워드 확인값을 입력해주세요.");
		return false;
	}else if(password != password2){
		$(".password").html("패스워드가 일치하지 않습니다.");
		return false;
	}else if(password == password2) {
		$(".password").html("패스워드가 확인되었습니다.")
	}
}

	
	$(document).on("click","#btn1",	function(e) {
		e.preventDefault();
		var type = $("#type").val();
		var size = $("#size").val();
		var num = $("#num").val();
		if(num==null || num==""){
			$(".numbervali").html("차량번호 필수입력사항");
		}else{
			$(".numbervali").html("");
			$(".checked").append("<div>중장비 : "+type+"  차량크기 : "+size+"  차량번호 : "+num+"</div>");
		}
		
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
		var arr1 = ["26m","32m","37m","43m","52m","58m","기타"];
		var arr2 = ["10톤","20톤","30톤","40톤","기타"];
		var arr3 = ["소형굴삭기","농용굴삭기","백호굴삭기","브레이커굴삭기","기타"];
		var arr4 = ["소형","중형","대형"];
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
	
	
	<c:url value="/validate_id" var="validate_id"/>
	$("#userId").blur(function() {
		
		var input_userId = $("#userId").val();
		var saved_userId = '${saved_userId}';
		
		$.ajax({
	        // type을 설정합니다.
	        type : 'post',
	        url : "${validate_id }",
	        // 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
	        data : {
	        	input_userId : input_userId
	        },
	        // 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
	        success : function (data) {
	            // 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
	            if (data == true) {
	            	//$("#userId").val('');
	            	//$("#userId").val(input_userId + ' (이미 등록된 아이디) ');
	            	$("#userId").css("color", "red");
	            	$("#vali").css("color", "red");
	                //alert(data); 
	            } else if (data == false) {
	            	//$("#userId").val('');
	            	//$("#userId").val(input_userId + ' (등록 가능 아이디) ');
	            	$("#userId").css("color", "green");
	            	$("#vali").css("color", "green");
	            }      
	        },
	        error : function(xhr, status, error) {
				alert(error);
			}
	    });
	});



	
	$(document).on("click","#addressSearch",function(e) {
		e.preventDefault();
		var result = window.open("<%=request.getContextPath()%>/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes")
	});
	
	function jusoCallBack(roadFullAddr,zipNo){
		$("#address").val(roadFullAddr);
		$("#zipNumber").val(zipNo);
	}
</script>
</html>