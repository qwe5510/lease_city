<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
               <tr><td colspan='13' class='boardLine'></td></tr>
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
                  	<tr><td colspan='13' class='boardLine'></td></tr>
               <tr>
               		<td width="2px" class="boardLine"></td>
                  	<td align="left" colspan="11" style="padding-left: 25px">
                  	<span style="font-size: 1.3em">${comment.commentTitle}</span></td>
                  	<td width="2px" class="boardLine"></td>
               </tr>
               <tr><td colspan="13" class='boardLine'></td></tr>
               <fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd  hh:mm:ss" 
               			var="commentRegDate"/>
               <tr>
               	  <td width="2px" class="boardLine"></td>
               	  <td colspan="11" align="right"><b><c:out value="${commentRegDate}"></c:out></b></td>
               	  <td width="2px" class="boardLine"></td>
               </tr>
               <tr>
               	  <td width="2px" class="boardLine"></td>
                  <td colspan="11" align="right"><span style="font-size: 1.2em"><c:out value="${comment.companyName}"></c:out></span></td>
                  <td width="2px" class="boardLine"></td>
               </tr>
                                 	
               <tr class="board_read_comment" align="left" valign="top">
               	  <td width="2px" class="boardLine"></td>
                  <td colspan="11" style="padding-left: 20px">
                  	<p><c:out value="${comment.commentContent}"></c:out></p>
                  </td>
                  <td width="2px" class="boardLine"></td>
               </tr>
               <tr><td colspan="13" class='boardLine'></td></tr>
            </table>
            <div style="text-align: left; padding: 10px;">
            <span>댓글 <b><c:out value="${comment.replyCount }"></c:out></b>개</span>
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
                     <%
                     for(int i=0;i<10;i++){
                        out.print("<a>"+i+"</a>");
                     }
                     %>
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