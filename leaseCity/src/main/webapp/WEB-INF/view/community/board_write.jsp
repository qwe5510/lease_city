<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
					height : '650',
					conversation_limi : true,
					in_sound : true,
					say_id : true,
					skin : 1,
					mb_list_height : '150'
				});
			</script>
			</div>
			<div class="community">
				<img alt="" src="<%=request.getContextPath()%>/images/logo/logo3.png">
				<sform:form action="#" method="post" modelAttribute="comment">
					<table class="boardWriteTable">
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
				</sform:form>
			</div>
		</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>