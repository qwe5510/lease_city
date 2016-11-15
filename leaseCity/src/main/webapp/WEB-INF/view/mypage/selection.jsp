<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="selection">
	<div class="selection_main">
	<c:url value="/selection_2" var="selection_2"></c:url>
		<c:choose>
			<c:when test="${compare eq '건설'}">
				<h3>-임대요청-</h3>
				<table class="selection_cc">
					<tr>
						<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					<tr>
						<th>제목</th>
						<th>신청일</th>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<th>
							<a href="${selection_2 }">대한건설 2011.12.10~신청(10)</a>
						</th>
						<th>2016.10.20</th>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<th>
							<a href="${selection_2 }">대한건설 2011.12.10~신청(10)</a>
						</th>
						<th>2016.10.30</th>
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
			</c:when>
			<c:otherwise>
				<fieldset>
					<legend>임대양도</legend>
					<table class="selection_hec">
					<tr>
						<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					<tr>
						<td class="selection_classify">구분</td>
						<td class="selection_title">제목</td>
						<td class="selection_status">상태</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<td>양도</td>
						<td>ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ</td>
						<td>
						<button>수락</button>
						<button>거절</button>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<td>양도</td>
						<td>ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ</td>
						<td>
						<button>수락</button>
						<button>거절</button>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
					</tr>
			</table>
			<!--페이지시작  -->
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
         <!--페이지끝  -->
				</fieldset>
				<fieldset>
					<legend>임대신청</legend>
					<table class="selection_hec">
					<tr>
						<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					<tr>
						<td class="selection_classify">구분</td>
						<td class="selection_title">제목</td>
						<td class="selection_status">상태</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<td>임대신청</td>
						<td>ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ</td>
						<td>대기</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine"></td>
					</tr>
					<tr>
						<td>임대신청</td>
						<td>ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇ</td>
						<td>대기</td>
					</tr>
					<tr>
						<td colspan="5" class="boardLine" style="height: 4px !important;"></td>
					</tr>
					</table>
					<!--페이지시작-->
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
         <!-- 페이지끝 -->
				</fieldset>
			</c:otherwise>
		</c:choose>
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
</html>