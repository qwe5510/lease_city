<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인정보 수정 | LEASE CITY</title>

</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>.
	<div class="mypage">
	<div class="mypage_main" style="text-align:center;">
		<c:url value="/ConstructionSuccess" var="ConstructionSuccess"/>
		<c:choose>
			   <c:when test="${compare == 'CC'}">
			   <sform:form id="mypage_identify_form" method="post" modelAttribute="constructionCompany" action="${ConstructionSuccess}" style="display:inline-block; text-align: left;">
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
                     <span id= "vali" class="password2">비밀번호 미변경 시 공백.</span>
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
                     <td><sform:input path="representPhone" placeholder="ex)031-xxx-xxxx"></sform:input>
                     <span id= "vali" class="representPhone">-포함 국번으로 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="handPhone" class="join_input">휴대폰연락처</sform:label></td>
                     <td><sform:input path="handPhone" placeholder="ex)010-xxxx-xxxx"></sform:input>
                     <span id= "vali" class="handPhone">-포함 11~12자리 핸드폰 번호 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="email" class="join_input">Email</sform:label></td>
                     <td><sform:input path="email" readonly="true"/> </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input">주소</sform:label></td>
                     <td><sform:input path="zipNo" placeholder="우편번호" readonly="true"></sform:input>
                     <button id="addressSearch">주소검색</button>
                     <span id= "vali" class="addressInput"></span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input"> </sform:label></td>
                     <td><div class="address">
                     <sform:input path="address" placeholder="주소" readonly="true"></sform:input>
                     </div></td>
                  </tr>
                  <tr>
                     <td><sform:label path="url" class="join_input">URL</sform:label></td>
                     <td><sform:input path="url" placeholder="홈페이지 주소"></sform:input>
                     <span id= "vali" class="url">사이트 주소 형식으로 입력(혹은 공백)</span>
                     </td>
                  </tr>
                  <tr>
                     <td><label class="join_input">알람 여부</label></td>
                     <td>
                     	<c:choose>
                     		<c:when test="${notifyOnOff == 'ON'}">
                     			<sform:label path="notifyOnOff">ON</sform:label> 
		                     	<sform:radiobutton path="notifyOnOff" value="ON" checked='true'/> 
		                        <sform:label path="notifyOnOff">OFF</sform:label>
		                        <sform:radiobutton path="notifyOnOff" value="OFF"/>
                     		</c:when>
                     		<c:otherwise>
                     			<sform:label path="notifyOnOff" >ON</sform:label> 
		                     	<sform:radiobutton path="notifyOnOff" value="ON"/> 
		                        <sform:label path="notifyOnOff">OFF</sform:label>
		                        <sform:radiobutton path="notifyOnOff" value="OFF" checked='true'/>
                     		</c:otherwise>
                     	</c:choose>
                     </td>
                     <td>
                     	<div id="vali" class="company"></div>
                     </td>
                  </tr>
               </table>
            </fieldset>
            <br>
            <fieldset>
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
               		<span></span>
               	</div>
               		<div class="license">
               		<sform:label path="licenseList">자격증</sform:label>
               		<sform:button id="license_add">+</sform:button><sform:button id="license_remove" style="font-size: 2em;">-</sform:button>
               		<br>
               		<c:choose>
               			<c:when test="${fn:length(constructionCompany.licenseList) == '0'}">
               				<sform:input id="licenseName0" path="licenseList[0].licenseName" placeholder="자격증 이름"></sform:input>
			               	<sform:input id="licenser0" path="licenseList[0].licenser" placeholder="발급처"></sform:input>
			               	<sform:input id="licenseDate0" type="date" path="licenseList[0].licenseDate" placeholder="발급시기"></sform:input>
			               	<sform:hidden path="licenseList[0].userId"></sform:hidden>
               			</c:when>
               			
               			<c:otherwise>
               				<c:forEach var="license" items="${constructionCompany.licenseList}" varStatus="status">
		               			<fmt:formatDate value="${license.licenseDate}" pattern="yyyy-MM-dd" var="licenseDate"/>
			               		<div>
			               			<sform:input id="licenseName${status.index}" path="licenseList[${status.index}].licenseName" placeholder="자격증 이름"></sform:input>
			               			<sform:input id="licenser${status.index}" path="licenseList[${status.index}].licenser" placeholder="발급처"></sform:input>
			               			<sform:input id="licenseDate${status.index}" type="date" value="${licenseDate}" path="licenseList[${status.index}].licenseDate" placeholder="발급시기"></sform:input>
			               			<sform:hidden path="licenseList[${status.index}].userId"></sform:hidden>
			               		</div>
               				</c:forEach>
               			</c:otherwise>
               		</c:choose>
               		              		
               		</div>
               	</div>
               	<script>
	               		
	            </script>
               	<div class="licenseCheck"></div>
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
             	<div class="CCchecked"></div>
             	</fieldset>
            	<br>
            	<sform:button id="mypage_identify_confirm">확인</sform:button>
            	<sform:button id="mypage_identify_cancel">취소</sform:button>
         		</sform:form>
			   	</c:when>
			   	
			   	<c:when test="${compare == 'HEC'}">
			   	   <c:url value="/HeavyEquipmentSuccess" var="HeavyEquipmentSuccess"/>
				   <sform:form id="mypage_identify_form" method="post" modelAttribute="heavyEquipmentCompany" action="${HeavyEquipmentSuccess}">
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
                     <span id= "vali" class="password2">비밀번호 미변경 시 공백.</span>
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
                     <td><sform:input path="representPhone" placeholder="ex)031-xxx-xxxx"></sform:input>
                     <span id= "vali" class="representPhone">-포함 국번으로 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="handPhone" class="join_input">휴대폰연락처</sform:label></td>
                     <td><sform:input path="handPhone" placeholder="ex)010-xxxx-xxxx"></sform:input>
                     <span id= "vali" class="handPhone">-포함 11~12자리 핸드폰 번호 입력</span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="email" class="join_input">Email</sform:label></td>
                     <td><sform:input path="email" readonly="true"/> </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input">주소</sform:label></td>
                     <td><sform:input path="zipNo" placeholder="우편번호" readonly="true"></sform:input>
                     <button id="addressSearch">주소검색</button>
                     <span id= "vali" class="addressInput"></span>
                     </td>
                  </tr>
                  <tr>
                     <td><sform:label path="address" class="join_input"> </sform:label></td>
                     <td><div class="address">
                     <sform:input path="address" placeholder="주소" readonly="true"></sform:input>
                     </div></td>
                  </tr>
                  <tr>
                     <td><sform:label path="url" class="join_input">URL</sform:label></td>
                     <td><sform:input path="url" placeholder="홈페이지 주소"></sform:input>
                     <span id= "vali" class="url">사이트 주소 형식으로 입력(혹은 공백)</span>
                     </td>
                  </tr>
                  <tr>
                     <td><label class="join_input">알람 여부</label></td>
                     <td>
                     	<c:choose>
                     		<c:when test="${notifyOnOff == 'ON'}">
                     			<sform:label path="notifyOnOff">ON</sform:label> 
		                     	<sform:radiobutton path="notifyOnOff" value="ON" checked='true'/> 
		                        <sform:label path="notifyOnOff">OFF</sform:label>
		                        <sform:radiobutton path="notifyOnOff" value="OFF"/>
                     		</c:when>
                     		<c:otherwise>
                     			<sform:label path="notifyOnOff" >ON</sform:label> 
		                     	<sform:radiobutton path="notifyOnOff" value="ON"/> 
		                        <sform:label path="notifyOnOff">OFF</sform:label>
		                        <sform:radiobutton path="notifyOnOff" value="OFF" checked='true'/>
                     		</c:otherwise>
                     	</c:choose>
                     </td>
                     <td>
                     	<div id="vali" class="company"></div>
                     </td>
                  </tr>
	              </table>
	            </fieldset>
	            <br>
	            <fieldset>
	               	<div>
				   		<sform:label path="helpOnOff">알람여부</sform:label>
				   		
				   		<c:choose>
				   			<c:when test="${heavyEquipmentCompany.helpOnOff == 'ON' }">
				   				<sform:checkbox path="helpOnOff" value="ON" label="도움여부" checked="true"/>
				   			</c:when>
				   			<c:otherwise>
				   				<sform:checkbox path="helpOnOff" value="ON" label="도움여부"/>
				   			</c:otherwise>
				   		</c:choose>
				   		<c:choose>
				   			<c:when test="${heavyEquipmentCompany.infoOnOff == 'ON' }">
				   				<sform:checkbox path="infoOnOff" value="ON" label="정보공개" checked="true"/>
				   			</c:when>
				   			<c:otherwise>
				   				<sform:checkbox path="infoOnOff" value="ON" label="정보공개"/>
				   			</c:otherwise>
				   		</c:choose>
				   		
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
	               		<button id="heavy_equipment_add">추가</button>
	               	</div>
	               	<div class="numbervali"></div>
	               	<div>
	               	<div><sform:label path="heavyEquipmentList">차량보유현황</sform:label></div>
	               		<div>
	               			<div id="mypage_identify_carown">
	               				<div>
					            	<label>차량 분류</label>
					               	<label>차량번호</label>
					               	<label>사용여부</label>
					               	<label>삭제</label>
	               				</div>
	               				<c:forEach var="heavyEquipment" items="${heavyEquipmentCompany.heavyEquipmentList}"
	               							varStatus="status">
	               				<div>
	               					<label>${heavyEquipment.equipmentCategory}</label>
	               					<label>${heavyEquipment.idNumber}</label>
	               					<label id="usedYesNo">${heavyEquipment.usedYesNo}</label>
	               					<label>
	               						<sform:button id="heavy_equipment_remove">삭제</sform:button>
	               					</label>
	               					<sform:hidden id="equipmentCategory${status.index}" path="heavyEquipmentList[${status.index}].equipmentCategory"/>
	               					<sform:hidden id="idNumber${status.index}" path="heavyEquipmentList[${status.index}].idNumber"/>
	               					<sform:hidden id="userId${status.index}" path="heavyEquipmentList[${status.index}].userId"/>
	               					<sform:hidden id="usedYesNo${status.index}" path="heavyEquipmentList[${status.index}].usedYesNo"/>
	              				</div>
	              				</c:forEach>
	              			</div>
	              		</div>
	              	</div>
	             	<div class="checked"></div>
	             	</fieldset>
	            	<br>
	            	<sform:button id="mypage_identify_confirm">확인</sform:button>
	            	<sform:button id="mypage_identify_cancel">취소</sform:button>
	         		</sform:form>
			   		</c:when>
			   </c:choose>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

