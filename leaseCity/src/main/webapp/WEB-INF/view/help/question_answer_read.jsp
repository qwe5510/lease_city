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
			<div class="help_menu_inner1"></div>
		</div>
		<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_question"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu3_1.png"></a></li>
		</ul>
		<div class="help_read_main">
			<c:url value="/writeAnswer" var="writeAnswer"/>
			<div class="help_read_main_inner">

				<sform:form id="help_read_form" action="${writeAnswer}" method="post" modelAttribute="question">
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
								<td colspan="4" align="left">
									<span class="qna_read_comment_author">
										${question.companyName}
										
									<c:if test="${question.userId != 'admin'}">
										<span class="qna_read_comment_userId">
													(${question.outputId})
										</span>
									</c:if>
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
	            <div id="manager_answer_show">
	            	<c:forEach var="answer" items="${answers}">
	            	<div id="answer_${answer.replyNo}">
	            	<div id="answer_title"><h5>Re:${question.commentTitle}</h5></div>
	            	<br><br>
	            	<fmt:formatDate value="${answer.regDate}"
						pattern="yyyy-MM-dd  hh:mm:ss" var="answerRegDate" />
							<div class="reply_author">
							${answer.companyName}
							</div>
							<!-- 이부분 Session Filter 해야 함 -->
							<div class="answer_date" style="float: right;">
								${answerRegDate}
							</div>
							<div class="answer_content">
								${answer.replyContent}
							</div>
							<div class="answer_data" style="display: none;">
								<span>${question.commentNo}</span>
								<span>${answer.replyNo}</span>
							</div>
						</div>
	            	</c:forEach>
	            </div>
	            
	            <div style="text-align: left; padding: 10px;">
	            <span>답변<b>(${question.replyCount})</b></span>
	            </div>
	            
	           
	            
	            <c:if test="${!empty admin}">
	            <div class="manager_answer">
	          		  <sform:hidden path="commentNo"/>
	            	  <textarea id="manager_answer_letter" cols="50" rows="10"
	            	  placeholder="답변을 등록해주세요."></textarea>
	            	  
	                  <sform:button id="manager_register">등록</sform:button>
	            </div>
	            </c:if>
					
				</div>
				
				<sform:button id="help_read_write"><i class="icon-pencil"></i>글쓰기</sform:button>
	            <sform:button id="help_read_list"><i class="icon-list"></i>목록</sform:button>
				
				</sform:form>
				
				<div class="qna_read_bottom">
				<!-- 일반 유저  -->
	            <c:if test="${empty admin}">			
					<!-- 관리자가 로그인했을 때도 출력되게 해야함 -->
					<c:if test="${question.userId eq loginUser.userId}">
						<c:url value="/removeQuestion" var="removeQuestion" />
						<sform:form id="board_edit_form" modelAttribute="question" action="${removeQuestion}" method="POST">
						<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
						<sform:hidden path="commentNo"/>
						<sform:hidden path="commentTitle"/>
						<input name="currentPage" type="hidden" value="${page.currentPage}">
						</sform:form>
					</c:if>
				</c:if>
				
				<!-- 관리자 로그인 시-->
	
				<c:if test="${!empty admin}">				
					<c:url value="/removeQuestion" var="removeQuestion" />
					<sform:form id="board_edit_form" modelAttribute="question" action="${removeQuestion}" method="POST">
					<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentTitle"/>
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
               
               
               
            	</div>
			
			</div>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu3_1.png");
	});
	
	<c:url value="/help/qna/write" var="questionWrite"/>
	$("#help_read_write").on("click",function(e){
		e.preventDefault();
	    $("#help_read_form").attr("action","${questionWrite}");
	    $("#help_read_form").submit();
	});
	
	<c:url value="/help/qna" var="questionAnswer"/>
	$("#help_read_list").on("click",function(e){
		e.preventDefault();
	    location.href = "${questionAnswer}";
	});
	
	
	
	$("#manager_register").on("click",function(e){
		var manager_answer_letter = $("#manager_answer_letter").val();
		console.log(manager_answer_letter);
		if(manager_answer_letter==null || manager_answer_letter==""){
			alert("아무 것도 입력 하지 않으셨습니다.");
			return false;
		}else{
			$("#help_read_form")
			.append("<input type='hidden' name='userId' value='${question.userId}'/>")
			.append("<input type='hidden' name='content' value='"
					+ manager_answer_letter +"'/ >");
		}
	})
	
	$("#board_read_delete").on("click", function(){
		var res = confirm("게시글을 삭제하면 복구 할 수 없습니다.\n정말로 게시글을 삭제 하시겠습니까?")
		if(!res){
			return false; // preventDefault , StopPropagation
		}
	});
	
</script>
</html>