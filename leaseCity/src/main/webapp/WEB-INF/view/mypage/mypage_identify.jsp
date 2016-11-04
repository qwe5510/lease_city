<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>.
	<div class="mypage">
	<div class="mypage_menu">
	</div>
	<div class="mypage_main">
		<c:url value="/myinfo" var="myinfo"/>
		 <sform:form id="mypage_identify_form" method="post" modelAttribute="user" action="${myinfo }">
            <fieldset>
               <legend>기본정보 입력</legend>
               <table>
                  <tr>
                     <td><sform:label path="userId" class="join_input">아이디</sform:label></td>
                     <td><sform:input path="userId" readonly="true"/>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="password" class="join_input">비밀번호변경</sform:label></td>
                     <td><sform:input path="password" type="password" onblur="passvali()"/>
                        <span id= "vali" class="password">영어 숫자 특수문자 혼용 8~16글자</span>
                        </td>
                  </tr>
                  <tr>
                     <td><sform:label path="password" class="join_input">비밀번호확인</sform:label></td>
                     <td><input type="password" placeholder="패스워드 확인" id="password2" name="password2" onblur="passvali()"/>
                     <span id= "vali" class="password2"></span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="companyName" class="join_input">업체명</sform:label></td>
                     <td><sform:input path="companyName"  readonly="true" /></td>
                  </tr>
                  <tr>
                     <td><sform:label path="representName" class="join_input">대표자명</sform:label></td>
                     <td><sform:input path="representName"  readonly="true"/></td>
                  </tr>
                  <tr>
                  </tr>
                  <tr>
                     <td><sform:label path="representPhone" class="join_input">대표자연락처</sform:label></td>
                     <td><input type="text" name="representPhone" id="representPhone" placeholder="ex)031-xxx-xxxx">
                     <span id= "vali" class="representPhone">-포함 국번으로 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="handPhone" class="join_input">휴대폰연락처</sform:label></td>
                     <td><input type="text" name="handPhone" id="handPhone" placeholder="ex)010-xxxx-xxxx">
                     <span id= "vali" class="handPhone">-포함 11~12자리 핸드폰 번호 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="email" class="join_input">Email</sform:label></td>
                     <td><sform:input path="email" readonly="true"/> </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input">주소</sform:label></td>
                     <td><input type="text" name="zipNo" id="zipNo" placeholder="우편번호" readonly="readonly">
                     <button id="addressSearch">주소검색</button>
                     <span id= "vali" class="addressInput"></span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input"> </sform:label></td>
                     <td><div class="address"><input type="text" name="address" id="address" placeholder="주소" readonly="readonly"></div></td>
                  </tr>
                  <tr>
                     <td><sform:label path="url" class="join_input">URL</sform:label></td>
                     <td><input type="text" name="url" id="url" placeholder="홈페이지 주소">
                     <span id= "vali" class="url">사이트 주소 형식으로 입력(혹은 공백)</span>
                     </td>
                  </tr>
               </table>
            </fieldset>
            <br>
            <fieldset>
			   <c:choose>
			   		<c:when test="${compare eq '건설'}">
			   		<sform:form id="mypage_identify_cc" action="#" method="post" modelAttribute="constructionCompany">
               			<div class="companySelector">
               			<div>
               			<sform:label path="yearlySale">연매출</sform:label>
               			<sform:input path="yearlySale" type="number"/>
               			<span class="sales">단위(억)</span>
               			</div>
               			<div>
               			<sform:label path="yearlyAoor">연수주량</sform:label>
               			<sform:input path="yearlyAoor" type="number"/>
               			<span class="obtain">단위(건)</span>
               			</div>
               			<sform:label path="licenseList">자격증</sform:label>
               			<sform:input path="licenseList"/> <sform:input path="licenseList"/> <sform:input path="licenseList"/>
               			</div>
               			<div>
               			<sform:label path="companyCategory">회사분류</sform:label>
               			<br>
               			<sform:checkbox class="cc_label" path="companyCategory" value="토건" label="토건"/>
                    	<sform:checkbox class="cc_label" path="companyCategory" value="토목" label="토목" />
                     	<sform:checkbox class="cc_label" path="companyCategory" value="건축" label="건축"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="산업설비" label="산업설비"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="토공" label="토공"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="철콘" label="철콘"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="금속구조" label="금속구조"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="철강" label="철강"/>
                     	<sform:checkbox class="cc_label" path="companyCategory" value="시설물" label="시설물" />
                     	<sform:checkbox class="cc_label" path="companyCategory" value="주택건설" label="주택건설" />
                     	<sform:checkbox class="cc_label" path="companyCategory" value="문화재" label="문화재" />
                     	<sform:checkbox class="cc_label" path="companyCategory" value="해외" label="해외" />
                     	<sform:checkbox class="cc_label" path="companyCategory" value="기타" label="기타" />
               			</div>
             			<div class="checked"></div>
             		</sform:form>	
			   		</c:when>
			   		<c:otherwise>
			   			<sform:form action="#" method="post" modelAttribute="heavyEquipmentCompany">
			   			<div>
			   			<sform:label path="helpOnOff">알람여부</sform:label>
			   			<sform:checkbox path="helpOnOff" value="업무대기" label="도움여부"/>
			   			<sform:checkbox path="infoOnOff" value="정보공개" label="정보공개"/>
			   			</div>
               			<div>
               			<label>차량추가</label>
               			<select id="type" name="type">
               				<option value="트럭">트럭</option>
               				<option value="로더">로더</option>
               				<option value="그레이더">그레이더</option>
               				<option value="트랙">트랙</option>
               				<option value="스크레이퍼">스크레이퍼</option>
               				<option value="스키더">스키더</option>
               				<option value="물질핸들러">물질핸들러</option>
               				<option value="벌목용장비">벌목용장비</option>
               				<option value="휠도저">휠도저</option>
               				<option value="굴삭기">굴삭기</option>
               				<option value="펌프카">펌프카</option>
               			</select>
               			<select id="size" name="size">
               				<option value="소형">소형</option>
               				<option value="중형">중형</option>
               				<option value="대형">대형</option>
               			</select>
               			<input type="text" id="carNum" placeholder="차량번호"/>
               			<button id="mypage_identify_add">추가</button>
               			</div>
               			<div class="numbervali"></div>
               			<div>
               				<div><sform:label path="heavyEquipmentList">차량보유현황</sform:label></div>
               				<div>
               				<div id="mypage_identify_carown">
               						<div>
               						<label>차량 분류</label>
               						<label>차량번호</label>
               						<label>삭제가능</label>
               						<label>삭제</label>
               						</div>
               						<div>
               						<label>트럭/소형</label>
               						<label>30가 1111</label>
               						<label>Y</label>
               						<label><sform:button id="mypage_identify_remove">삭제</sform:button></label>
               						</div>
               				</div>
               				</div>
               			</div>
             			<div class="checked">
             			</div>
             			</sform:form>
			   		</c:otherwise>
			   </c:choose>
            </fieldset>
            <br>
            <sform:button id="mypage_identify_confirm">확인</sform:button>
            <sform:button id="mypage_identify_cancel">취소</sform:button>
         </sform:form>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
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
 $(document).on("click","#mypage_identify_remove",function(e){
	 e.preventDefault();
	 $(this).parent().parent().remove();
 });

 $("#mypage_identify_add").on("click",function(e){
	 e.preventDefault();
	 var carNum = $("#carNum").val();
	 var size = $("#size").val();
	 var type = $("#type").val();
	 var regIdNumber = /^[0-9]{2}[가-힣] [0-9]{4}$/;
	 if(!regIdNumber.test(carNum)){
		 $(".numbervali").html("올바르지 않은 차량번호 입니다<br>[ex)30가 1000]");
	 }else{
		 $(".numbervali").html("");
		 $("#carNum").val("");
		 $("#mypage_identify_carown").append("<div><label>"+type+"/"+size+"</label><label>"+carNum+"</label><label>Y</label><label><button id='mypage_identify_remove'>삭제</button></label>")
		 .append("<input type='hidden' name='equipmentType' value='"+ type +"'> ")
         .append("<input type='hidden' name='equipmentSize' value='"+ size +"'> ")
         .append("<input type='hidden' id='idNumber' name='idNumber' value='"+ carNum +"'> ");
	 } 
 });
  $(document).on("click","#mypage_identify_confirm", function(){
	   var password = $("#password").val();
	   var password2 = $("#password2").val();
	   var representPhone = $("#representPhone").val();
	   var handPhone =$("#handPhone").val();
	   var url = $("#url").val();
	   var address = $("#address").val();
	   var sales = $("#sales").val();
	   var obtain = $("#obtain").val();
	   var num = $("#num").val();
	   var idNumber = $("#idNumber").val();
	   var yearlySale = $("#yearlySale").val();
	   var yearlyAoor = $("#yearlyAoor").val();
	   var companyCategory = $("input:checkbox[name='companyCategory']").is(":checked");
	   
	 //특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	   var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	   if(!passRegExp.test(password)){
	      $(".password").html("패스워드 조건 불일치");
	      $(".password").css("color", "#FF0000");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	      return false;
	   }else if(password2==""){
	      $(".password").html("패스워드 확인값을 입력해주세요.");
	      $(".password").css("color", "#FF0000");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	      return false;
	   }else if(password != password2){
	      $(".password").html("패스워드가 일치하지 않습니다.");
	      $(".password").css("color", "#FF0000");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	      return false;
	   }else if(password == password2) {
	      $(".password").html("패스워드가 확인되었습니다.");
	      $(".password").css("color", "#0000FF");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	   }
	   
	 //일반전화 정규표현식
	   var repreRegExp = /^(02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;
	   
	   if(!repreRegExp.test(representPhone)){
	      $(".representPhone").html("연락처 조건 불일치 (-포함 국번으로 입력)");
	      $(".representPhone").css("color", "#FF0000");
	      return false;
	   }else if(repreRegExp.test(representPhone)){
	      $(".representPhone").html("연락처 조건 일치되었습니다.");
	      $(".representPhone").css("color", "#0000FF");
	   }
	   
	   //핸드폰 정규표현식 01다음 숫자 0~9 숫자 포함
	   var phoneRegExp = /^(01[016789]{1})-[0-9]{3,4}-[0-9]{4}$/;
	   if(!phoneRegExp.test(handPhone)){
	      $(".handPhone").html("연락처 조건 불일치 (-포함 11~12자리 번호)");
	      $(".handPhone").css("color", "#FF0000");
	      return false;
	   }else if(phoneRegExp.test(handPhone)){
	      $(".handPhone").html("연락처 조건 일치합니다.");
	      $(".handPhone").css("color", "#0000FF");
	   }

	   //주소 입력검사
	   if(address==null || address==""){
	      $(".addressInput").html("주소 필수입력");
	      $(".addressInput").css("color", "#FF0000");
	      return false;
	   }else if(address!=""){
	      $(".addressInput").html("");
	   }
	   
	   //url 정규 표현식 
	   var urlRegExp = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w_\.-]*)*\/?$/;
	   if(url==""){
	      $(".url").html("url 형식 일치합니다.");
	      $(".url").css("color", "#0000FF");
	   }
	   else if(!urlRegExp.test(url)){
	      $(".url").html("url 형식 불일치");
	      $(".url").css("color", "#FF0000");
	      return false;
	   }else if(urlRegExp.test(url)){
	      $(".url").html("url 형식 일치합니다.");
	      $(".url").css("color", "#0000FF");
	   }
	   
	   if(idNumber==null){
		   $(".numbervali").html("중장비는 최소 1개 이상 있어야합니다.");
		   $(".numbervali").css("color", "#FF0000");
		      return false;
		}
	   console.log("내가 왜 남아있게?");
	   /* //연매출, 연 수주량 검사
	   var sOReg = /^[1-9][0-9]*$/;
	   
	   if(!sOReg.test(yearlySale)){
	         $(".sales").html("연매출 필수 입력 억단위로 입력");
	         $(".sales").css("color", "#FF0000");
	         return false;
	      }else{
	         $(".sales").html("단위(억)");
	         $(".sales").css("color", "#000000");
	      }
	      
	      //연 수주량 공백검사
	      if(!sOReg.test(yearlyAoor)){
	         $(".obtain").html("연수주량 필수 입력 건단위로 입력");
	         $(".obtain").css("color", "#FF0000");
	         return false;
	      }else{
	         $(".obtain").html("단위(건)");
	         $(".obtain").css("color", "#000000");
	      }
	      if(companyCategory==null){
	    	  console.log("companyCategory 들어옴");
	    	  $(".checked").html("최소 1개 분야를 선택하셔야 합니다.");
	      }else{
	    	  console.log("서밋");
	    	  $("#mypage_identify_form").submit();
	      } */
 });
  
  
 function passvali(){
	   var password = $("#password").val();
	   var password2 = $("#password2").val();
	   
	   //특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	   var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	   if(!passRegExp.test(password)){
	      $(".password").html("패스워드 조건 불일치");
	      $(".password").css("color", "#FF0000");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	   }else if(password2==""){
	      $(".password").html("패스워드 확인값을 입력해주세요.");
	      $(".password").css("color", "#0000FF");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	   }else if(password != password2){
	      $(".password").html("패스워드가 일치하지 않습니다.");
	      $(".password").css("color", "#FF0000");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	   }else if(password == password2) {
	      $(".password").html("패스워드가 확인되었습니다.")
	      $(".password").css("color", "#0000FF");
	      $(".password2").html("영어 숫자 특수문자 혼용 8~16글자");
	   }
	}
  $(document).on("click","#addressSearch",function(e) {
     e.preventDefault();
     var result = window.open("<%=request.getContextPath()%>/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
  });
  
  function jusoCallBack(roadFullAddr,zipNo){
     $("#address").val(roadFullAddr);
     $("#zipNo").val(zipNo);
  }
  
  
 <c:url value="/myinfo" var="myinfo"/>
 $("#mypage_identify_cancel").on("click",function(e){
	 e.preventDefault();
	 location.href = "${myinfo}";
 });
</script>
</html>