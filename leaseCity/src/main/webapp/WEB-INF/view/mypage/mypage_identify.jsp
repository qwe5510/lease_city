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
		 <sform:form id="joinForm" method="post" modelAttribute="user" action="#">
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
                     <td><sform:input path="password" type="password"/>
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
			   		<c:when test="${compare eq '중기'}">
			   		<sform:form id="mypage_identify_cc" action="#" method="post" modelAttribute="constructionCompany">
               			<div class="companySelector">
               			<div>
               			<sform:label path="yearlySale">연매출</sform:label>
               			<sform:input path="yearlySale" type="number"/>
               			</div>
               			<div>
               			<sform:label path="yearlyAoor">연수주량</sform:label>
               			<sform:input path="yearlyAoor" type="number"/>
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
			   			<div class="heavy">
			   			</div>
               			<div class="companySelector">
               			</div>
               			<div class="numbervali">
               			</div>
             			<div class="checked">
             			</div>
			   		</c:otherwise>
			   </c:choose>
            </fieldset>
            <br>
            <sform:button>확인</sform:button>
            <sform:button>취소</sform:button>
         </sform:form>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>