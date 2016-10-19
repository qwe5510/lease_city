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
         <form id="joinForm" method="post">
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
                     <td><input type="password" placeholder="패스워드 확인" id="password2" name="password2" onblur="passvali()"/>
                     <span id= "vali" class="password2"></span>
                     </td>
                  </tr>
                  <tr>
                     <td><label class="join_input">업체명</label></td>
                     <td><input type="text" name="companyName" id="companyName" placeholder="업체명" value="${companyName}" readonly /></td>
                  </tr>
                  <tr>
                     <td><label class="join_input">대표자명</label></td>
                     <td><input type="text" name="representName" id="representName" placeholder="대표자명" value="${representName}" readonly/></td>
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
                     <td><input type="email" name="email" id="email" placeholder="Email" value="${email}" readonly></td>
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
                     <span id= "vali" class="url">사이트 주소 형식으로 입력(혹은 공백)</span>
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
            <input type="submit" formaction="<%=request.getContextPath() %>/join" value="가입">
            <input type="submit" id="joinCancel" value="취소">
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
   var str3 ="<br><div class='license'><label class='join_input'>자격증</label><button id='btn2'>추가</button><span class='licenseCheck'>자격증은 최대 3개까지 작성 가능</span></div></div>";
   var str4 ="<br><label class='join_input'>"+"회사분야"+"</label><br>";
   var str6 ="";
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

   //자격증 개수
   var license_cnt=0;
   
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
   
   $("#joinCancel").on("click", function(e){
      e.preventDefault(); 
      var form = document.createElement("form");
      form.setAttribute("method", "post");
      form.setAttribute("action", "<%=request.getContextPath() %>/joinCancle")
      form.submit();
   });
   
   //회원가입 양식검사.
   $("#joinForm").on("submit", function(e){      
      var isChecked = validateform();
      var isDuplicated = ajaxIdCheck(); 
      
      if(!isDuplicated||!isChecked){
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
   
   //중기업체 차량번호 공백검사   
   if(isHEC){
      var hiddens = $("input[type=hidden]");
      if(hiddens.length <= 0){
         $(".numbervali").html("중장비는 최소 1개 이상 있어야합니다.");
         $(".numbervali").css("color", "#FF0000");
         return false;
      }
   }else{
      //연매출  공백검사
      if(sales==0){
         $(".sales").html("연매출 필수 입력 억단위로 입력");
         $(".sales").css("color", "#FF0000");
         return false;
      }else{
         $(".sales").html("단위(억)");
         $(".sales").css("color", "#000000");
      }
      
      //연 수주량 공백검사
      if(obtain==0){
         $(".obtain").html("연수주량 필수 입력 건단위로 입력");
         $(".obtain").css("color", "#FF0000");
         return false;
      }else{
         $(".obtain").html("단위(건)");
         $(".obtain").css("color", "#000000");
      }
      
      //한글,숫자,영어 - 자격증명칭, 발급처에만 사용
      var licenseRegExp = /^[가-힣0-9a-zA-Z-#)( ]{1,}$/
      var isLicense = true; //자격증 조건식 총괄 bool변수
      
      for(var i=1; i<=license_cnt; i++){
         var licenseName = $("#licenseName" + i).val();
         var licenser = $("#licenser" + i).val();
         var licenseDate = $("#licenseDate" + i).val();
         
         console.log("자격증이름" + i + " : " + licenseName);
         console.log("발급처" + i + " : " + licenser);
         console.log("발급날짜" + i + " : " + licenseDate);
         
         var check = $("#licenseCheck" + i);
         var str = "";
         
         if(!licenseRegExp.test(licenseName)){
            if(str==""){
               str += "자격증 명칭";
            }else{
               str += ", 자격증 명칭";
            }
            isLicense = false;
         }
         
         if(!licenseRegExp.test(licenser)){
            if(str==""){
               str += "발급처";
            }else{
               str += ", 발급처";
            }
            isLicense = false;
         }
         
         if(licenseDate == null || licenseDate ==""){
            if(str==""){
               str += "발급 날짜";
            }else{
               str += ", 발급 날짜";
            }
            isLicense = false;
         }
         
         if(!isLicense){
            check.html(str + "를(을) 제대로 입력 해 주십시오.");
            check.css("color", "#FF0000");
         }else if(isLicense){
            check.html("자격증 조건 부합");
            check.css("color", "#0000FF");
         }
      }
      if(!isLicense){
         return false;
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
         $(".checked").css("color", "#FF0000");
         return false;
      }else if(isChecked){
         $(".checked").html("");
      }
   }
   return true;
}


   var res; //결과를 리턴받는 변수
   <c:url value="/validateId" var="validateId"/>
   $("#userId").blur(ajaxIdCheck);
   function ajaxIdCheck() {   
         var inputUserId = $("#userId").val();
         $.ajax({
              // type을 설정합니다.
              type : 'post',
              url : "${validateId }",
              // 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
              data : {inputUserId : inputUserId},
              // 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
              success : function(data){
                  // 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
                if (data) {
                   $(".userId").html("이미 등록된 아이디 입니다.");
                   $(".userId").css("color", "#FF0000");
                   res = false;
                } else if (!data) {
                  //ID 6글자 ~ 15글자
                  var userId = $("#userId").val();
                   var idRegExp = /^[a-zA-Z0-9_]{6,15}$/; 
                    if(!idRegExp.test(u)){
                       $(".userId").html("아이디 조건 불일치");
                       $(".userId").css("color", "#FF0000");
                       res = false;
                    }else if(idRegExp.test(userId)){
                       $(".userId").html("등록 가능한 아이디입니다.");
                       $(".userId").css("color", "#0000FF");
                       res = true;
                    }                    
                }      
            },
            error : function(xhr, status, error) {
            alert(error);
         }
      });
       
         return res;
   }

//password 검사
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

   
   //중기업체 차량 추가 버튼 클릭 시 이벤트
   $(document).on("click","#btn1",   function(e) {
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
   
   //자격증 추가에 관한 버튼
   $(document).on("click","#btn2",   function(e) {
      e.preventDefault();
      
      if(license_cnt<3){
         license_cnt++;
         
         $(".license").append("<div class='license_add'>")
         .append("<input id='licenseName"+ license_cnt +"' name='licenseName' type='text' placeholder='자격증 명칭'>")
         .append("<input id='licenser"+ license_cnt +"' name='licenser' type='text' placeholder='발급처'>")
         .append("<input id='licenseDate"+ license_cnt +"' name='licenseDate' type='date'placeholder='발급시기'>")
         .append("<br><span id='licenseCheck"+ license_cnt +"'></span>")
         .append("</div>");
      }else{
         $(".licenseCheck").html("자격증은 3개 까지 작성 가능합니다.");
         $(".licenseCheck").css("color", "#FF0000");
      }
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
   
   
   $(document).on("click","#help",   function(e) {
      var help = $("#help").val();
      console.log(help);
   });
   
   $(document).on("click","#addressSearch",function(e) {
      e.preventDefault();
      var result = window.open("<%=request.getContextPath()%>/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes");
   });
   
   function jusoCallBack(roadFullAddr,zipNo){
      $("#address").val(roadFullAddr);
      $("#zipNo").val(zipNo);
   }
</script>
</html>