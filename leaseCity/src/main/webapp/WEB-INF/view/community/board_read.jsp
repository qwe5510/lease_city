<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			<c:url value="/board_write" var="board_write"/>
			<div class="board_read_main">
			<sform:form id="board_read_form" action="${board_write }" method="post" modelAttribute="comment">
			<div class="board_read_line">
				<table class="board_read_table">
					<%-- <c:set value="" var=""></c:set> --%>
					<tr>
						<td><span>${userId }  ${commentCategory }</span></td>
						<td><span>${regDate }</span></td>
						<td><span>${hits }"</span></td>
					</tr>
						<tr><td colspan='6' class='boardLine'></td></tr>
					<tr>
						<td colspan="3"><span>${commentTitle }</span></td>
					</tr>
					<tr><td colspan="3" class='boardLine'></td></tr>
					<tr class="board_read_comment">
						<td colspan="3"><span>${commentContent }</span></td>
					</tr>
				</table>
				<div style="text-align: left; padding: 10px;">
				<span>댓글 ${replyCount }개</span>
				</div>
				
				<div style="background: white;">
				<ul class="board_read_reply">
					<li>
						<div>글쓴이</div>
						<div>내용</div>
					</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>123</li>
					<li class="replyBaseLine"></li>
					<li>
						<textarea></textarea>
						<button>등록</button>
					</li>
				</ul>
				</div>
				<div>
							<a><i class="icon-arrow-left"></i>이전</a>
							<%
							for(int i=0;i<10;i++){
								out.print("<a>"+i+"</a>");
							}
							%>
							<a>다음<i class="icon-arrow-right"></i></a>
				</div>
				
			
			</div>
				<div class="board_read_bottom">
					<sform:button id="board_read_write"><i class="icon-pencil"></i>글쓰기</sform:button>
					<sform:button id="board_read_list"><i class="icon-link"></i>목록</sform:button>
				</div>
			</sform:form>
			</div>
			</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script>
<c:url value="/board" var="board"/>
$("#board_read_list").on("click", function(e){
    e.preventDefault();
    $("#board_read_form").attr("action","${board}");
    $("#board_read_form").submit();
});
</script>
</html>