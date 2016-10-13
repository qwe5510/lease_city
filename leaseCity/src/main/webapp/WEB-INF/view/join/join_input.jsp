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
			<form id="joinForm">
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
							<td><input type="text" name="representPhone" id="representPhone" placeholder="ex)031-xxx-xxxx">
							<span id= "vali" class="representPhone">-포함 국번으로 입력</span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">휴대폰연락처</label></td>
							<td><input type="text" name="handPhone" id="handPhone" placeholder="ex)010-xxxx-xxxx">
							<span id= "vali" class="handPhone">-포함 11~12자리 핸드폰 번호 입력</span>
							</td>
						</tr>
						<tr>
							<td><label class="join_input">Email</label></td>
							<td><input type="email" name="email" id="email" placeholder="Email" value="<%=session.getAttribute("email") %>" readonly></td>
						</tr>
						<tr>
							<td><label class="join_input">주소</label></td>
							<td><input type="text" name="zipNo" id="zipNo" placeholder="우편번호" readonly="readonly">
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
							<td><label class="join_input">알람 여부</label></td>
							<td><label for="notifyOnOff">ON</label> <input type="radio"
								name="notifyOnOff" value="ON" checked="checked"/> <label for="OFF">OFF</label>
								<input type="radio" name="notifyOnOff" value="OFF" /></td>
								<td><div id="vali" class="company"></div></td>
						</tr>
						<tr>
							<td><label class="join_input">업체선택</label></td>
							<td><label for="company">건설업체</label> 
							<input type="radio" name="company" id="CSC" value="건설업체" checked="checked"/> 
							<label for="중기업체">중기업체</label>
							<input type="radio" name="company" id="HEC" value="중기업체" />
							</td><td><div id="vali" class="company"></div></td>
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
				<input type="submit" formaction="<%=request.getContextPath() %>/join" formmethod="post" value="가입" onsubmit="return validateform()">
				<input type="submit" formaction="<%=request.getContextPath() %>/join_cancle" formmethod="get" value="취소" onsubmit="true">
			</form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

//====================================================================================================================================================================================
//건설업체 상세정보 추가

var CC_arr = ["토건","토목","건축","산업설비","토공","철콘","금속구조","철강","시설물","주택건설","문화재","해외","기타"];

