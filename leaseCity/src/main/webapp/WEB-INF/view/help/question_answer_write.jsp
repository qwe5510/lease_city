<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
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
		<div class="help_main">
			<c:url value="/question_answer_read" var="question_answer_read"/>
				<sform:form id="question_answer_write_form" action="${question_answer_read }" method="post" modelAttribute="question">
					<table class=helpWriteTable>
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td colspan="1">
								<sform:label path="questionCategory">분류</sform:label>
							</td>
							<td colspan="3">
								<sform:radiobutton path="questionCategory" value="lease" label="임대"/>
								<sform:radiobutton path="questionCategory" value="community" label="커뮤니티"/>
								<sform:radiobutton path="questionCategory" value="email" label="이메일인증"/>
								<sform:radiobutton path="questionCategory" value="passId" label="비밀번호/아이디찾기"/>
								<sform:radiobutton path="questionCategory" value="evaluate" label="평가"/>
								<sform:radiobutton path="questionCategory" value="etc" label="기타"/>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td colspan="4">
								<sform:input path="questionTitle" placeholder="제목"/>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<sform:textarea path="questionContent" placeholder="형식에 구애받지 않고 자유롭게 입력하시면 됩니다."/>
							</td>
						</tr>
					</table>
						<div>
						<sform:button> <i class="icon-pencil"></i>작성</sform:button>
						<sform:button id="question_write_btn"><i class="icon-link"></i>취소</sform:button>
						</div>
					</sform:form>
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
		$("#question_write_btn").on("click", function(e){
		    e.preventDefault();
		    $("#question_answer_write_form").attr("action","${question_answer}");
		    $("#question_answer_write_form").submit();
		});
</script>
</html>