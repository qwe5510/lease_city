<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="leasecity.dto.community.Comment"%>
<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Q&A 질문과 답변 | LEASE CITY</title>
</head>
<body>

	<c:if test="${!empty qna_message }">
      <script type="text/javascript">
         alert('${qna_message}');
      </script>
   </c:if>
	
	<%
      Date todayDate = new Date();
      String today = DateUtil.getDateString(todayDate);
      request.setAttribute("today", today);
    %>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	<c:url value="/help/FAQ" var="FAQ"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1"></div>
		</div>
		<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_question"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu3_1.png"></a></li>
		</ul>
		
		<div class="help_main">   
		<div class="qna_list">
		    <table class="QnATable" >
            <tr>
               <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
            </tr>
            <tr class="notify">
               <td>글번호</td>
               <td>분류</td>
               <td>제목</td>
               <td>글쓴이</td>
               <td>조회수</td>
               <c:choose>
                  <c:when test="${!empty page.keyword and page.order eq 'ASC'}">
                     <td>날짜<a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <td>날짜<a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=ASC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${page.order eq 'ASC' }">
                     <td>날짜<a href="<%=request.getContextPath()%>/help/qna?order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:otherwise>
                     <td>날짜<a href="<%=request.getContextPath()%>/help/qna?order=ASC"><i class="icon-sort"></i></a></td>
                  </c:otherwise>
               </c:choose>
            </tr>


            <c:forEach var="comment" items="${Q_AND_A}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td><c:out value="${comment.commentRowNum}" /></td>
                  <td><c:out value="${comment.commentCategory}" /></td>
                  <td class='communityTitle'>
                  
                  <c:choose>
	                  <c:when test="${!empty page.keyword and !empty page.order}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.order}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.keyword}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:otherwise>
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:otherwise>
               		</c:choose>
               		

                     <c:if test="${comment.hits >= 100 and (strRegDate eq today)}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(comment.replyCount eq 0)}">
                     	<span class="label label-warning">
                     		답변 : ${comment.replyCount}
                     	</span>
                     </c:if>
                  </td>
                  <td>
                  <c:choose>
                  	<c:when test="${!empty admin}">
                  	<b>${comment.companyName}</b>
                  	</c:when>
                  	<c:otherwise>
                  		${comment.companyName}
                  	</c:otherwise>
                  </c:choose>
                  </td>
                  <td><c:out value="${comment.hits}" /></td>               
                  
                  <fmt:formatDate value="${comment.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                  <fmt:formatDate value="${comment.regDate}"
                        pattern="hh:mm:ss"
                        var="strRegTime"/>
                  
                  <c:choose>
                  <c:when test="${strRegDate eq today}">
                     <td><c:out value="${strRegTime}" /></td>
                  </c:when>
                  <c:otherwise>
                     <td><c:out value="${strRegDate}" /></td>
                  </c:otherwise>
                  </c:choose>                           
               </tr>
            </c:forEach>
            
            <c:if test="${empty page.totalPage and !empty errorMsg }">
               <tr>
                  <td colspan="6"><c:out value="${errorMsg}"></c:out></td>
               </tr>
            </c:if>
            <tr>
               <td colspan="6" class="boardLine" style="height: 3px !important;"></td>
            </tr>
            
            <tr>
               <td colspan="6" align="right">
               <c:url value="/help/qna/write" var="qnaWrite"/>
               <c:url value="/help/qna" var="qna"/>
               <a href="${qnaWrite}"><button><i class="icon-pencil"></i>글쓰기</button></a>
               <a href="${qna}"><button><i class="icon-list"></i>목록</button></a>
               </td>
            </tr>
            
         </table>
         <div class="boardSearch">
         <div class="boardPage" style="display: inline-block;">
            
            <!-- 이전 페이지, 다음 페이지 변수 선언 -->
            <fmt:parseNumber 
               value="${(((page.currentPage-1)/10)-(((page.currentPage-1)/10)%1))*10}" 
               var="prevPage">
            </fmt:parseNumber>
            <fmt:parseNumber 
               value="${prevPage+11}" 
               var="nextPage">
            </fmt:parseNumber>
               
            
            <c:choose>
            <c:when test="${prevPage > 0}">
                           
               <c:choose>
                  <c:when test="${!empty page.keyword and !empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/board?currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
            <a style="color: black;"><i class="icon-arrow-left">처음</i></a>
            </c:otherwise>
            </c:choose>            
            
            <c:if test="${!empty page.totalPage}">
               <c:choose>
                  <c:when test="${(nextPage-1) >= page.totalPage }">
                     <c:forEach var="i" begin="${prevPage+1}" end = "${page.totalPage}">
                        <c:choose>
                           <c:when test="${i eq page.currentPage}">
                              <b><c:out value="${i}"></c:out></b>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                                 <c:when test="${!empty page.keyword and !empty page.order}">
                                    <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/help/qna?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/help/qna?currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <c:forEach var="i" begin="${prevPage+1}" end = "${nextPage-1}">
                        <c:choose>
                           <c:when test="${i eq page.currentPage}">
                              <b><c:out value="${i}"></c:out></b>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                                 <c:when test="${!empty page.keyword and !empty page.order}">
                                    <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/help/qna?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/help/qna?currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                  </c:otherwise>
               </c:choose>
            </c:if>
            
            <c:choose>
            <c:when test="${nextPage <= page.totalPage}">
               <c:choose>
               <c:when test="${!empty page.keyword and !empty page.order}">
                     <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/help/qna?order=${page.order}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/help/qna?currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
               <a style="color: black;">끝<i class="icon-arrow-right"></i></a>
            </c:otherwise>
            </c:choose>
         </div>
         
         <c:url value="/help/qna" var="qna"/> 
         <sform:form method="get" modelAttribute="page" action="${qna}">
                  
                  <div class="boardBottom">
                     <sform:select path="search">
                        <sform:option value="COMPANY_NAME">글쓴이</sform:option>
                        <sform:option value="TITLE">제목</sform:option>
                        <sform:option value="TITLE_AND_CONTENT">제목+내용</sform:option>
                        <sform:option value="CATEGORY">분류</sform:option>
                     </sform:select>
                     <sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
                     <button id="boardBtn"><i class="icon-search"></i>검색</button>
                  </div>
         </sform:form>
         </div>
		</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

	$("#boardBtn").on("click",function(e){
		e.preventDefault();
		var keyword = $("#keyword").val();
		var searchRegExp = /^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/;
		if(!searchRegExp.test(keyword)){
			alert("조건이 알맞지 않습니다.\n(%를 제외한 2글자 이상 문자.)");
			return false;
		}else{
			$("form").submit();
		}
	}) 

	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
	});
</script>
</html>