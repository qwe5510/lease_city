<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src='//uchat.co.kr/uchat.php' charset='UTF-8'></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="board">
		<div class="uchat">
			<script>
				u_chat({
					room : 'yhj123',
					chat_record : true,
					width : '300',
					height : '300',
					conversation_limi : true,
					in_sound : true,
					say_id : true,
					skin : 1,
					mb_list_height : '50'
				});
			</script>
			</div>
			<div class="community">
				<img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
				<c:url value="/board_read" var="board_read"/>
				<sform:form id="board_write_form" action="writeComment" method="post" modelAttribute="comment">
					<table class="boardWriteTable">
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td>
								<sform:label path="kind">분류</sform:label>
							</td>
							<td>
								<sform:select path="kind"></sform:select>
							</td>
							<td>
								<sform:label path="locale">지역</sform:label>
							</td>
							<td>
								<sform:select path="locale"></sform:select>
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
								<sform:textarea path="commentContent" placeholder="형식에 구애받지 않고 자유롭게 입력하시면 됩니다."/>
							</td>
						</tr>
			
					</table>
					<div class="board_write_bottom">
						<sform:button> <i class="icon-pencil"></i>작성</sform:button>
						<sform:button id="cancel"><i class="icon-link"></i>취소</sform:button>
					</div>
				</sform:form>
			</div>
		</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
<c:url value="/board" var="board"/>
$("#cancel").on("click", function(e){
    e.preventDefault();
    $("#board_write_form").attr("action","${board}");
    $("#board_write_form").submit();
});
</script>
</html>