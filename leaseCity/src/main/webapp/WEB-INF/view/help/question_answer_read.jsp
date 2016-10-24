<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="leasecity.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<c:if test="${!empty qna_message }">
      <script type="text/javascript">
         alert('${qna_message }');
      </script>
   </c:if>
	
	<%
      Date todayDate = new Date();
      String today = DateUtil.getDateString(todayDate);
      request.setAttribute("today", today);
    %>
    
	<c:url value="/help/FAQ" var="FAQ"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1">
			<h2></h2>
			<br>
			</div>
			<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_question"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu4_1.png"></a></li>
			</ul>
		</div>
		<div class="help_read_main">
			<c:url value="/help/qna/adjust" var="qnaAdjust"/>
			<div class="help_read_main_inner">
			<sform:form id="help_read_form" action="${qnaAdjusta }" method="post" modelAttribute="question">
			<div class="qna_read_line">
				<table class="qna_read_table">
						<tr>
							<td colspan='9' class='boardLine'></td>
						</tr>
						<tr>
							<td width="2px" class="boardLine"></td>
							<th>분류</th>
							<td width="2px" class="boardLine"></td>
							<td><c:out value="${question.commentCategory}"></c:out></td>
							<td width="2px" class="boardLine"></td>
							<th><span>조회수</span></th>
							<td width="2px" class="boardLine"></td>
							<td width="150px"><c:out value="${question.hits }"></c:out></td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan='9' class='boardLine'></td>
						</tr>
						<tr>
							<td width="2px" class="boardLine"></td>
							<td align="left" colspan="7" style="padding-left: 25px"><span
								style="font-size: 1.3em">${question.commentTitle}</span></td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan="9" class='boardLine'></td>
						</tr>
						<fmt:formatDate value="${question.regDate}"
							pattern="yyyy-MM-dd  hh:mm:ss" var="questionRegDate" />
						<tr>
							<td width="2px" class="boardLine"></td>
							<td colspan="4" align="left"><span
								class="board_read_comment_author"> <c:out
										value="${question.companyName}"></c:out> <span
									class="board_read_comment_userId"> (<c:out
											value="${question.outputId}"></c:out>)
								</span>
							</span></td>
							<td colspan="3" align="right"><b><c:out
										value="${questionRegDate}"></c:out></b></td>
							<td width="2px" class="boardLine"></td>
						</tr>

						<tr class="board_read_comment" align="left" valign="top">
							<td width="2px" class="boardLine"></td>
							<td colspan="7">
								<div class="comment_content">
									${question.commentContent}
								</div>
							</td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan="9" class='boardLine'></td>
						</tr>
					</table>
            <div id="manager_answer_show"></div>
            <div style="text-align: left; padding: 10px;">
            <span>답변<b>(${question.replyCount})</b></span>
            
            
            </div>
            
            <c:if test="${!empty admin}">
            <div class="manager_answer">
            	  <textarea id="manager_answer_letter" cols="50" rows="10"
            	  placeholder="답변을 등록해주세요."></textarea>
                  <sform:button id="manager_register">등록</sform:button>
            </div>
            </c:if>
				
			</div>
			<div class="qna_read_bottom">
               <sform:button id="help_read_list"><i class="icon-list"></i>목록</sform:button>
               <sform:button id="help_read_write"><i class="icon-pencil"></i>글쓰기</sform:button>
               
               <c:if test="${empty admin}">
				<c:if test="${question.userId eq loginUser.userId}">
					<c:url value="/help/qna/adjust" var="qnaAdjust" />
					<sform:form id="board_edit_form" modelAttribute="question" action="${qnaAdjust}" method="POST">
					<sform:button id="board_read_adjust"><i class="icon-edit"></i>수정</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentContent"/>
					<sform:hidden path="commentTitle"/>
					<sform:hidden path="commentCategory"/>
					<input name="userId" type="hidden" value="${loginUser.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
			
				<!-- 관리자가 로그인했을 때도 출력되게 해야함 -->
				<c:if test="${question.userId eq loginUser.userId}">
					<c:url value="/qnaRemove" var="qnaRemove" />
					<sform:form id="board_edit_form" modelAttribute="question" action="${qnaRemove}" method="POST">
					<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentTitle"/>
					<input name="userId" type="hidden" value="${loginUser.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
			</c:if>
			
			<!-- 관리자 로그인 시-->
			<c:if test="${!empty admin}">
				
				<c:if test="${question.userId eq admin.userId}">
					<c:url value="/help/qna/adjust" var="qna_adjust" />
					<sform:form id="board_edit_form" modelAttribute="question" action="${qna_adjust}" method="POST">
					<sform:button id="board_read_adjust"><i class="icon-edit"></i>수정</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentContent"/>
					<sform:hidden path="commentTitle"/>
					<sform:hidden path="commentCategory" />
					<input name="userId" type="hidden" value="${admin.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
				
				<c:url value="/qnaRemove" var="qnaRemove" />
				<sform:form id="board_edit_form" modelAttribute="" action="${qnaRemove}" method="POST">
				<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
				<sform:hidden path="commentNo"/>
				<sform:hidden path="commentTitle"/>
				<input name="currentPage" type="hidden" value="${page.currentPage}">
				</sform:form>
			</c:if>
               
            </div>
			</sform:form>
			</div>
		</div>
		
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


            <c:forEach var="question" items="${Q_AND_A}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td><c:out value="${question.commentRowNum}" /></td>
                  <td><c:out value="${question.commentCategory}" /></td>
                  <td class='communityTitle'>
                  
                  <c:choose>
	                  <c:when test="${!empty page.keyword and !empty page.order}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&order=${page.order}&commentNo=${question.commentNo}">
                     		${question.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.order}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&order=${page.order}&commentNo=${question.commentNo}">
                     		${question.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.keyword}">
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&commentNo=${question.commentNo}">
                     		${question.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:otherwise>
	                    <a href="<%=request.getContextPath() %>/help/qna/read?currentPage=${page.currentPage}&commentNo=${question.commentNo}">
                     		${question.commentTitle}
                     	</a>
	                  </c:otherwise>
               		</c:choose>
               		
					
                    <c:if test="${question.hits >= 100}">
                     <span class="label label-important">
                     		hot
                     </span>
                    </c:if>
                     
                     <c:if test="${!(question.replyCount eq 0)}">
                     	<span class="label label-warning">
                     		답변 : ${question.replyCount}
                     	</span>
                     </c:if>
                  </td>
                  <td>
                  <c:choose>
                  	<c:when test="${!empty admin}">
                  	<b>${question.companyName}</b>
                  	</c:when>
                  	<c:otherwise>
                  		${question.companyName}
                  	</c:otherwise>
                  </c:choose>
                  </td>
                  <td><c:out value="${question.hits}" /></td>               
                  
                  <fmt:formatDate value="${question.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                  <fmt:formatDate value="${question.regDate}"
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
                     <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/help/qna?order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/help/qna?search=${page.search}&keyword=${page.keyword}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/help/qna?currentPage=${prevPage}">
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
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
	});
	<c:url value="/help/qna" var="question_answer"/>
	$("#help_read_list").on("click",function(e){
		e.preventDefault();
	    $("#help_read_form").attr("action","${question_answer}");
	    $("#help_read_form").submit();
	});
	$("#manager_register").on("click",function(e){
		e.preventDefault();
		var manager_answer_letter = $("#manager_answer_letter").val();
		console.log(manager_answer_letter);
		if(manager_answer_letter==null || manager_answer_letter==""){
			alert("공백 답변은 등록 불가");
			return false;
		}else{
			$("#manager_answer_show").append("<div>관리자답변 -> "+manager_answer_letter+"</div>")
		}
		
	})
</script>
</html>