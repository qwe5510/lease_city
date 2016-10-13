<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>

   <!-- 가입 절차 설명 메시지 -->
   <c:if test="${!empty join_message }">
      <script type="text/javascript">
         var msg = '${join_message }'
         alert(msg);
      </script>
   </c:if>

   <jsp:include page="../layout/header.jsp"></jsp:include>
   <div class="login">
      <img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
      <div class="inner">
         <form method="post" action="#">
            <fieldset>
               <legend>로그인</legend>
               <table>
                  <tr>
                     <th><label name="userId">아이디</label></th>
                     <th><input name="userId" type="text" /></th>
                     <th rowspan="2"><button class="loginBtn">로그인</button>
                  </tr>
                  <tr>
                     <th><label name="password">비밀번호</label></th>
                     <th><input name="password" type="password" /></th>
                  </tr>
               </table>
               <div class="inner1">
                  <a data-toggle="modal" href="#joinRequest">회원가입인증</a> <a
                     data-toggle="modal" href="#idSearch">아이디찾기</a> <a
                     data-toggle="modal" href="#passSearch">비밀번호찾기</a>
               </div>
            </fieldset>
         </form>
      </div>
   </div>
   <section id="bottom" class="main">
      <!--Container-->
      <div class="container">

         <!--row-fluids-->
         <div class="row-fluid">

            <!--Contact Form-->
            <div class="span3">
               <ul class="unstyled address">
                  <li><img
                     src="<%=request.getContextPath()%>/images/logo/logo2.png" /></li>
               </ul>
            </div>
            <!--End Contact Form-->

            <!--Important Links-->
            <div id="tweets" class="span3">
               <h4>CopyRighter</h4>
               <div>
                  <ul class="arrow">
                     <li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
                        wkdvlftlr123@gmail.com</li>
                     <li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
                        wkdvlftlr123@gmail.com</li>
                     <li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
                        wkdvlftlr123@gmail.com</li>
                  </ul>
               </div>
            </div>
            <!--Important Links-->

            <!--Archives-->
            <div id="archives" class="span3">
               <h4>Our Company's</h4>
               <div>
                  <ul class="arrow">
                     <li>construction company's</li>
                     <li>heavy equipment company's</li>
                  </ul>
               </div>
            </div>
            <!--End Archives-->

            <div class="span3">
               <h4>Building</h4>
               <div class="row-fluid first">
                  <ul class="thumbnails">
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build1.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build2.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build3.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build4.png"
                        alt="" /></li>
                  </ul>
               </div>
               <div class="row-fluid">
                  <ul class="thumbnails">
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build5.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build6.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build7.png"
                        alt="" /></li>
                     <li class="span3"><img
                        src="<%=request.getContextPath()%>/images/building/build8.png"
                        alt="" /></li>
                  </ul>
               </div>

            </div>

         </div>
         <!--/row-fluid-->
      </div>
   </section>
   <jsp:include page="../layout/footer.jsp"></jsp:include>
   <!--  가입요청 -->
   <div class="modal hide fade in" id="joinRequest" aria-hidden="false">
      <div class="modal-header">
         <i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i> <img
            class="modalImg"
            src="<%=request.getContextPath()%>/images/pop/join.png" />
      </div>
      <!--Modal Body-->
      <div class="modal-body">
         <form class="form-inline" method="post" action="popup_join_request"
            name="joinForm" onsubmit="return validateform()">
            <input id="representName" name="representName" type="text"
               placeholder="업체명" /> <br> <input id="companyName"
               name="companyName" type="text" placeholder="대표자명" /> <br> <input
               id="email" name="email" type="email" placeholder="Email" /> <br>
            <button class="pop">가입 요청</button>
         </form>
      </div>
   </div>

   <!--  아이디찾기 -->
   <div class="modal hide fade in" id="idSearch" aria-hidden="false">
      <div class="modal-header">
         <i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i> <img
            class="modalImg"
            src="<%=request.getContextPath()%>/images/pop/id.png" />
      </div>
      <!--Modal Body-->
      <div class="modal-body">
         <sform:form class="form-inline" modelAttribute="user" method="post" action="popup_join_request">
            <sform:input path="representName" type="text" placeholder="업체명" /> <br>
            <sform:input path="companyName" type="text" placeholder="대표자명" /> <br>
            <sform:input path="email" type="email" placeholder="Email" /> <br>
            <sform:button class="pop">아이디 찾기</sform:button>
         </sform:form>
      </div>
   </div>

   <!--  비밀번호찾기 -->
   <div class="modal hide fade in" id="passSearch" aria-hidden="false">
      <div class="modal-header">
         <i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i> <img
            class="modalImg"
            src="<%=request.getContextPath()%>/images/pop/pass.png" />
      </div>
      <!--Modal Body-->
      <div class="modal-body">
         <sform:form class="form-inline" modelAttribute="user" method="post" action="#">
            <sform:input path="representName" type="text" placeholder="아이디" /><br>
            <sform:input path="representName" type="text" placeholder="업체명" /><br>
            <sform:input path="companyName" type="text" placeholder="대표자명" /><br>
            <sform:input path="email" type="email" placeholder="Email" />
            <sform:button class="btn1" value="발급">발급</sform:button>
            <br> <input path="companyName" type="number" placeholder="인증번호" />
            <sform:button class="btn1" value="인증">인증</sform:button>
            <br>
            <button>비밀번호찾기</button>
         </sform:form>
      </div>
   </div>


   <script src="js/vendor/jquery-1.9.1.min.js"></script>
   <script src="js/vendor/bootstrap.min.js"></script>
   <script src="js/main.js"></script>
   <!-- Required javascript files for Slider -->
   <script src="js/jquery.ba-cond.min.js"></script>
   <script src="js/jquery.slitslider.js"></script>
   <script src="js/validation/lib/jquery.js"></script>
   <script src="js/validation/dist/jquery.validate.js"></script>
   <script>
      function validateform() {
         var representName = document.joinForm.representName.value;
         var companyName = document.joinForm.companyName.value;
         var email = document.joinForm.email.value;
         console.log("ggggg");
         if (representName == null || representName == "") {
            alert("대표자 성명을 기입하세요!");
            return false;
         } else if (representName.length > 16) {
            alert("대표자 성명은 16자 까지 입니다.");
            return false;
         }

         if (companyName == null || companyName == "") {
            alert("업체명을 기입하세요!");
            return false;
         }
         if (email == null || representName == "") {
            alert("이메일을 기입하세요!");
            return false;
         } else if (!validateEmail(email)) {
            alert("이메일 형식에 맞춰 기입하세요!")
            return false;
         }
      }

      function validateEmail(email) {
         var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
         return re.test(email);
      }
   </script>

</body>

</html>