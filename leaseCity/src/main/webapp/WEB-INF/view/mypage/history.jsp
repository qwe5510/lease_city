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
		<div class="mypage_main" style="text-align: center;">
			<c:choose>
				<c:when test="${isLogin == 'HEC' }">
					<!-- 임대 신청 리스트 -->
					<fieldset>
						<legend>임대 신청 기록</legend>
						<table class="history_table" id="requestWorkLog">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>번호</td>
								<td>임대 요청 번호</td>
								<td>업무기간</td>
								<td>상대업체</td>
								<td>평가하기</td>
							</tr>
							<c:forEach var="workLog" items="${requestLogs}">
							
								<fmt:formatDate value="${workLog.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
								<fmt:formatDate value="${workLog.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
								<fmt:formatDate value="${workLog.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
								
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>${workLog.leaseCallNo}</td>
									<td>${fromDate}~${toDate}(${regDate})</td>
									<td>${workLog.companyName}</td>
									<td>
										<c:choose>
											<c:when test="${workLog.status == 'CANCELED'}">
												<span class="label label-inverse">작업 취소</span>
											</c:when>
											<c:when test="${workLog.status == 'SELECT_SB'}">
												<span class="label label-inverse">선발 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'STAND_BY'}">
												<span class="label label-inverse">작업 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'WORKING'}">
												<span class="label label-inverse">작업 중</span>
											</c:when>
											<c:when test="${workLog.status == 'COMPLETE'}">
												<span class="label label-success">작업 완료</span>
												<span class="label" style="background-color: #cfdae9">
												<a href="#">평가 하기</a></span>
											</c:when>
											<c:when test="${workLog.status == 'EVALUATED'}">
												<span class="label label-success">작업 완료</span>
											</c:when>									
										</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty ErrorRequestMsg}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="5"><span style="font-weight: bold;">${ErrorRequestMsg}</span>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
						</table>
						<div class="boardPage" id="requestPage" style="display: inline-block;">
							<!-- 임대 신청 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((requestPage.currentPage-1)/10)-(((requestPage.currentPage-1)/10)%1))*10}"
								var="requestPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${requestPrevPage+11}" var="requestNextPage">
							</fmt:parseNumber>
							<c:choose>
								<c:when test="${requestPrevPage > 0}">
									<a href="#" id="requestNo"><i class="icon-arrow-left">이전</i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty requestPage.totalPage}">
								<c:choose>
									<c:when test="${(requestNextPage-1) >= requestPage.totalPage }">

										<c:forEach var="i" begin="${requestPrevPage+1}"
											end="${requestPage.totalPage}">
											<c:choose>
												<c:when test="${i eq requestPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="requestNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${requestPrevPage+1}" end="${requestNextPage-1}">
											<c:choose>
												<c:when test="${i eq requestPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="requestNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:choose>
								<c:when test="${requestNextPage <= requestPage.totalPage}">
									<a href="#" id="requestNo">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
					</fieldset>
					<br>

					<!-- 임대 양도 리스트 -->
					<fieldset>
						<legend>임대 양도 기록</legend>
						<table class="history_table" id="transferWorkLog">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>번호</td>
								<td>임대 양도 번호</td>
								<td>업무기간</td>
								<td>상대업체</td>
								<td>평가하기</td>
							</tr>
							<c:forEach var="workLog" items="${transferLogs}">
							
								<fmt:formatDate value="${workLog.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
								<fmt:formatDate value="${workLog.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
								<fmt:formatDate value="${workLog.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
								
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>${workLog.leaseTransferNo}</td>
									<td>${fromDate}~${toDate}(${regDate})</td>
									<td>${workLog.companyName}</td>
									<td>
										<c:choose>
											<c:when test="${workLog.status == 'CANCELED'}">
												<span class="label label-inverse">작업 취소</span>
											</c:when>
											<c:when test="${workLog.status == 'SELECT_SB'}">
												<span class="label label-inverse">선발 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'STAND_BY'}">
												<span class="label label-inverse">작업 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'WORKING'}">
												<span class="label label-inverse">작업 중</span>
											</c:when>
											<c:when test="${workLog.status == 'COMPLETE'}">
												<span class="label label-success">작업 완료</span>
												<span class="label" style="background-color: #cfdae9">
												<a href="#">평가 하기</a></span>
											</c:when>
											<c:when test="${workLog.status == 'EVALUATED'}">
												<span class="label label-success">작업 완료</span>
											</c:when>									
										</c:choose>
									</td>
									
							</c:forEach>
							<c:if test="${!empty ErrorTransferMsg}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="5"><span style="font-weight: bold;">${ErrorTransferMsg}</span>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
						</table>
						<div class="boardPage" id="transferPage" style="display: inline-block;">

							<!-- 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((transferPage.currentPage-1)/10)-(((transferPage.currentPage-1)/10)%1))*10}"
								var="transferPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${transferPrevPage+11}"
								var="transferNextPage">
							</fmt:parseNumber>


							<c:choose>
								<c:when test="${transferPrevPage > 0}">
									<a href="#" id="transferNo"> <i class="icon-arrow-left">이전</i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty transferPage.totalPage}">
								<c:choose>
									<c:when
										test="${(transferNextPage-1) >= transferPage.totalPage }">
										<c:forEach var="i" begin="${transferPrevPage+1}" 
											end="${transferPage.totalPage}">
											<c:choose>
												<c:when test="${i eq transferPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="transferNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${transferPrevPage+1}"
											end="${transferNextPage-1}">
											<c:choose>
												<c:when test="${i eq transferPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="transferNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${transferNextPage <= transferPage.totalPage}">
									<a href="#" id="transferNo">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
					</fieldset>
				</c:when>
				
				<c:when test="${isLogin == 'CC'}">
					<!-- 임대 요청 리스트 -->
					<fieldset>
						<legend>임대 요청 기록</legend>
						<table class="history_table" id="callWorkLog">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>번호</td>
								<td>요청 번호</td>
								<td>업무기간 (등록기간)</td>
								<td>분류</td>
								<td>진행 상황</td>
							</tr>
							<c:forEach var="workLog" items="${callLogs}">
							
								<fmt:formatDate value="${workLog.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
								<fmt:formatDate value="${workLog.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
								<fmt:formatDate value="${workLog.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
							
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>${workLog.leaseCallNo}</td>
									<td>${fromDate}~${toDate}(${regDate})</td>
									<td>
										${workLog.leaseCategory}
										<br>
										${workLog.equipmentCategory}
									</td>
									<td align="center">
									<c:choose>
										<c:when test="${workLog.status == 'CANCELED'}">
												<span class="label label-inverse">작업 취소</span>
											</c:when>
											<c:when test="${workLog.status == 'SELECT_SB'}">
												<span class="label label-inverse">선발 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'STAND_BY'}">
												<span class="label label-inverse">작업 대기</span>
												<span class="label" style="background-color: #cfdae9">
												<a href="#" onclick="window.open('http://localhost:9090/leaseCity/evaluate', 'evaluate', 'top=100px, left=100px, height=270px, width=900px, location=0')">평가 하기</a></span>
											</c:when>
											<c:when test="${workLog.status == 'WORKING'}">
												<span class="label label-inverse">작업 중</span>
											</c:when>
											<c:when test="${workLog.status == 'COMPLETE'}">
												<span class="label label-success">작업 완료</span>
												<span class="label" style="background-color: #cfdae9">
												<a href="#">평가 하기</a></span>
											</c:when>
											<c:when test="${workLog.status == 'EVALUATED'}">
												<span class="label label-success">작업 완료</span>
										</c:when>									
									</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty ErrorRequestMsg}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="5"><span style="font-weight: bold;">${ErrorRequestMsg}</span>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
						</table>
						<div class="boardPage" id="callPage" style="display: inline-block;">

							<!-- 임대 신청 이전 페이지, 다음 페이지 변수 선언 -->				
							<fmt:parseNumber
								value="${(((callPage.currentPage-1)/10)-(((callPage.currentPage-1)/10)%1))*10}"
								var="callPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${callPrevPage+11}" var="callNextPage">
							</fmt:parseNumber>							

							<c:choose>
								<c:when test="${callPrevPage > 0}">
									<a href="${callPrevPage}" id="callNo"><i class="icon-arrow-left">이전</i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty callPage.totalPage}">
								<c:choose>
									<c:when test="${(callNextPage-1) >= callPage.totalPage }">

										<c:forEach var="i" begin="${callPrevPage+1}"
											end="${callPage.totalPage}">
											<c:choose>
												<c:when test="${i eq callPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="<%=request.getContextPath()%>/history?currentPage=${i}" id="callNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${callPrevPage+1}" end="${callNextPage-1}">
											<c:choose>
												<c:when test="${i eq callPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="<%=request.getContextPath()%>/history?currentPage=${i}" id="callNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:choose>
								<c:when test="${callNextPage <= callPage.totalPage}">
									<a href="${callNextPage}" id="callNo">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
					</fieldset>
					<br>

					<!-- 임대 요청에 대한 양도 리스트 -->
					<fieldset>
						<legend>임대 요청/신청 기록</legend>
						<table class="history_table" id="callRequestWorkLog">
							<tr>
								<td colspan="6" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>번호</td>
								<td>요청 번호</td>
								<td>신청 번호</td>
								<td>업무기간</td>
								<td>상대업체</td>
								<td>진행 상황</td>
							</tr>
							<c:forEach var="workLog" items="${callRequestLogs}">
							
								<fmt:formatDate value="${workLog.fromDate}" pattern="yyyy-MM-dd" var="fromDate"/>
								<fmt:formatDate value="${workLog.toDate}" pattern="yyyy-MM-dd" var="toDate"/>
								<fmt:formatDate value="${workLog.regDate}" pattern="yyyy-MM-dd" var="regDate"/>
								
							
								<tr>
									<td colspan="6" class="boardLine"></td>
								</tr>
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>${workLog.leaseCallNo}</td>
									<td>${workLog.leaseRequestNo}</td>
									<td>${fromDate}~${toDate}(${regDate})</td>
									<td>${workLog.companyName}</td>
									<td>
									<c:choose>
										<c:when test="${workLog.status == 'CANCELED'}">
												<span class="label label-inverse">작업 취소</span>
											</c:when>
											<c:when test="${workLog.status == 'SELECT_SB'}">
												<span class="label label-inverse">선발 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'STAND_BY'}">
												<span class="label label-inverse">작업 대기</span>
											</c:when>
											<c:when test="${workLog.status == 'WORKING'}">
												<span class="label label-inverse">작업 중</span>
											</c:when>
											<c:when test="${workLog.status == 'COMPLETE'}">
												<span class="label label-success">작업 완료</span>
												<span class="label" style="background-color: #cfdae9">
												<a href="#">평가 하기</a></span>
											</c:when>
											<c:when test="${workLog.status == 'EVALUATED'}">
												<span class="label label-success">작업 완료</span>
										</c:when>									
									</c:choose>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${!empty ErrorCallRequestMsg}">
								<tr>
									<td colspan="6" class="boardLine"></td>
								</tr>
								<tr align="center">
									<td colspan="6"><span style="font-weight: bold;">${ErrorCallRequestMsg}</span>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="6" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
						</table>
						<div class="boardPage" id="callRequestPage" style="display: inline-block;">

							<!-- 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((callRequestPage.currentPage-1)/10)-(((callRequestPage.currentPage-1)/10)%1))*10}"
								var="callRequestPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${callRequestPrevPage+11}"
								var="callRequestNextPage">
							</fmt:parseNumber>


							<c:choose>
								<c:when test="${callRequestPrevPage > 0}">
									<a href="#" id="callRequestNo"> <i class="icon-arrow-left">이전</i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;"><i class="icon-arrow-left">처음</i></a>
								</c:otherwise>
							</c:choose>

							<c:if test="${!empty callRequestPage.totalPage}">
								<c:choose>
									<c:when
										test="${(callRequestNextPage-1) >= callRequestPage.totalPage }">
										<c:forEach var="i" begin="${callRequestPrevPage+1}"
											end="${callRequestPage.totalPage}">
											<c:choose>
												<c:when test="${i eq callRequestPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="callRequestNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" begin="${callRequestPrevPage+1}"
											end="${callRequestNextPage-1}">
											<c:choose>
												<c:when test="${i eq callRequestPage.currentPage}">
													<b>${i}</b>
												</c:when>
												<c:otherwise>
													<a href="#" id="callRequestNo">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${callRequestNextPage <= callRequestPage.totalPage}">
									<a href="${callRequestNextPage}" id="callRequestNo">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
					</fieldset>
				</c:when>
			</c:choose>
			<a href="<%=request.getContextPath()%>/myinfo" class="label label-success" style="margin-top: 15px; padding: 10px; float: left">이전으로</a>
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
					<select >
					</select>
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

	<c:url value="/historyCallPageControlAjax" var="historyCallPageControlAjax"/>
	<c:url value="/historyRequestCallCCPageControlAjax" var="historyRequestCallCCPageControlAjax"/>
	<c:url value="/historyRequestCallHECPageControlAjax" var="historyRequestCallHECPageControlAjax"/>
	<c:url value="/historyTransferPageControlAjax" var="historyTransferPageControlAjax"/>
	
	$(document).on("click", "#callNo", function(e){
		e.preventDefault();
		var currentPage = $(this).html().split("<")[0];
		
		if(currentPage == '이전'){
			currentPage = $(this).attr("href");
		}
		
		if(currentPage == '다음'){
			currentPage = $(this).attr("href");
		}
		
		$("#callWorkLog").html('');
		$.ajax({
	        type : 'get',
	        url : "${historyCallPageControlAjax }",
	        data : {
	           currentPage : currentPage
	        },
	        success : function(map) {
	        	str = "";
	        	
	        	var callPage = map.callPage;
	        	var callWorkLogs = map.callWorkLogs;
	        	
	        	str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>";
	        	str += "<tr><td>번호</td><td>요청 번호</td><td>업무기간 (등록기간)</td><td>분류</td><td>진행 상황</td></tr>";
				$.each(callWorkLogs, function(idx, callWorkLog){
					
					var fromDate = new Date(callWorkLog.fromDate).format("yyyy-MM-dd");
					var toDate = new Date(callWorkLog.toDate).format("yyyy-MM-dd");
					var regDate = new Date(callWorkLog.regDate).format("yyyy-MM-dd");
					
					str += "<tr><td colspan='5' class='boardLine'></td></tr>";
					str += "<tr><td>"+callWorkLog.rowNumLogNo+"</td><td>"+callWorkLog.leaseCallNo+"</td>";
					str += "<td>" + fromDate + "~" + toDate + "(" + regDate + ")</td>";
					str += "<td>"+callWorkLog.leaseCategory+"<br>"+callWorkLog.equipmentCategory+"</td><td align='center'>";
					if(callWorkLog.status == 'CANCELED') {
						str += "<span class='label label-inverse'>작업 취소</span>";
					} else if(callWorkLog.status == 'SELECT_SB') {
						str += "<span class='label label-inverse'>선발 대기</span>";
					} else if(callWorkLog.status == 'STAND_BY') {
						str += "<span class='label label-inverse'>작업 대기</span>";
					} else if( callWorkLog.status == 'WORKING') {
						str += "<span class='label label-inverse'>작업 중</span>";
					} else if( callWorkLog.status == 'COMPLETE') {
						str += "<span class='label label-success'>작업 완료</span>";
						str += "<span class='label' style='background-color: #cfdae9'><a href='#' onclick='window.open('http://localhost:9090/leaseCity/evaluate', 'evaluate', 'top=100px, left=100px, height=800px, width=800px')'>평가 하기</a></span>";
					} else if( callWorkLog.status == 'EVALUATED') {
						str += "<span class='label label-inverse'>작업 완료</span></td></tr>";
					}
					
				});
				str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>"
				
				$("#callWorkLog").append(str);
				str = "";
				$("#callPage").html('');
				
				var callPrevPage = parseInt((callPage.currentPage-1)/10) * 10;
				var callNextPage = callPrevPage + 11;
				
				if(callPrevPage > 0) {
					str += "<a href='" + callPrevPage + "' id='callNo' style='margin-left : 15px'><i class='icon-arrow-left'>이전</i></a>";
				} else {
					str += "<a style='color: black;'><i class='icon-arrow-left'>처음</i></a>";
				}
				
				if(callPage.totalPage != null){
					if(callNextPage-1 >= callPage.totalPage) {
						for ( var i = callPrevPage + 1 ; i <= callPage.totalPage ; i++) {
							if ( i == callPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='callNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					} else {
						for ( var i = callPrevPage + 1 ; i <= callNextPage-1 ; i++) {
							if ( i == callPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='callNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					}
				}
				
				if( callNextPage <= callPage.totalPage ) {
					str += "<a href='" + callNextPage + "' id='callNo' style='margin-left : 15px'>다음<i class='icon-arrow-right'></i></a>";
				} else {
					str += "<a style='color: black;'>끝<i class='icon-arrow-right'></i></a>";
				}
				
				$("#callPage").append(str);
				
	        },
	        error : function(xhr, status, error) {
	        	alert("존재하지 않는 페이지입니다.");
	        }
		});
	});
	
	$(document).on("click", "#callRequestNo", function(e){
		e.preventDefault();
		var currentPage = $(this).html().split("<")[0];
		
		if(currentPage == '이전'){
			currentPage = $(this).attr("href");
		}
		
		if(currentPage == '다음'){
			currentPage = $(this).attr("href");
		}
		
		$("#callRequestWorkLog").html('');
		$.ajax({
	        type : 'get',
	        url : "${historyRequestCallCCPageControlAjax }",
	        data : {
	           currentPage : currentPage
	        },
	        success : function(map) {
	        	str = "";
	        	
	        	var callRequestPage = map.callRequestPage;
	        	var callRequestWorkLogs = map.callRequestWorkLogs;
	        	
	        	str += "<tr><td colspan='6' class='boardLine' style='height: 4px !important;'></td></tr>";
	        	str += "<tr><td>번호</td><td>요청 번호</td><td>신청 번호</td><td>업무기간</td><td>상대업체</td><td>진행 상황</td></tr>";
				
	        	$.each(callRequestWorkLogs, function(idx, callRequestWorkLog){
					
					var fromDate = new Date(callRequestWorkLog.fromDate).format("yyyy-MM-dd");
					var toDate = new Date(callRequestWorkLog.toDate).format("yyyy-MM-dd");
					var regDate = new Date(callRequestWorkLog.regDate).format("yyyy-MM-dd");
					
					str += "<tr><td colspan='6' class='boardLine'></td></tr>";
					str += "<tr><td>"+callRequestWorkLog.rowNumLogNo+"</td><td>"+callRequestWorkLog.leaseCallNo+"</td>";
					str += "<td>"+callRequestWorkLog.leaseRequestNo+"</td><td>" + fromDate + "~" + toDate + "(" + regDate + ")</td>";
					str += "<td>"+callRequestWorkLog.companyName+"</td><td>";
					
					if(callRequestWorkLog.status == 'CANCELED') {
						str += "<span class='label label-inverse'>작업 취소</span>";
					} else if(callRequestWorkLog.status == 'SELECT_SB') {
						str += "<span class='label label-inverse'>선발 대기</span>";
					} else if(callRequestWorkLog.status == 'STAND_BY') {
						str += "<span class='label label-inverse'>작업 대기</span>";
					} else if( callRequestWorkLog.status == 'WORKING') {
						str += "<span class='label label-inverse'>작업 중</span>";
					} else if( callRequestWorkLog.status == 'COMPLETE') {
						str += "<span class='label label-success'>작업 완료</span>";
						str += "<span class='label' style='background-color: #cfdae9'><a href='#' onclick='window.open('http://localhost:9090/leaseCity/evaluate', 'evaluate', 'top=100px, left=100px, height=800px, width=800px')'>평가 하기</a></span>";
					} else if( callRequestWorkLog.status == 'EVALUATED') {
						str += "<span class='label label-inverse'>작업 완료</span></td></tr>";
					}
					
				});
				str += "<tr><td colspan='6' class='boardLine' style='height: 4px !important;'></td></tr>"
				
				$("#callRequestWorkLog").append(str);
				str = "";
				$("#callRequestPage").html('');
				
				var callRequestPrevPage = parseInt((callRequestPage.currentPage-1)/10) * 10;
				var callRequestNextPage = callRequestPrevPage + 11;
				callRequestPage
				if(callRequestPrevPage > 0) {
					str += "<a href='" + callRequestPrevPage + "' id='callRequestNo' style='margin-left : 15px'><i class='icon-arrow-left'>이전</i></a>";
				} else {
					str += "<a style='color: black;'><i class='icon-arrow-left'>처음</i></a>";
				}
				
				if(callRequestPage.totalPage != null){
					if(callRequestNextPage-1 >= callRequestPage.totalPage) {
						for ( var i = callRequestPrevPage + 1 ; i <= callRequestPage.totalPage ; i++) {
							if ( i == callRequestPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='callRequestNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					} else {
						for ( var i = callRequestPrevPage + 1 ; i <= callRequestNextPage-1 ; i++) {
							if ( i == callRequestPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='callRequestNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					}
				}
				
				if( callRequestNextPage <= callRequestPage.totalPage ) {
					str += "<a href='" + callRequestNextPage + "' id='callRequestNo' style='margin-left : 15px'>다음<i class='icon-arrow-right'></i></a>";
				} else {
					str += "<a style='color: black;'>끝<i class='icon-arrow-right'></i></a>";
				}
				
				$("#callRequestPage").append(str);
				
	        },
	        error : function(xhr, status, error) {
	        	alert("존재하지 않는 페이지입니다.");
	        }
		});
	});
	
	$(document).on("click", "#requestNo", function(e){
		e.preventDefault();
		var currentPage = $(this).html().split("<")[0];
		
		if(currentPage == '이전'){
			currentPage = $(this).attr("href");
		}
		
		if(currentPage == '다음'){
			currentPage = $(this).attr("href");
		}
		
		$("#requestWorkLog").html('');
		$.ajax({
	        type : 'get',
	        url : "${historyRequestCallHECPageControlAjax }",
	        data : {
	           currentPage : currentPage
	        },
	        success : function(map) {
	        	str = "";
	        	
	        	var requestPage = map.requestPage;
	        	var requestWorkLogs = map.requestWorkLogs;
	        	
	        	str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>";
	        	str += "<tr><td>번호</td><td>임대 요청 번호</td><td>업무기간</td><td>상대업체</td><td>평가하기</td></tr>";
				
	        	$.each(requestWorkLogs, function(idx, requestWorkLog){
					
					var fromDate = new Date(requestWorkLog.fromDate).format("yyyy-MM-dd");
					var toDate = new Date(requestWorkLog.toDate).format("yyyy-MM-dd");
					var regDate = new Date(requestWorkLog.regDate).format("yyyy-MM-dd");
					
					str += "<tr><td colspan='5' class='boardLine'></td></tr>";
					str += "<tr><td>"+requestWorkLog.rowNumLogNo+"</td><td>"+requestWorkLog.leaseCallNo+"</td>";
					str += "<td>" + fromDate + "~" + toDate + "(" + regDate + ")</td>";
					str += "<td>"+requestWorkLog.companyName+"</td><td>";
					
					console.log(requestWorkLog.status);
					
					if(requestWorkLog.status == 'CANCELED') {
						str += "<span class='label label-inverse'>작업 취소</span>";
					} else if(requestWorkLog.status == 'SELECT_SB') {
						str += "<span class='label label-inverse'>선발 대기</span>";
					} else if(requestWorkLog.status == 'STAND_BY') {
						str += "<span class='label label-inverse'>작업 대기</span>";
					} else if( requestWorkLog.status == 'WORKING') {
						str += "<span class='label label-inverse'>작업 중</span>";
					} else if( requestWorkLog.status == 'COMPLETE') {
						str += "<span class='label label-success'>작업 완료</span>";
						str += "<span class='label' style='background-color: #cfdae9'><a href='#' onclick='window.open('http://localhost:9090/leaseCity/evaluate', 'evaluate', 'top=100px, left=100px, height=800px, width=800px')'>평가 하기</a></span>";
					} else if( requestWorkLog.status == 'EVALUATED') {
						str += "<span class='label label-inverse'>작업 완료</span></td></tr>";
					}
					
				});
				str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>"
				
				$("#requestWorkLog").append(str);
				str = "";
				$("#requestPage").html('');
				
				var requestPrevPage = parseInt((requestPage.currentPage-1)/10) * 10;
				var requestNextPage = requestPrevPage + 11;
				if(requestPrevPage > 0) {
					str += "<a href='" + requestPrevPage + "' id='requestNo' style='margin-left : 15px'><i class='icon-arrow-left'>이전</i></a>";
				} else {
					str += "<a style='color: black;'><i class='icon-arrow-left'>처음</i></a>";
				}
				
				if(requestPage.totalPage != null){
					if(requestNextPage-1 >= requestPage.totalPage) {
						for ( var i = requestPrevPage + 1 ; i <= requestPage.totalPage ; i++) {
							if ( i == requestPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='requestNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					} else {
						for ( var i = requestPrevPage + 1 ; i <= requestNextPage-1 ; i++) {
							if ( i == requestPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='requestNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					}
				}
				
				if( requestNextPage <= requestPage.totalPage ) {
					str += "<a href='" + requestNextPage + "' id='requestNo' style='margin-left : 15px'>다음<i class='icon-arrow-right'></i></a>";
				} else {
					str += "<a style='color: black;'>끝<i class='icon-arrow-right'></i></a>";
				}
				
				$("#requestPage").append(str);
				
	        },
	        error : function(xhr, status, error) {
	        	alert("존재하지 않는 페이지입니다.");
	        }
		});
	});
	
	$(document).on("click", "#transferNo", function(e){
		e.preventDefault();
		var currentPage = $(this).html().split("<")[0];
		
		if(currentPage == '이전'){
			currentPage = $(this).attr("href");
		}
		
		if(currentPage == '다음'){
			currentPage = $(this).attr("href");
		}
		
		$("#transferWorkLog").html('');
		$.ajax({
	        type : 'get',
	        url : "${historyTransferPageControlAjax }",
	        data : {
	           currentPage : currentPage
	        },
	        success : function(map) {
	        	str = "";
	        	
	        	var transferPage = map.transferPage;
	        	var transferWorkLogs = map.transferWorkLogs;
	        	
	        	str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>";
	        	str += "<tr><td>번호</td><td>임대 요청 번호</td><td>업무기간</td><td>상대업체</td><td>평가하기</td></tr>";
				
	        	$.each(transferWorkLogs, function(idx, transferWorkLog){
					
					var fromDate = new Date(transferWorkLog.fromDate).format("yyyy-MM-dd");
					var toDate = new Date(transferWorkLog.toDate).format("yyyy-MM-dd");
					var regDate = new Date(transferWorkLog.regDate).format("yyyy-MM-dd");
					
					str += "<tr><td colspan='5' class='boardLine'></td></tr>";
					str += "<tr><td>"+transferWorkLog.rowNumLogNo+"</td><td>"+transferWorkLog.leaseCallNo+"</td>";
					str += "<td>" + fromDate + "~" + toDate + "(" + regDate + ")</td>";
					str += "<td>"+transferWorkLog.companyName+"</td><td>";
					
					if(transferWorkLog.status == 'CANCELED') {
						str += "<span class='label label-inverse'>작업 취소</span>";
					} else if(transferWorkLog.status == 'SELECT_SB') {
						str += "<span class='label label-inverse'>선발 대기</span>";
					} else if(transferWorkLog.status == 'STAND_BY') {
						str += "<span class='label label-inverse'>작업 대기</span>";
					} else if( transferWorkLog.status == 'WORKING') {
						str += "<span class='label label-inverse'>작업 중</span>";
					} else if( transferWorkLog.status == 'COMPLETE') {
						str += "<span class='label label-success'>작업 완료</span>";
						str += "<span class='label' style='background-color: #cfdae9'><a href='#' onclick='window.open('http://localhost:9090/leaseCity/evaluate', 'evaluate', 'top=100px, left=100px, height=800px, width=800px')'>평가 하기</a></span>";
					} else if( transferWorkLog.status == 'EVALUATED') {
						str += "<span class='label label-inverse'>작업 완료</span></td></tr>";
					}
					
				});
				str += "<tr><td colspan='5' class='boardLine' style='height: 4px !important;'></td></tr>"
				
				$("#transferWorkLog").append(str);
				str = "";
				$("#transferPage").html('');
				
				var transferPrevPage = parseInt((transferPage.currentPage-1)/10) * 10;
				var transferNextPage = transferPrevPage + 11;
				if(transferPrevPage > 0) {
					str += "<a href='" + transferPrevPage + "' id='transferNo' style='margin-left : 15px'><i class='icon-arrow-left'>이전</i></a>";
				} else {
					str += "<a style='color: black;'><i class='icon-arrow-left'>처음</i></a>";
				}
				
				if(transferPage.totalPage != null){
					if(transferNextPage-1 >= transferPage.totalPage) {
						for ( var i = transferPrevPage + 1 ; i <= transferPage.totalPage ; i++) {
							if ( i == transferPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='transferNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					} else {
						for ( var i = transferPrevPage + 1 ; i <= transferNextPage-1 ; i++) {
							if ( i == transferPage.currentPage) {
								str += "<b style='margin-left : 15px'>" + i + "</b>";
							} else {
								str += "<a href='#' id='transferNo' style='margin-left : 15px'>" + i + "</a>";
							}
						}
					}
				}
				
				if( transferNextPage <= transferPage.totalPage ) {
					str += "<a href='" + transferNextPage + "' id='transferNo' style='margin-left : 15px'>다음<i class='icon-arrow-right'></i></a>";
				} else {
					str += "<a style='color: black;'>끝<i class='icon-arrow-right'></i></a>";
				}
				
				$("#transferPage").append(str);
				
	        },
	        error : function(xhr, status, error) {
	        	alert("존재하지 않는 페이지입니다.");
	        }
		});
	});
	
</script>
</html>