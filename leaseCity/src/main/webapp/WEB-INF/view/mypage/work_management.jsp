<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>작업 관리 | LEASE CITY</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="selection">
		<div class="selection_main">
			<c:choose>
				<c:when test="${compare == 'CC'}">
					<h3>-임대요청-</h3>
					<table class="selection_cc" style="text-align:center;">
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
							<th><a href="${selection_2 }">대한건설 2011.12.10~신청(10)</a></th>
							<th>2016.10.20</th>
						</tr>
						<tr>
							<td colspan="5" class="boardLine"></td>
						</tr>
						<tr>
							<th><a href="${selection_2 }">대한건설 2011.12.10~신청(10)</a></th>
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
						<fmt:parseNumber value="${prevPage+11}" var="nextPage">
						</fmt:parseNumber>
						<c:choose>
							<c:when test="${prevPage > 0}">
								<a	href="#"><i class="icon-arrow-left">이전</i></a>
							</c:when>
							<c:otherwise>
								<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
							</c:otherwise>
						</c:choose>

						<c:if test="${!empty page.totalPage}">
							<c:choose>
								<c:when test="${(nextPage-1) >= page.totalPage }">
									<c:forEach var="i" begin="${prevPage+1}"
										end="${page.totalPage}">
										<c:choose>
											<c:when test="${i eq page.currentPage}">
												<b><c:out value="${i}"></c:out></b>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${!empty page.keyword and !empty page.order}">
														<a
															href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&order=${page.order}&currentPage=${i}">
															<c:out value="${i}"></c:out>
														</a>
													</c:when>
													<c:when test="${!empty page.order}">
														<a
															href="<%=request.getContextPath()%>/board?order=${page.order}&currentPage=${i}">
															<c:out value="${i}"></c:out>
														</a>
													</c:when>
													<c:when test="${!empty page.keyword}">
														<a
															href="<%=request.getContextPath()%>/board?search=${page.search}&keyword=${page.keyword}&currentPage=${i}">
															<c:out value="${i}"></c:out>
														</a>
													</c:when>
													<c:otherwise>
														<a
															href="<%=request.getContextPath()%>/board?currentPage=${i}">
															<c:out value="${i}"></c:out>
														</a>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="i" begin="${prevPage+1}" end="${nextPage-1}">
										<c:choose>
											<c:when test="${i eq page.currentPage}">
												<b><c:out value="${i}"></c:out></b>
											</c:when>
											<c:otherwise>
												<a href="#">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</c:if>

						<c:choose>
							<c:when test="${nextPage <= page.totalPage}">
								<a href="${nextPage}">다음<i class="icon-arrow-right"></i></a>
							</c:when>
							<c:otherwise>
								<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
				<c:when test="${compare == 'HEC' }">
					<fieldset>
						<legend>임대양도</legend>
						<table class="selection_hec" style="text-align:center;">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>양도 번호</td>
								<td>비용</td>
								<td>시작,종료날짜</td>
								<td>상대 업체명</td>
								<td>비고</td>
							</tr>
							
							<c:forEach var="leaseTransfer" items="${leaseTransfers}">
							<fmt:formatDate value="${leaseTransfer.fromDate}" pattern="yyyy-MM-dd" var="fromDate"></fmt:formatDate>
							<fmt:formatDate value="${leaseTransfer.toDate}" pattern="yyyy-MM-dd" var="toDate"></fmt:formatDate>
							<tr>
								<td colspan="5" class="boardLine"></td>
							</tr>
							<tr>
								<td>${leaseTransfer.leaseTransferNo}</td>
								<td>${leaseTransfer.price}</td>
								<td>${fromDate} ~ ${toDate}</td>
								<td>${leaseTransfer.sendCompanyName}</td>
								<td>
									<input type="hidden" value="${leaseTransfer.leaseTransferNo}"/>
										<button id="lease_transfer_check" class="label">내용 확인</button>
								</td>
							</tr>
							</c:forEach>
							
							<c:if test="${!empty ErrorTransferMsg}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="5"><b>${ErrorTransferMsg}</b></td>
								</tr>
							</c:if>
							
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
						</table>
						<!--페이지시작  -->
						<div class="boardPage" style="display: inline-block;">

							<!-- 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((leaseTransferPage.currentPage-1)/10)-(((leaseTransferPage.currentPage-1)/10)%1))*10}"
								var="transferPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${transferPrevPage+11}" var="transferNextPage">
							</fmt:parseNumber>


							<c:choose>
								<c:when test="${transferPrevPage > 0}">
									<a href="#"> <i class="icon-arrow-left">이전</i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty leaseTransferPage.totalPage}">
								<c:choose>
									<c:when test="${(transferNextPage-1) >= leaseTransferPage.totalPage }">
										<c:forEach var="i" begin="${transferPrevPage+1}"
											end="${leaseTransferPage.totalPage}">
											<c:choose>
												<c:when test="${i eq leaseTransferPage.currentPage}">
													<b><c:out value="${i}"></c:out></b>
												</c:when>
												<c:otherwise>
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${transferPrevPage+1}" end="${transferNextPage-1}">
											<c:choose>
												<c:when test="${i eq leaseTransferPage.currentPage}">
													<b><c:out value="${i}"></c:out></b>
												</c:when>
												<c:otherwise>
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${transferNextPage <= leaseTransferPage.totalPage}">
									<a href="#">다음<i class="icon-arrow-right"></i>	</a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
						<!--페이지끝  -->
					</fieldset>
					<br>
					<fieldset>
						<legend>임대 직접 요청</legend>
						<table class="selection_hec" style="text-align:center;">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>요청 번호</td>
								<td>비용</td>
								<td>요청 차량번호</td>
								<td>상대 업체명</td>
								<td>비고</td>
							</tr>
							
							<c:forEach var="leaseDirectCall" items="${leaseDirectCalls}">
								
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr>
									<td>${leaseDirectCall.leaseCallNo}</td>
									<td>${leaseDirectCall.fromPrice} ~ ${leaseDirectCall.toPrice} (만원)</td>
									<td>${leaseDirectCall.callIdNumber}</td>
									<td>${leaseDirectCall.companyName}</td>
									<td>
										<input type="hidden" value="${leaseDirectCall.leaseDirectNo}"/>
										<button id="lease_direct_call_check" class="label">내용 확인</button>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty ErrorDirectCallMsg}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="5"><b>${ErrorDirectCallMsg}</b></td>
								</tr>
							</c:if>
							
						</table>
						<!--페이지시작-->
						<div class="boardPage" style="display: inline-block;">

							<!-- 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((leaseDirectCallPage.currentPage-1)/10)-(((leaseDirectCallPage.currentPage-1)/10)%1))*10}"
								var="leaseDirectCallPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${leaseDirectCallPrevPage+11}" var="leaseDirectCallNextPage">
							</fmt:parseNumber>

							<c:choose>
								<c:when test="${leaseDirectCallPrevPage > 0}">
									<a href="${leaseDirectCallPrevPage}"><i class="icon-arrow-left">이전</i>	</a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty leaseDirectCallPage.totalPage}">
								<c:choose>
									<c:when test="${(leaseDirectCallNextPage-1) >= leaseDirectCallPage.totalPage }">
										<c:forEach var="i" begin="${leaseDirectCallPrevPage+1}"
											end="${leaseDirectCallPage.totalPage}">
											<c:choose>
												<c:when test="${i eq leaseDirectCallPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${leaseDirectCallPrevPage+1}" end="${leaseDirectCallNextPage-1}">
											<c:choose>
												<c:when test="${i eq leaseDirectCallPage.currentPage}">
													<b><c:out value="${i}"></c:out></b>
												</c:when>
												<c:otherwise>
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${leaseDirectCallNextPage <= leaseDirectCallPage.totalPage}">
									<a href="${leaseDirectCallNextPage}">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
						<!-- 페이지끝 -->
					</fieldset>
				</c:when>
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
	<c:url value="/workManagement/leaseDirectCall" var="directCallCheck"></c:url>
	<c:url value="/workManagement/transfer" var="transferCheck"></c:url>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	
	$(document).on("click", "#lease_direct_call_check", function(e){
		var leaseDirectNo = $(this).prev().val();
		var result = window.open("${directCallCheck}?leaseDirectNo=" + leaseDirectNo, "pop","width=570,height=580, top=150, left=200, scrollbars=yes, resizable=no");
	});
	
	$(document).on("click", "#lease_transfer_check", function(e){
		var leaseDirectNo = $(this).prev().val();
		var result = window.open("${transferCheck}?leaseTransferNo=" + leaseDirectNo, "pop","width=570,height=400, top=150, left=200, scrollbars=yes, resizable=no");
	});
	
</script>
</html>