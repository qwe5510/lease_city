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
	
	<c:if test="${!empty board_message }">
      <script type="text/javascript">
         alert('${qna_message }');
      </script>
   </c:if>
	
	<%
      Date todayDate = new Date();
      String today = DateUtil.getDateString(todayDate);
      request.setAttribute("today", today);
    %>
    
	<c:url value="/FAQ" var="FAQ"/>
	<div class="help">
		<div class="help_menu">
			<div class="help_menu_inner1">
			<h2></h2>
			<br>
			</div>
			<ul class="help_menu_ul">
			<li class="help_menu_first"><a id="help_frequenty" href="${FAQ }"><img id="help_frequenty_img" src="<%=request.getContextPath()%>/images/help/help_menu2.png"></a></li>
			<li><a id="help_question" href="#"><img id="help_question_img" src="<%=request.getContextPath()%>/images/help/help_menu4_1.png"></a></li>
			</ul>
		</div>
		<div class="help_read_main">
			<c:url value="/question_answer_write" var="question_answer_write"/>
			<div class="help_read_main_inner">
			<sform:form id="help_read_form" action="${question_answer_write }" method="post" modelAttribute="comment">
			<div class="board_read_line">
				<table class="board_read_table">
						<tr>
							<td colspan='13' class='boardLine'></td>
						</tr>
						<tr>
							<td width="2px" class="boardLine"></td>
							<th>지역</th>
							<td width="2px" class="boardLine"></td>
							<td><c:out value="${comment.locale }"></c:out></td>
							<td width="2px" class="boardLine"></td>
							<th>분류</th>
							<td width="2px" class="boardLine"></td>
							<td><c:out value="${comment.kind }"></c:out></td>
							<td width="2px" class="boardLine"></td>
							<th><span>조회수</span></th>
							<td width="2px" class="boardLine"></td>
							<td width="100px"><c:out value="${comment.hits }"></c:out></td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan='13' class='boardLine'></td>
						</tr>
						<tr>
							<td width="2px" class="boardLine"></td>
							<td align="left" colspan="11" style="padding-left: 25px"><span
								style="font-size: 1.3em">${comment.commentTitle}</span></td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan="13" class='boardLine'></td>
						</tr>
						<fmt:formatDate value="${comment.regDate}"
							pattern="yyyy-MM-dd  hh:mm:ss" var="commentRegDate" />
						<tr>
							<td width="2px" class="boardLine"></td>
							<td colspan="6" align="left"><span
								class="board_read_comment_author"> <c:out
										value="${comment.companyName}"></c:out> <span
									class="board_read_comment_userId"> (<c:out
											value="${comment.outputId}"></c:out>)
								</span>
							</span></td>
							<td colspan="5" align="right"><b><c:out
										value="${commentRegDate}"></c:out></b></td>
							<td width="2px" class="boardLine"></td>
						</tr>

						<tr class="board_read_comment" align="left" valign="top">
							<td width="2px" class="boardLine"></td>
							<td colspan="11">
								<div class="comment_content">
									${comment.commentContent}
								</div>
							</td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan="13" class='boardLine'></td>
						</tr>
					</table>
            <div id="manager_answer_show"></div>
            <div style="text-align: left; padding: 10px;">
            <span><b>답변</b></span>
            </div>
            <div class="manager_answer">
            	  <textarea id="manager_answer_letter" placeholder="답변을 등록해주세요."></textarea>
                  <sform:button id="manager_register">등록</sform:button>
               
            </div>
				<div style="text-align: left; padding: 10px;">
				<div></div>
				</div>
				
			</div>
			<div class="board_read_bottom">
               <sform:button id="help_read_write"><i class="icon-pencil"></i>글쓰기</sform:button>
               <sform:button id="help_read_list"><i class="icon-link"></i>목록</sform:button>
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
	<c:url value="/question_answer" var="question_answer"/>
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