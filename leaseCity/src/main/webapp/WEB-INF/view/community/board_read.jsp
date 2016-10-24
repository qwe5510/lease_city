<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="leasecity.util.DateUtil"%>
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
	
	<c:if test="${!empty board_message }">
      <script type="text/javascript">
         alert('${board_message }');
      </script>
   </c:if>
	
	<%
      Date todayDate = new Date();
      String today = DateUtil.getDateString(todayDate);
      request.setAttribute("today", today);
    %>
	
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
							<td colspan="6" align="left">
							
								<span class="board_read_comment_author"> 
									${comment.companyName}
								<c:if test="${comment.userId != 'admin'}"> 
									<span class="board_read_comment_userId">
										(${comment.outputId})
									</span>
								</c:if>
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
					<div style="text-align: left; padding: 10px;">
						<span id="comment_reply_count">댓글 <b>${comment.replyCount}</b>개</span>
					</div>

					<div class="comment_reply">
						<ul class="board_read_reply">

							<c:if test="${!empty errorMsg }">
								<li>${errorMsg}</li>
								<li class="replyBaseLine"></li>
							</c:if>

							<c:forEach var="reply" items="${replys}">
								<fmt:formatDate value="${reply.regDate}"
									pattern="yyyy-MM-dd  hh:mm:ss" var="replyRegDate" />
								<li id="reply_${reply.replyNo}">
									<div class="reply_author">
										${reply.companyName}
									</div>
									<!-- 이부분 Session Filter 해야 함 -->
									<div class="reply_option">
										<c:if test="${!empty admin}">
											<c:if test="${admin.userId eq reply.userId}">
											<button title="댓글 수정" class="reply_adjust"><i class="icon-eraser"></i></button>
											<button title="댓글 수정 취소" style="display: none;" class="reply_adjust_cancel"><i class="icon-eraser"></i></button>
										</c:if>
											<button title="댓글 삭제" id="reply_remove" class="reply_remove"><i class="icon-remove"></i></button>
										</c:if>
										
										<c:if test="${!empty loginUser and loginUser.userId eq reply.userId}">
											<button title="댓글 수정" class="reply_adjust"><i class="icon-eraser"></i></button>
											<button title="댓글 수정 취소" style="display: none;" class="reply_adjust_cancel"><i class="icon-eraser"></i></button>
											<button title="댓글 삭제" id="reply_remove" class="reply_remove"><i class="icon-remove"></i></button>
										</c:if>
									</div>
									<div class="reply_date">
										${replyRegDate}
									</div>
									<div class="reply_content">
										${reply.replyContent}
									</div>
									<div style="display: none;"class="reply_content_temp">
										${reply.replyContent}
									</div>
									<div class="reply_data" style="display: none;">
										<span>${comment.commentNo}</span>
										<span>${reply.replyNo}</span>
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
								<a href="#" id="replyPage${prevPage}" 
									onclick="moveReplyPage(${prevPage}, ${comment.commentNo})"><i class="icon-arrow-left">이전</i></a>
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
												<a href="#" id="replyPage${i}" 
													onclick="moveReplyPage(${i}, ${comment.commentNo})"><c:out value="${i}"></c:out></a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="${prevPage+1}" end="${nextPage-1}">
										<c:choose>
											<c:when test="${i eq replyPage.currentPage}"><b><c:out value="${i}"></c:out></b>
											</c:when>
											<c:otherwise>
												<a href="#" id="replyPage${i}" 
												onclick="moveReplyPage(${i}, ${comment.commentNo})"><c:out value="${i}"></c:out></a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:if>
						
						<c:choose>
							<c:when test="${nextPage <= replyPage.totalPage}">
								<a href="#" id="replyPage${nextPage}" 
									onclick="moveReplyPage(${nextPage}, ${comment.commentNo})">다음<i class="icon-arrow-right"></i></a>
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
		
		<button id="board_read_list">
				<i class="icon-list"></i>목록</button>
		
		<button id="board_read_write">
			<i class="icon-pencil"></i>글쓰기</button>

			<c:if test="${empty admin}">
				<c:if test="${comment.userId eq loginUser.userId}">
					<c:url value="/board_adjust" var="board_adjust" />
					<sform:form id="board_edit_form" modelAttribute="comment" action="${board_adjust}" method="POST">
					<sform:button id="board_read_adjust"><i class="icon-edit"></i>수정</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentContent"/>
					<sform:hidden path="commentTitle"/>
					<sform:hidden path="locale"/>
					<sform:hidden path="kind"/>
					<input name="userId" type="hidden" value="${loginUser.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
			
				<!-- 관리자가 로그인했을 때도 출력되게 해야함 -->
				<c:if test="${comment.userId eq loginUser.userId}">
					<c:url value="/boardRemove" var="boardRemove" />
					<sform:form id="board_edit_form" modelAttribute="comment" action="${boardRemove}" method="POST">
					<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentTitle"/>
					<input name="userId" type="hidden" value="${loginUser.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
			</c:if>
			
			<!-- 관리자 로그인 시-->
			<c:if test="${!empty admin}">
				
				<c:if test="${comment.userId eq admin.userId}">
					<c:url value="/board_adjust" var="board_adjust" />
					<sform:form id="board_edit_form" modelAttribute="comment" action="${board_adjust}" method="POST">
					<sform:button id="board_read_adjust"><i class="icon-edit"></i>수정</sform:button>
					<sform:hidden path="commentNo"/>
					<sform:hidden path="commentContent"/>
					<sform:hidden path="commentTitle"/>
					<sform:hidden path="locale"/>
					<sform:hidden path="kind"/>
					<input name="userId" type="hidden" value="${admin.userId}" />
					<input name="currentPage" type="hidden" value="${page.currentPage}">
					</sform:form>
				</c:if>
				
				<c:url value="/boardRemove" var="boardRemove" />
				<sform:form id="board_edit_form" modelAttribute="comment" action="${boardRemove}" method="POST">
				<sform:button id="board_read_delete"><i class="icon-remove"></i>삭제</sform:button>
				<sform:hidden path="commentNo"/>
				<sform:hidden path="commentTitle"/>
				<input name="userId" type="hidden" value="${comment.userId}" />
				<input name="currentPage" type="hidden" value="${page.currentPage}">
				</sform:form>
			</c:if>

		</div>
	</div>
	<br>
	<div class="community">
         
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
               <c:choose>
                  <c:when test="${!empty page.keyword and page.order eq 'ASC'}">
                     <td>날짜<a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <td>날짜<a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=ASC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:when test="${page.order eq 'ASC' }">
                     <td>날짜<a href="<%=request.getContextPath()%>/board?order=DESC"><i class="icon-sort"></i></a></td>
                  </c:when>
                  <c:otherwise>
                     <td>날짜<a href="<%=request.getContextPath()%>/board?order=ASC"><i class="icon-sort"></i></a></td>
                  </c:otherwise>
               </c:choose>
            </tr>


            <c:forEach var="comment" items="${comments}">
               <tr>
                  <td colspan="6" class="boardLine" style="height: 4px !important;"></td>
               </tr>
               <tr class="boardShow">
                  <td><c:out value="${comment.commentRowNum}" /></td>
                  <td><c:out value="${comment.commentCategory}" /></td>
                  <td class='communityTitle'>
                  
                  <c:choose>
	                  <c:when test="${!empty page.keyword and !empty page.order}">
	                    <a href="<%=request.getContextPath() %>/board_read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.order}">
	                    <a href="<%=request.getContextPath() %>/board_read?currentPage=${page.currentPage}&order=${page.order}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:when test="${!empty page.keyword}">
	                    <a href="<%=request.getContextPath() %>/board_read?currentPage=${page.currentPage}&search=${page.search}&keyword=${page.keyword}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:when>
	                  <c:otherwise>
	                    <a href="<%=request.getContextPath() %>/board_read?currentPage=${page.currentPage}&commentNo=${comment.commentNo}">
                     		${comment.commentTitle}
                     	</a>
	                  </c:otherwise>
               		</c:choose>

                      <c:if test="${comment.hits >= 100}">
                     	<span class="label label-important">
                     		hot
                     	</span>
                     </c:if>
                     
                     <c:if test="${!(comment.replyCount eq 0)}">
                     	<span class="label label-warning">
                     		+${comment.replyCount}
                     	</span>
                     </c:if>
                  </td>
                  
                  <td>
                  <c:choose>
                  	<c:when test="${comment.userId eq 'admin'}">
                  	<b>${comment.companyName}</b>
                  	</c:when>
                  	<c:otherwise>
                  		${comment.companyName}
                  	</c:otherwise>
                  </c:choose>
                  </td>
                  <td>${comment.hits}</td>               
                  
                  <fmt:formatDate value="${comment.regDate}"
                        pattern="yyyy-MM-dd"
                        var="strRegDate"/>
                  
                  <fmt:formatDate value="${comment.regDate}"
                        pattern="hh:mm:ss"
                        var="strRegTime"/>
                  
                  <c:choose>
                  <c:when test="${strRegDate eq today}">
                     <td><c:out value="${strRegTime}" /></td>
                  </c:when>
                  <c:otherwise>
                     <td><c:out value="${strRegDate}" /></td>
                  </c:otherwise>
                  </c:choose>                           
               </tr>
            </c:forEach>
            
            <c:if test="${empty page.totalPage and !empty errorMsg }">
               <tr>
                  <td colspan="6"><c:out value="${errorMsg}"></c:out></td>
               </tr>
            </c:if>
            <tr>
               <td colspan="6" class="boardLine" style="height: 3px !important;"></td>
            </tr>
  
         </table>
         <div class="boardSearch">
         <div class="boardPage" style="display: inline-block;">
            
            <!-- 이전 페이지, 다음 페이지 변수 선언 -->
            <fmt:parseNumber 
               value="${(((page.currentPage-1)/10)-(((page.currentPage-1)/10)%1))*10}" 
               var="prevPage">
            </fmt:parseNumber>
            <fmt:parseNumber 
               value="${prevPage+11}" 
               var="nextPage">
            </fmt:parseNumber>
               
            
            <c:choose>
            <c:when test="${prevPage > 0}">
                           
               <c:choose>
                  <c:when test="${!empty page.keyword and !empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/board?currentPage=${prevPage}">
                     <i class="icon-arrow-left">이전</i></a>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
            <a style="color: black;"><i class="icon-arrow-left">처음</i></a>
            </c:otherwise>
            </c:choose>            
            
            <c:if test="${!empty page.totalPage}">
               <c:choose>
                  <c:when test="${(nextPage-1) >= page.totalPage }">
                     <c:forEach var="i" begin="${prevPage+1}" end = "${page.totalPage}">
                        <c:choose>
                           <c:when test="${i eq page.currentPage}">
                              <b><c:out value="${i}"></c:out></b>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                                 <c:when test="${!empty page.keyword and !empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/board?currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                  </c:when>
                  <c:otherwise>
                     <c:forEach var="i" begin="${prevPage+1}" end = "${nextPage-1}">
                        <c:choose>
                           <c:when test="${i eq page.currentPage}">
                              <b><c:out value="${i}"></c:out></b>
                           </c:when>
                           <c:otherwise>
                              <c:choose>
                                 <c:when test="${!empty page.keyword and !empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.order}">
                                    <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:when>
                                 <c:when test="${!empty page.keyword}">
                                    <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>                        
                                 </c:when>
                                 <c:otherwise>
                                    <a href="<%=request.getContextPath()%>/board?currentPage=${i}">
                                       <c:out value="${i}"></c:out>
                                    </a>
                                 </c:otherwise>
                              </c:choose>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                  </c:otherwise>
               </c:choose>
            </c:if>
            
            <c:choose>
            <c:when test="${nextPage <= page.totalPage}">
               <c:choose>
               <c:when test="${!empty page.keyword and !empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${nextPage}">
               		      다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.order}">
                     <a href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${nextPage}">
                   		  다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:when test="${!empty page.keyword}">
                     <a href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${nextPage}">
                   		  다음<i class="icon-arrow-right"></i></a>
                  </c:when>
                  <c:otherwise>
                     <a href="<%=request.getContextPath()%>/board?currentPage=${nextPage}">
                 		    다음<i class="icon-arrow-right"></i></a>
                  </c:otherwise>
               </c:choose>
            </c:when>
            <c:otherwise>
               <a style="color: black;">끝<i class="icon-arrow-right"></i></a>
            </c:otherwise>
            </c:choose>
         </div>
         
         <c:url value="/board" var="board"/> 
         <sform:form method="get" modelAttribute="page" action="${board }">
                  
                  <div class="boardBottom">
                     <sform:select path="search">
                        <sform:option value="COMPANY_NAME">글쓴이</sform:option>
                        <sform:option value="TITLE">제목</sform:option>
                        <sform:option value="TITLE_AND_CONTENT">제목+내용</sform:option>
                        <sform:option value="LOCAL">지역명</sform:option>
                     </sform:select>
                     <sform:input path="keyword" placeholder="검색어를 입력해주세요."/>
                     <button id="boardBtn"><i class="icon-search"></i>검색</button>
                  </div>
         </sform:form>
         </div>
      </div>
	
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>



