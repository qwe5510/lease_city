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
		<div class="help_main">
			<c:url value="/writeQuestion" var="writeQuestion"/>
				<sform:form id="question_answer_write_form" action="${writeQuestion}" method="post" modelAttribute="question">
					<table class=helpWriteTable>
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td colspan="1">
								<sform:label path="commentCategory">분류</sform:label>
							</td>
							<td colspan="3">
								<sform:radiobutton path="commentCategory" value="임대" label="임대" id="checked"/>
								<sform:radiobutton path="commentCategory" value="커뮤니티" label="커뮤니티"/>
								<sform:radiobutton path="commentCategory" value="이메일인증" label="이메일인증"/>
								<sform:radiobutton path="commentCategory" value="비밀번호/아이디찾기" label="비밀번호/아이디찾기"/>
								<sform:radiobutton path="commentCategory" value="평가" label="평가"/>
								<sform:radiobutton path="commentCategory" value="기타" label="기타"/>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td colspan="4">
								<sform:input path="commentTitle" placeholder="제목"/>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<sform:textarea path="commentContent" placeholder="영어 숫자 4000자, 한글 1330자 이내의 내용 입력."/>
							</td>
						</tr>
					</table>
						<div class="qna_buttonForm">
							<sform:button id="question_write_btn"><i class="icon-pencil"></i>작성</sform:button>
							<sform:button id="question_write_cancel_btn"><i class="icon-remove"></i>취소</sform:button>
						</div>
					</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	
	$("#checked").prop('checked', true);

	$("#help_frequenty").on("mouseover",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2_1.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4.png");
	});
	
	$("#help_frequenty").on("mouseout",function(){
		$("#help_frequenty_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu2.png");
		$("#help_question_img").attr("src","<%=request.getContextPath()%>/images/help/help_menu4_1.png");
	});
	<c:url value="/help/qna" var="qna"/>
		$("#question_write_cancel_btn").on("click", function(e){
		    e.preventDefault();
		    $("#question_answer_write_form").attr("action","${qna}");
		    $("#question_answer_write_form").submit();
		});
</script>
</html>