function cscInfoOutput(){
	//중기업체 span 공백으로 설정
	$(".checked").html("");
	
	var str1 ="<label class='join_input'>"+ "연매출"+ "</label><input id='sales' name='yearlySale' type='number' min='0' placeholder='연매출'><span id= 'vali' class='sales'>단위(억)</span>";
	var str2 ="<br><label class='join_input'>"+ "연수주량"+"</label><input id='obtain' name='yearlyAoor' type='number' min='0' placeholder='연 수주량'><span id= 'vali' class='obtain'>단위(건)</span>";
	var str3 ="<br><div class='license'><label class='join_input'>"+"자격증"+"</label><input name='licenseName' type='text'placeholder='자격증 명칭'>";
	var str4 ="<input name='licenser' type='text'placeholder='발급처'>"+"<input name='licenseDate' type='date'placeholder='발급시기'><button id='btn2'>"+"추가"+"</button></div>";
	var str6 ="<br><label class='join_input'>"+"회사분야"+"</label><br>";
	var str7 ="";
	var str8 ="";
	for(var i of CC_arr){
		str6+="<input type='checkbox' id='" + i + "' name='companyCategory' value='"+i+"'>"
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
				+"<input type='checkbox' id='help' name='helpOnOff' value='help'>";
	var str6 = "<label class='help_input'>정보공개</label>"	
				+"<input type='checkbox' id='info' name='infoOnOff' value='info'>";	
	$(".heavy").html(srt5+str6);
	$(".companySelector").html(str3+str1+str2+text+str4);
}
//====================================================================================================================================================================================

	//건설업체, 중기업체에 대한 이벤트 처리.
	$("#CSC").on("click", cscInfoOutput);
	$("#HEC").on("click", hecInfoOutput);
	
	$(document).on("ready", function(){
		var isCSC = $("#CSC").attr("checked");
		var isHEC = $("#HEC").attr("checked");
		//CSC가 체크되어있으면  건설업체 상세정보 출력
		if(isCSC=="checked"){
			cscInfoOutput();
		}else if(isHEC=="checked"){
			hecInfoOutput();
		}		
	});

	//회원가입 양식검사.
	$("#joinForm").on("submit", function(e){
	
		var isChecked = validateform();
		var isDuplicated = ajaxIdCheck(); 
		
		if(!isChecked || !isDuplicated){
			e.preventDefault();
		}
					
	});
 
function validateform() {
	var password = $("#password").val();
	var password2 = $("#password2").val();
	var representPhone = $("#representPhone").val();
	var handPhone =$("#handPhone").val();
	var url = $("#url").val();
	var address = $("#address").val();
	var sales = $("#sales").val();
	var obtain = $("#obtain").val();
	var num = $("#num").val();
	var isHEC = $("#HEC")[0].checked;
	
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
		$(".password").html("패스워드가 확인되었습니다.");
	}	
	
	//일반전화 정규표현식
	var repreRegExp = /^(02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;
	
	if(!repreRegExp.test(representPhone)){
		$(".representPhone").html("연락처 조건 불일치 (-포함 국번으로 입력)");
		return false;
	}else if(repreRegExp.test(representPhone)){
		$(".representPhone").html("연락처 조건 일치되었습니다.");
	}
	
	//핸드폰 정규표현식 01다음 숫자 0~9 숫자 포함
	var phoneRegExp = /^(01[016789]{1})-[0-9]{3,4}-[0-9]{4}$/;
	if(!phoneRegExp.test(handPhone)){
		$(".handPhone").html("연락처 조건 불일치 (-포함 11~12자리 번호)");
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
	//중기업체 차량번호 공백검사
	
	if(isHEC){
		var hiddens = $("input[type=hidden]");
		if(hiddens.length <= 0){
			$(".numbervali").html("중장비는 최소 1개 이상 있어야합니다.");
			return false;
		}
	}
	
	//연매출  공백검사
	if(sales==0){
		$(".sales").html("연매출 필수 입력 억단위로 입력");
		return false;
	}else{
		$(".sales").html("단위(억)");
	}
	
	//연 수주량 공백검사
	if(obtain==0){
		$(".obtain").html("연수주량 필수 입력 건단위로 입력");
		return false;
	}else{
		$(".obtain").html("단위(건)");
	}
	
	var isChecked = false;
	for(var idx of CC_arr){
		var item = $("#"+idx)[0].checked
		if(item){
			isChecked = true;
		}
	}
	
	if(!isChecked){
		$(".checked").html("분야를 최소 1개 이상 선택해주세요.");
		return false;
	}else if(isChecked){
		$(".checked").html("");
	}
}

	<c:url value="/validateId" var="validateId"/>
	$("#userId").blur(ajaxIdCheck);
	function ajaxIdCheck() {   
	      var inputUserId = $("#userId").val();
	      var result = true; //결과를 리턴받는 변수  
	      $.ajax({
	           // type을 설정합니다.
	           type : 'post',
	           url : "${validateId }",
	           // 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
	           data : {inputUserId : inputUserId},
	           // 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
	           success : function (data) {
	               // 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
	             if (data == true) {
	             	//$("#userId").val('');
	                //$("#userId").val(input_userId + ' (이미 등록된 아이디) ');
	                $(".userId").html("이미 등록된 아이디 입니다.");
	                result = false;
	                //alert(data); 
	             } else if (data == false) {
	                //$("#userId").val('');
	                //$("#userId").val(input_userId + ' (등록 가능 아이디) ');		               
		            //ID 4글자 15글자
		            var userId = $("#userId").val();
		          	var idRegExp = /^[a-zA-Z0-9_]{6,15}$/; 
		           	if(!idRegExp.test(userId)){
		           		$(".userId").html("아이디 조건 불일치");
		           		result = false;
		           	}else if(idRegExp.test(userId)){
		           		$(".userId").html("등록 가능한 아이디입니다.");
		           	}		           	
		           	$(".userId").focus();
	             }      
	         },
	         error : function(xhr, status, error) {
	     	 alert(error);
		   }
		});
	    if(!result){
	    	return result;
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

	
	//중기업체 차량 추가 버튼 클릭 시 이벤트
	$(document).on("click","#btn1",	function(e) {
		e.preventDefault();
		var type = $("#type").val();
		var size = $("#size").val();
		var num = $("#num").val();
		
		//공백 포함 2자리 수, 한글 1글자, 4자리수인 값
		//Ex)30 바 3282
		var regIdNumber = /^[0-9]{2} [가-힣] [0-9]{4}$/;
		
		if(!regIdNumber.test(num)){
			$(".numbervali").html("올바르지 않은 차량번호 입니다<br>[ex)30 가 1000]");
		}else if(regIdNumber.test(num)){
			$(".numbervali").html("");
			$(".checked").append("<div>중장비 : "+type+"  차량크기 : "+size+"  차량번호 : "+num+"</div>")
			.append("<input type='hidden' name='equipmentType' value='"+ type +"'> ")
			.append("<input type='hidden' name='equipmentSize' value='"+ size +"'> ")
			.append("<input type='hidden' name='idNumber' value='"+ num +"'> ");
		}
		
	});
	
	$(document).on("click","#btn2",	function(e) {
		e.preventDefault();
		$(".license").append("<div class='license_add'>"
		+"<input name='licenseName' type='text'placeholder='자격증 명칭'><input name='licenser' type='text'placeholder='발급처'><input name='licenseDate' type='date'placeholder='발급시기'>"
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

		   
	$("#userId").click(function() {
		$("#userId").val('');
	 	$("#userId").css("color", "black");
	});
	
	
	$(document).on("click","#help",	function(e) {
		var help = $("#help").val();
		console.log(help);
	});
	
	$(document).on("click","#addressSearch",function(e) {
		e.preventDefault();
		var result = window.open("<%=request.getContextPath()%>/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes")
	});
	
	function jusoCallBack(roadFullAddr,zipNo){
		$("#address").val(roadFullAddr);
		$("#zipNo").val(zipNo);
	}
</script>
</html>