license_cnt = ${fn:length(constructionCompany.licenseList)}==0?0:${fn:length(constructionCompany.licenseList)-1};
heavyEquipment_cnt = ${fn:length(heavyEquipmentCompany.heavyEquipmentList)};

$(document).on("ready", function(){
	$("#password").val(""); //비밀번호 값 초기화하기.
	
	var category = document.getElementsByName("companyCategory");	
	var companyCategory = "${constructionCompany.companyCategory}".split(",");
	$(category).each(function(idx, item){
		for(var isCheck of companyCategory){
			if(item.value == isCheck){
				item.checked = true;
			}
		}
	});
	
	
});
	
	
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
 
 
 //차량 추가
 $("#heavy_equipment_add").on("click",function(e){
	 e.preventDefault();
	 var carNum = $("#carNum").val();
	 var size = $("#size").val();
	 var type = $("#type").val();
	 var regIdNumber = /^[0-9]{2}[가-힣] [0-9]{4}$/;
	 
	 
	 if(!regIdNumber.test(carNum)){
		 $(".numbervali").css("color", "red");
		 $(".numbervali").html("올바르지 않은 차량번호 입니다 [ 예) 30가 1234 ]");
	 }else{
		 var inputList = $("#mypage_identify_carown input[type=hidden]");
		 var check = false;
		 inputList.each(function(idx, item){
			 var itemVal = $(item).val();
			 if(carNum == itemVal){
				 check = true;
			 }
		 });
		 
		 if(check){
			 alert("동일한 차량번호가 이미 존재합니다.");
		 }
		 else{
			//Ajax처리에 의한 이미등록된 차량 검색
			 <c:url value="/HeavyEquipmentCheckAjax" var="HeavyEquipmentCheckAjax"></c:url>
			 $.ajax({
				 url: "${HeavyEquipmentCheckAjax}",
				 method : "GET",
				 data : {
					 idNumber : carNum
				 },
				 success : function(res){
					 //중복된 차량이 없을 경우.
					 if(res){
						 $(".numbervali").html("");
						 $("#carNum").val("");
						 
						 var str = "";
						 //중기업체 추가
						 str+="<div><label>"+type+"/"+size+"</label>";
						 str+="<label style='margin-left: 2px;'>"+carNum+"</label>";
						 str+="<label style='margin-left: 3px;'>N</label>";
						 str+="<label style='margin-left: 4px;'><button id='mypage_identify_remove'>삭제</button></label>";
						 str+="<input type='hidden' id='equipmentCategory"+ heavyEquipment_cnt +"' name='heavyEquipmentList["+ heavyEquipment_cnt +"].equipmentCategory' value='"+ type+"/"+size+"'>";
						 str+="<input type='hidden' id='idNumber"+ heavyEquipment_cnt +"' name='heavyEquipmentList["+ heavyEquipment_cnt +"].idNumber' value='"+ carNum +"'>";
						 str+="<input type='hidden' id='userId"+ heavyEquipment_cnt +"' name='heavyEquipmentList["+ heavyEquipment_cnt +"].userId' value='${heavyEquipmentCompany.userId}'>";
						 str+="<input type='hidden' id='usedYesNo"+ heavyEquipment_cnt +"' name='heavyEquipmentList["+ heavyEquipment_cnt +"].usedYesNo' value='N'>";
						 $("#mypage_identify_carown").append(str);
						 
						 heavyEquipment_cnt++;
					 }else{
						 alert("이미 등록 되어있는 차량입니다.");
					 }
				 },
				 error : function(error){
					 alert(error);
				 }
			 });
		 }
	 } 
 });

 
 //차량 삭제
 $(document).on("click","#heavy_equipment_remove",function(e){
	 e.preventDefault();
	 var used = $(this).parent().prev().html();
	
	 if(used == "Y"){
		alert("사용중인 장비는 삭제 할 수 없습니다.");
		return false;
	 }else if(used == "N"){
		 $(this).parent().parent().remove();
		 heavyEquipment_cnt--;
		 
		 var infoArray = ["equipmentCategory", "idNumber", "userId", "usedYesNo"];	 
		 var inputList = $("#mypage_identify_carown input[type=hidden]");
		 inputList.each(function(idx, item){
			 var index = parseInt(idx/4);
			 var itemindex = idx % 4;
			 
			 var infoId = infoArray[itemindex] + index;
			 var infoName = "heavyEquipmentList["+ index  +"]." + infoArray[itemindex]; 
			 
			 $(item).attr("id", infoId);
			 $(item).attr("name", infoName);
		 })
	 }
 });
 
  $(document).on("click","#mypage_identify_confirm", function(e){
	  
	   var password = $("#password").val();
	   var password2 = $("#password2").val();
	   var representPhone = $("#representPhone").val();
	   var handPhone =$("#handPhone").val();
	   var url = $("#url").val();
	   var address = $("#address").val();
	   var sales = $("#sales").val();
	   var obtain = $("#obtain").val();
	   var num = $("#num").val();
	   var yearlySale = $("#yearlySale").val();
	   var yearlyAoor = $("#yearlyAoor").val();
	   var companyCategory = $("input:checkbox[name='companyCategory']").is(":checked");
	   
	 //특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	   var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	   
	   if((password == ""|| password==null) &&
		  (password2 == ""|| password2==null)){
	   }else if(!passRegExp.test(password)){
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
	
	var isCompany = "${compare}";

	if(isCompany == "CC") //건설 업체
	{
		console.log("건설업체");
		//연매출, 연 수주량 검사
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
		   }
		      
		 	//한글,숫자,영어 - 자격증명칭, 발급처에만 사용
		      var licenseRegExp = /^[가-힣0-9a-zA-Z-#)( ]{1,}$/
		      var isLicense = true; //자격증 조건식 총괄 bool변수
		      
		   for(var i=0; i<=license_cnt; i++){
		    	  
		         var licenseName = $("#licenseName" + i).val();
		         var licenser = $("#licenser" + i).val();
		         var licenseDate = $("#licenseDate" + i).val();

		         console.log("licenseName"+ i + " : " + licenseName);
		         console.log("licenser"+ i + " : " + licenser);
		         console.log("licenseDate"+ i + " : " + licenseDate);
		         
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
			if(!isLicense){return false;}
			
		var isCheck = false;
		$(".cc_label").each(function(idx, item){
			if(item.checked){isCheck = true;}
		});
		
		if(isCheck){
			$(".CCchecked").html("");
		}else{
			$(".CCchecked").html("분야가 최소 1개 이상은 체크되어야 합니다.");
			$(".CCchecked").css("color", "red");
			return false;
		}
		
	}
	else if(isCompany == 'HEC'){
		var inputList = $("#mypage_identify_carown input[type=hidden]");		
		if(inputList.length == 0){
			   $(".numbervali").html("중장비는 최소 1개 이상 있어야합니다.");
			   $(".numbervali").css("color", "#FF0000");
			      return false;
		}
	}
});
  
 //비밀번호 검사
 function passvali(){
	   var password = $("#password").val();
	   var password2 = $("#password2").val();
	   
	   //특수문자가 하나라도 포함되어야하는 8글자 이상 16글자 이하의 비밀번호.
	   var passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
	   
	   if((password == ""|| password==null) &&
		  (password2 == ""|| password2==null)){
		  $(".password").css("color", "#000000");
		  $(".password").html("영어 숫자 특수문자 혼용 8~16글자");
		  $(".password2").html(" 비밀번호 미변경 시 공백.");
	   }else if(!passRegExp.test(password)){
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
 
 
 //자격증 추가 - 삭제
 $("#license_add").on("click",function(e){
	 e.preventDefault();
	 var str="";
	 if(license_cnt<2){
         license_cnt++;
         str+="<div><input id='licenseName"+ license_cnt +"' name='licenseList["+ license_cnt +"].licenseName' type='text' placeholder='자격증 명칭'>";
         str+="<input id='licenser"+ license_cnt +"' name='licenseList["+ license_cnt +"].licenser' type='text' placeholder='발급처'>";
         str+="<input id='licenseDate"+ license_cnt +"' name='licenseList["+ license_cnt +"].licenseDate' type='date' placeholder='발급시기'>";
         str+="<input id='licenseList"+ license_cnt +".userId' name='licenseList["+ license_cnt +"].userId' type='hidden' value=${constructionCompany.userId}>";
         str+="<br><span id='licenseCheck"+ license_cnt +"'></span></div>";
         $(".license").append(str);
         $(".licenseCheck").html("");
      }else{
         $(".licenseCheck").html("자격증은 3개 까지 작성 가능합니다.");
         $(".licenseCheck").css("color", "#FF0000");
      }
 });
 
 $("#license_remove").on("click", function(e){
	 e.preventDefault();
	 if(license_cnt==0){
		 $(".licenseCheck").html("자격증은 최소1개 입력해주셔야합니다.");
         $(".licenseCheck").css("color", "#FF0000");
	 }else{
		 console.log($(".license div:last-child"));
		 $(".license div:last-child").remove();
		 license_cnt--;
		 $(".licenseCheck").html("");
	 }
 });
</script>
</html>