<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<br>
			<br>
			<c:url value="/board_write" var="board_write"/>
			<sform:form method="post" modelAttribute="comment" action="${board_write }">
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
					<td>날짜</td>
				</tr>
				<%
					for (int i = 0; i < 20; i++) {
						out.print("<tr><td colspan='6' class='boardLine'></td></tr>" + "<tr class='boardShow'>" 
								+"<td><sform:label path='commentNo'>444</sform:label></td>"
								+"<td><sform:label path='commentCategory'>잡담/경기</td>"
								+ "<td class='communityTitle'><sform:label path='commentTitle'>안녕하세요. 글자가 얼마나 얼마나 들어갈수있나 테스트 해보고 있습니다</sform:label></td>"
								+ "<td><sform:label path='userId'>중기건설(장필식)<sform:label></td>"
								+ "<td><sform:label path='hits'>4<sform:label></td>" 
								+ "<td><sform:label path='regDate'>2016-10-24<sform:label></td>" 
								+ "</tr>");
					}
				%>
				<tr>
					<td colspan="6" class="boardLine" style="height: 3px !important;"></td>
				</tr>
			</table>
			
			</sform:form>
			
			<sform:form method="post" modelAttribute="page" action="${board_write }">
				<div>
				<sform:select path="commentCategory">
					<sform:option value=""></sform:option>
				</sform:select>
				<input type="text" id="boardSearch" name="boardSearch" placeholder="검색어를 입력해주세요.">
				<%
					for(int i=0;i<10;i++){
						out.print("<a>"+i+"</a>");
					}
				%>
				<button>글작성</button>
				</div>
			</sform:form>
		</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>


</html>