</body>
<script>

	var g_totalPage = ${replyPage.totalPage}; //총 페이지
	var g_currentPage = ${replyPage.currentPage}; //현재 페이지

	Date.prototype.format = function(f) {
	    if (!this.valueOf()) return " ";
	 
	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var d = this;
	     
	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear();
	            case "yy": return (d.getFullYear() % 1000).zf(2);
	            case "MM": return (d.getMonth() + 1).zf(2);
	            case "dd": return d.getDate().zf(2);
	            case "E": return weekName[d.getDay()];
	            case "HH": return d.getHours().zf(2);
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	            case "mm": return d.getMinutes().zf(2);
	            case "ss": return d.getSeconds().zf(2);
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	            default: return $1;
	        }
	    });
	};
	 
	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);};
	
	//날짜에 관한 스크립트 함수


	<c:url value="/board" var="board"/>
	//bind - 키 - 값, live - 객체 - 자바스크립트 변수 (값)
	$("#board_read_list").on("click", function(e){
		e.preventDefault();
		location.href="${board}";
	});
	
	<c:url value="/board_write" var="board_write"/>
	$("#board_read_write").on("click", function(e){
		e.preventDefault();
		location.href="${board_write}";
	});
	
	//게시글 삭제
	$("#board_read_delete").on("click", function(e){	
		var res = confirm("정말로 게시글을 삭제하시겠습니까?");
		if(!res){
			return false;
		}
	});
	

	//클릭 submit 방지
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
			success:function(map){
				$(".board_read_reply").html("");
				var replys = map.replys;
				var page = map.page;
				
				var str="";
				var pageStr="";
				
				$.each(replys, function(idx, reply){				
					str+=("<li>");
					str+=("<div class='reply_author'>");
					str+=(reply.companyName+"</div>");
					<c:if test="${!empty admin}">
					str+=("<div class='reply_option'>");
					if("${admin.userId}" == reply.userId){
						str+=("<button title='댓글 수정' style='margin-right:3px;' class='reply_adjust'>");
						str+=("<i class='icon-eraser'></i></button>");
						str+=("<button title='댓글 수정 취소' style='margin-right:3px; display: none;' class='reply_adjust_cancel'>");
						str+=("<i class='icon-eraser'></i></button>");
					}
					str+=("<button title='댓글 삭제' id='reply_remove' class='reply_remove'>");
					str+=("<i class='icon-remove'></i></button></div>");
					</c:if>
					<c:if test="${!empty loginUser}">
						if("${loginUser.userId}" == reply.userId){
							str+=("<div class='reply_option'>");
							str+=("<button title='댓글 수정' style='margin-right:3px;' class='reply_adjust'>");
							str+=("<i class='icon-eraser'></i></button>");
							str+=("<button title='댓글 수정 취소' style='margin-right:3px; display: none;' class='reply_adjust_cancel'>");
							str+=("<i class='icon-eraser'></i></button>");
							str+=("<button title='댓글 삭제' id='reply_remove' class='reply_remove'>");
							str+=("<i class='icon-remove'></i></button></div>");
						}
					</c:if>
					str+=("<div class='reply_date'>");
					str+=(new Date(reply.regDate).format("yyyy-MM-dd hh:mm:ss"));
					str+=("</div>");
					str+=("<div class='reply_content'>"+reply.replyContent+"</div>");
					str+=("<div style='display: none;' class='reply_content_temp'>");
					str+=(reply.replyContent+"</div>");
					str+=("<div class='reply_data' style='display: none;'>");
					str+=("<span>${comment.commentNo}</span>");
					str+=("<span>"+reply.replyNo+"</span></div></li>");
					str+=("<li class='replyBaseLine'></li>");			
				})
				
				$(".board_read_reply").html(str);
				
				var prevPage = (((page.currentPage-1)/10)-(((page.currentPage-1)/10)%1))*10;
				var nextPage = prevPage+11;
				
				$(".replyPage").html("");
				
				if(prevPage >0){
					pageStr+=("<a href='#' id='replyPage"+prevPage+"'")
					pageStr+=("onclick='moveReplyPage("+prevPage+", "+page.superNo+")'></a>");
				}else{
					pageStr+=("<a style='color: black;'><i class='icon-arrow-left'>처음</i></a>");
				}
				
				if(page.totalPage != null){
					g_currentPage = page.currentPage;
					g_totalPage = page.totalPage;
					
					if(nextPage-1 >= page.totalPage){
						for(var i=prevPage+1; i<=page.totalPage; i++){
							if(i == page.currentPage){
								pageStr+="<b>"+i+"</b>";
							}
							else{
								pageStr+="<a href='#' id='replyPage"+i+"'";
								pageStr+="onclick='moveReplyPage("+i+", "+page.superNo+")'>"+ i +"</a>";
							}							
						}
					}else{
						for(var i=prevPage+1; i<page.nextPage-1; i++){
							if(i == page.currentPage){
								pageStr+="<b> "+i+" </b>";
							}
							else{
								pageStr+=" <a href='#' id='replyPage"+i+"'";
								pageStr+="onclick='moveReplyPage("+i+", "+page.superNo+")'>"+ i +"</a> ";
							}
						}
					}
				}
				
				if(nextPage <= page.totalPage){
					pageStr+=("<a href='#' id='replyPage"+nextPage+"'")
					pageStr+=("onclick='moveReplyPage("+nextPage+", "+page.superNo+")'></a>");
				}else{
					pageStr+=("<a style='color: black;'>끝<i class='icon-arrow-right'></i></a>");
				}
				
				$(".replyPage").html(pageStr);
			},
			error:function(xhr, status, error){
				alert(error + " : 덧글 불러오기 실패");
			}
		})
	}
	
	//댓글 등록 입력란
	<c:url value="/replyRegistryAjax" var="replyRegistryAjax"></c:url>
	$("#reply_registry").on("click", function(){
		
		var replySize = 10; //덧글 사이즈
		var inputArea = $(".reply_input_area").val(); // Area에 대한 값 전환
		
		//덧글 공백입력 막기
		if(inputArea == null || inputArea == ""){
			return false;
		}
		
		$.ajax({
			method : "GET",
			url : "${replyRegistryAjax}",
			data : {
				commentNo : ${comment.commentNo},
				userId : "${!empty admin?admin.userId:loginUser.userId}",
				replyContent : inputArea				
			},
			success : function(page){
				if(page != null){
					alert("덧글 등록이 완료되었습니다.");
					g_currentPage = page.totalPage;
					g_totalPage = page.totalPage;
					moveReplyPage(page.totalPage, ${comment.commentNo});
					$("#comment_reply_count").html("댓글 <b>"+ page.totalCount +"</b>개</span>");
					$(".reply_input_area")[0].value="";
					//덧글등록 안내 후 페이지 가장 끝단으로 이동.
				}else{
					alert("덧글 등록 실패");
				}
			},
			fail : function(error){
				alert(error);
			}
		});
	});

	
	
	
	//수정 취소 
	$(document).on("click", ".reply_adjust_cancel", function(){
		var li = $(this).parent().parent();
		var liChildren = li.children();
		var replyContent = $($(liChildren[3])[0]);
		var contentText = replyContent.next().html();
		
		replyContent.html(contentText);	
		
		//수정 보이게 하기.
		$(this).css("display", "none");
		var adjustCancel = $(this).prev();
		adjustCancel.css("display", "inline-block");
	});
	
	
	//덧글 수정하기.
	$(document).on("click", ".reply_adjust", function(){	
		var li = $(this).parent().parent();
		var liChildren = li.children();
		var replyContent = $($(liChildren[3])[0]);
		var contentText = replyContent.html().trim().replace(/<br>/gi, "\n");
		
		str="";
		str+="<div style='padding-top: 5px;'><textarea style='vertical-align:middle;' class='reply_input_area' rows='3' cols='50'>"
		str+=contentText+"</textarea>";
		str+="<button id='reply_adjust' class='reply_registry'>등록</button></div>";

		replyContent.html(str)
		
		//수정취소 보이게 하기.
		$(this).css("display", "none");
		var adjustCancel = $(this).next();
		adjustCancel.css("display", "inline-block");
		
	})
	
	<c:url value="/replyAdjustAjax" var="replyAdjustAjax"></c:url>
	$(document).on("click", "#reply_adjust", function(){
		var inputArea=$(this).prev().val();
		
		var li = $(this).parent().parent().parent();
		var liChildren = li.children();
		var replyInfo = $(liChildren[5]).children();
		
		var commentNo = $(replyInfo[0]).html();
		var replyNo = $(replyInfo[1]).html();
		
		$.ajax({
			method : "GET",
			url : "${replyAdjustAjax}",
			data : {
				commentNo : commentNo,
				userId : "${!empty admin?admin.userId:loginUser.userId}",
				replyNo : replyNo,
				replyContent : inputArea				
			},
			success : function(page){
				if(page != null && page != ""){
					moveReplyPage(g_currentPage, commentNo);
					$("#comment_reply_count").html("댓글 <b>"+ page.totalCount +"</b>개</span>");
					//덧글 수정 후 
				}else{
					alert("덧글 수정 실패");
				}
			},
			fail : function(error){
				alert(error);
			}
		});
	});
	
	<c:url value="/replyRemoveAjax" var="replyRemoveAjax"></c:url>
	$(document).on("click", "#reply_remove", function(){
		var res = confirm("삭제 후 복구가 불가능합니다.\n정말로 삭제 하시겠습니까?");
		
		var li = $(this).parent().parent();
		var liChildren = li.children();
		var replyInfo = $(liChildren[5]).children();
		
		var commentNo = $(replyInfo[0]).html();
		var replyNo = $(replyInfo[1]).html();
		
		if(res){
			$.ajax({
				method : "GET",
				url : "${replyRemoveAjax}",
				data : {
					commentNo : commentNo,
					userId : "${admin==null?loginUser.userId:admin.userId}",
					replyNo : replyNo			
				},
				success : function(page){
					if(page != null && page != ""){						
						if(g_currentPage > page.totalPage){
							g_currentPage = page.totalPage;
							g_totalPage = page.totalPage;
						}else if(g_currentPage <= page.totalPage){
							g_totalPage = page.totalPage;
						}
						moveReplyPage(g_currentPage, commentNo);
						$("#comment_reply_count").html("댓글 <b>"+ page.totalCount +"</b>개</span>");
						//덧글 수정 후 
					}else{
						alert("덧글 삭제 실패");
					}
				},
				fail : function(error){
					alert(error);
				}
			});
		}
	});
	
	 $("#boardBtn").on("click",function(e){
			e.preventDefault();
			var keyword = $("#keyword").val();
			var searchRegExp = /^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/;
			if(!searchRegExp.test(keyword)){
				alert("조건이 알맞지 않습니다.\n(%를 제외한 2글자 이상 문자.)");
				return false;
			}else{
				$("form").submit();
			}
		}) 
	
</script>
</html>