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
				<sform:form id="board_adjust_form" action="adjustComment" method="post" modelAttribute="comment">
					<table class="boardAdjustTable">
						<tr>
							<td colspan="4" class="boardLine" style="height: 4px !important;"></td>
						</tr>
						<tr>
							<td>
								<sform:label path="kind">분류</sform:label>
							</td>
							<td>
								<sform:select path="kind">
									<sform:option value="잡담">잡담</sform:option>
									<sform:option value="공유">공유</sform:option>
									<sform:option value="상담">상담</sform:option>
									<sform:option value="기타">기타</sform:option>
								</sform:select>
							</td>
							<td>
								<sform:label path="locale">지역</sform:label>
							</td>
							<td>
								<sform:select path="locale">
									<sform:option value="서울">서울</sform:option>
									<sform:option value="인천">인천</sform:option>
									<sform:option value="대전">대전</sform:option>
									<sform:option value="대구">대구</sform:option>
									<sform:option value="울산">울산</sform:option>
									<sform:option value="부산">부산</sform:option>
									<sform:option value="경기">경기</sform:option>
									<sform:option value="강원">강원</sform:option>
									<sform:option value="충남">충남</sform:option>
									<sform:option value="충북">충북</sform:option>
									<sform:option value="전남">전남</sform:option>
									<sform:option value="전북">전북</sform:option>
									<sform:option value="경남">경남</sform:option>
									<sform:option value="경북">경북</sform:option>
								</sform:select>
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
								<sform:textarea id="commentContent" path="commentContent" placeholder="형식에 구애받지 않고 자유롭게 입력하시면 됩니다."/>
							</td>
						</tr>
			
					</table>
					<div class="board_adjust_bottom">
						<sform:button id="adjust"> <i class="icon-edit"></i>수정</sform:button>
						<sform:button id="cancel"> <i class="icon-remove"></i>취소</sform:button>
						<input type="hidden" name="currentPage" value="${currentPage}" />
						<!-- 로그인 유저 아이디  -->
						
						<sform:hidden path="commentNo"/>
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
    location.href = "${board}";
});


$("#adjust").on("click",function(e){
	e.preventDefault();
	var commentTitle = $("#commentTitle").val();
	var commentContent = $("#commentContent").val();
	
	$("#board_adjust_form").append("<input type='hidden' name='userId' value='${loginUser.userId}'/>")
	
	if(commentTitle==null || commentTitle==""){
		alert("제목을 입력해주세요.");
	}else if(commentContent==null || commentContent==""){
		alert("내용을 입력해주세요.");
	}else{
		$("#board_adjust_form").submit();
	}
});

</script>
</html>