<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src='//uchat.co.kr/uchat.php' charset='UTF-8'></script>
<title>커뮤니티 | LEASE CITY</title>

<c:if test="${!empty board_message }">
	<script>
		alert('${board_message }');
	</script>
</c:if>

<%
	Date todayDate = new Date();
	String today = DateUtil.getDateString(todayDate);
	request.setAttribute("today", today);
%>

</head>
<body>
   <jsp:include page="../layout/header.jsp"></jsp:include>
   <div class="board">
      <div class="uchat">
      	<div class="uchat_inner">
         <script>
            u_chat({
               room : 'LeaseCity',
               chat_record : true,
               width : '300',
               height : '380',
               conversation_limi : true,
               in_sound : true,
               say_id : true,
               skin : 1,
               no_inout : false,
               mb_list_height : '50'
            });
         </script>
         </div>
      </div>
      <div class="community">
         <img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
         <br>
         <br>
         
         <table class="communityTable">
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
                     <td>날짜<a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <td>날짜<a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=ASC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${page.order eq 'ASC' }">
                     <td>날짜<a href="<%=request.getContextPath()%>/board?order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:otherwise>
                     <td>날짜<a href="<%=request.getContextPath()%>/board?order=ASC"><i class="icon-sort"></i></a></td>
                  </c:otherwise>
               </c:choose>
            </tr>


            <c:forEach var="comment" items="${comments}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td><c:out value="${comment.commentRowNum}" /></td>
                  <td><c:out value="${comment.commentCategory}" /></td>
                  <td class='communityTitle'>
                  
                  <c:choose>
	                  <c:when test="${!empty page.keyword and !empty page.order}">
	                    <a href="<%=request.getContextPath() %>/board/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.order}">
	                    <a href="<%=request.getContextPath() %>/board/read?currentPage=${page.currentPage}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.keyword}">
	                    <a href="<%=request.getContextPath() %>/board/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:otherwise>
	                    <a href="<%=request.getContextPath() %>/board/read?currentPage=${page.currentPage}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:otherwise>
               		</c:choose>
               		<fmt:formatDate value="${comment.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                 	 <fmt:formatDate value="${comment.regDate}"
                        pattern="hh:mm:ss"
                        var="strRegTime"/>
                        
                     <c:if test="${comment.hits >= 100 and (strRegDate eq today)}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(comment.replyCount eq 0)}">
                     	<span class="label label-warning">
                     		+${comment.replyCount}
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
            
            <tr class="board_write">
               <td colspan="6" align="right">
               <c:url value="/board/write" var="boardWrite"/>
               <a href="${boardWrite}"><button><i class="icon-pencil"></i>글쓰기</button></a>
               <a href="${boardList}"><button><i class="icon-list"></i>목록</button></a>
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
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/board?currentPage=${i}">
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
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/board?currentPage=${i}">
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
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/board?currentPage=${nextPage}">
                     다음<i class="icon-arrow-right"></i></a>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
               <a style="color: black;">끝<i class="icon-arrow-right"></i></a>
            </c:otherwise>
            </c:choose>
         </div>
         
         <c:url value="/board" var="board"/> 
         <sform:form method="get" modelAttribute="page" action="${board }">
                  
                  <div class="boardBottom">
                     <sform:select path="search">
                        <sform:option value="COMPANY_NAME">글쓴이</sform:option>
                        <sform:option value="TITLE">제목</sform:option>
                        <sform:option value="TITLE_AND_CONTENT">제목+내용</sform:option>
                        <sform:option value="LOCAL">지역명</sform:option>
                     </sform:select>
                     <sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
                     <button id="boardBtn"><i class="icon-search"></i>검색</button>
                  </div>
         </sform:form>
         </div>
      </div>
   </div>
   <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
 $("#boardBtn").on("click",function(e){
	var keyword = $("#keyword").val();
	var searchRegExp = /^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/;
	if(!searchRegExp.test(keyword)){
		alert("조건이 알맞지 않습니다.\n(%를 제외한 2글자 이상 문자.)");
		return false;
	}
}) 
</script>
</html>