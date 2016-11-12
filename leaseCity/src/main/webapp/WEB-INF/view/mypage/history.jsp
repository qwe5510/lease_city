<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업 기록 | LEASE CITY</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="myinfo">
	<div class="mypage_menu">
	</div>
	<div class="mypage_main">
		<table class="history_table">
			<tr>
				<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
			</tr>
			<tr>
				<td>번호</td>
				<td>임대번호</td>
				<td>업무기간(신청날짜)</td>
				<td>상대업체</td>
				<td>평가하기</td>
			</tr>
			
			<c:forEach var="workLog" items="${workLogs}">
				<tr>
					<td colspan="5" class="boardLine"></td>
				</tr>
				<tr>
					<td>1</td>
					<td>20051</td>
					<td>2016.05.06~2016.10.30 (2016.04.30)</td>
					<td>건설업체</td>
					<td>진행중</td>
				</tr>
				
			</c:forEach>
			
			
			
			
			<tr>
				<td colspan="5" class="boardLine"></td>
			</tr>
			<tr>
				<td>2</td>
				<td>20083</td>
				<td>2016.07.10~2016.11.28(2016.04.20)</td>
				<td>건설업체</td>
				<td><button id="history_evaluate">평가</button></td>
			</tr>
			<tr>
				<td colspan="5" class="boardLine"></td>
			</tr>
			<tr>
				<td>3</td>
				<td>21111</td>
				<td>2016.07.10~2016.11.28(2016.04.20)</td>
				<td>상대업체</td>
				<td>완료</td>
			</tr>
			<tr>
				<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
			</tr>
		</table>
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
	</div>
	</div>
	<!--Bottom-->
	<section id="bottom" class="main">
		<!--Container-->
		<div class="container">

			<!--row-fluids-->
			<div class="row-fluid">

				<!--Contact Form-->
				<div class="span3">
					<ul class="unstyled address">
						<li><img
							src="<%=request.getContextPath()%>/images/logo/logo2.png" /></li>
					</ul>
				</div>
				<!--End Contact Form-->

				<!--Important Links-->
				<div id="tweets" class="span3">
					<h4>CopyRighter</h4>
					<div>
						<ul class="arrow">
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
							<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> <br>Email:
								wkdvlftlr123@gmail.com</li>
						</ul>
					</div>
				</div>
				<!--Important Links-->

				<!--Archives-->
				<div id="archives" class="span3">
					<h4>Our Company's</h4>
					<div>
						<ul class="arrow">
							<li>construction company's</li>
							<li>heavy equipment company's</li>
						</ul>
					</div>
				</div>
				<!--End Archives-->

				<div class="span3">
					<h4>Building</h4>
					<div class="row-fluid first">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build1.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build2.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build3.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build4.png"
								alt="" /></li>
						</ul>
					</div>
					<div class="row-fluid">
						<ul class="thumbnails">
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build5.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build6.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build7.png"
								alt="" /></li>
							<li class="span3"><img
								src="<%=request.getContextPath()%>/images/building/build8.png"
								alt="" /></li>
						</ul>
					</div>
				</div>
			</div>
			<!--/row-fluid-->
		</div>
		<!--/container-->

	</section>
	<!--/bottom-->
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	<c:url value="/evaluate" var="evaluate"/>
	$("#history_evaluate").on("click",function(){
		location.href="${evaluate}";
	})
</script>
</html>