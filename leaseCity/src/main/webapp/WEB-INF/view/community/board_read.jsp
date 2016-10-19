<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		<c:url value="/board_write" var="board_write" />
		<div class="board_read_main">

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
											value="${comment.userId}"></c:out>)
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
								
									${comment.commentContent}<br>
									<br>
									<br>
								</div>
							</td>
							<td width="2px" class="boardLine"></td>
						</tr>
						<tr>
							<td colspan="13" class='boardLine'></td>
						</tr>
					</table>
					<div style="text-align: left; padding: 10px;">
						<span>댓글 <b><c:out value="${comment.replyCount }"></c:out></b>개
						</span>
					</div>

					<div class="comment_reply">
						<ul class="board_read_reply">

							<c:if test="${!empty errorMsg }">
								<li><c:out value="${errorMsg}"></c:out></li>
								<li class="replyBaseLine"></li>
							</c:if>

							<c:forEach var="reply" items="${replys}">
								<fmt:formatDate value="${reply.regDate}"
									pattern="yyyy-MM-dd  hh:mm:ss" var="replyRegDate" />
								<li>
									<div class="reply_author">
										<c:out value="${reply.companyName}"></c:out>
									</div>
									<div class="reply_option">
										<button>
											<i class="icon-eraser"></i>
										</button>
									</div>
									<div class="reply_date">
										<c:out value="${replyRegDate}"></c:out>
									</div>
									<div class="reply_content">
										${reply.replyContent}"
									</div>
								</li>
								<li class="replyBaseLine"></li>
							</c:forEach>
						</ul>

						<div class="replyPage">
						<!-- 이전 페이지, 다음 페이지 변수 선언 -->
						<fmt:parseNumber
							value="${(((replyPage.currentPage-1)/10)-(((replyPage.currentPage-1)/10)%1))*10}"
							var="prevPage">
						</fmt:parseNumber>
						<fmt:parseNumber value="${prevPage+11}" var="nextPage">
						</fmt:parseNumber>


						<c:choose>
							<c:when test="${prevPage > 0}">
								<a href="<%=request.getContextPath()%>/board?currentPage=${prevPage}">
									<i class="icon-arrow-left">이전</i>
								</a>
							</c:when>
							<c:otherwise>
								<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
							</c:otherwise>
						</c:choose>

						<c:if test="${!empty replyPage.totalPage}">
							<c:choose>
								<c:when test="${(nextPage-1) >= replyPage.totalPage }">
									<c:forEach var="i" begin="${prevPage+1}" end="${replyPage.totalPage}">
										<c:choose>
											<c:when test="${i eq replyPage.currentPage}">
												<b><c:out value="${i}"></c:out></b>
											</c:when>
											<c:otherwise>
												<a href="#" id="replyPage${i}" onclick="moveReplyPage(${i}, ${replyPage.superNo})">
													<c:out value="${i}"></c:out>
												</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="${prevPage+1}" end="${nextPage-1}">
										<c:choose>
											<c:when test="${i eq replyPage.currentPage}">
												<b><c:out value="${i}"></c:out></b>
											</c:when>
											<c:otherwise>
												<a href="#" id="replyPage${i}" 
												onclick="moveReplyPage(${i}, ${comment.commentNo})">
													<c:out value="${i}"></c:out>
												</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<c:choose>
							<c:when test="${nextPage <= replyPage.totalPage}">
								<a ${nextPage}">
									다음<i class="icon-arrow-right"></i>
								</a>
							</c:when>
							<c:otherwise>
								<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
							</c:otherwise>
						</c:choose>
						
					</div>
					

					<textarea class="reply_input_area" rows="3" cols="50"></textarea>
					<button id="reply_registry" class="reply_registry">등록</button>
				</div>
		</div>
		<div class="board_read_bottom">
			<button id="board_read_write">
				<i class="icon-pencil"></i>글쓰기</button>
			<button id="board_read_list">
				<i class="icon-link"></i>목록</button>
		</div>
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>

</body>
<script>
	<c:url value="/board" var="board"/>
	$("#board_read_list").on("click", function(e) {
		e.preventDefault();
		$("#board_read_form").attr("action", "${board}");
		$("#board_read_form").submit();
	});

	$(document).on("click", "#reply_registry", function(e) {
		e.preventDefault();
	})
	
	$(document).on("click", ".replyPage a", function(event){
		event.preventDefault();
	})
	
	<c:url value="/boardReadReplyAjax" var="boardReadReplyAjax"></c:url>
	function moveReplyPage(currentPage, commentNo){
		
		$.ajax({
			method : "GET",
			url : "${boardReadReplyAjax}",
			data : {
				currentPage : currentPage,
				commentNo : commentNo
			},
			success:function(replys){
				$(".comment_reply").html("");
				$(".comment_reply")
				.append()
				.append()
			},
			error:function(xhr, status, error){
				
			}
		})
	}
	
</script>
</html>