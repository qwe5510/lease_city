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
						<table class="history_table" id="request_log">
							<tr>
								<td colspan="5" class="boardLine"
									style="height: 4px !important;"></td>
							</tr>
							<tr>
								<td>번호</td>
								<td>임대 신청 번호</td>
								<td>업무기간</td>
								<td>상대업체</td>
								<td>평가하기</td>
							</tr>
							<c:forEach var="workLog" items="${requestLogs}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>20051</td>
									<td>2016.05.06~2016.10.30 (2016.04.30)</td>
									<td>건설업체</td>
									<td>진행중</td>
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
						<div class="boardPage" style="display: inline-block;">
							<!-- 임대 신청 이전 페이지, 다음 페이지 변수 선언 -->
							<fmt:parseNumber
								value="${(((requestPage.currentPage-1)/10)-(((requestPage.currentPage-1)/10)%1))*10}"
								var="requestPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${requestPrevPage+11}" var="requestNextPage">
							</fmt:parseNumber>
							<c:choose>
								<c:when test="${requestPrevPage > 0}">
									<a href="#"><i class="icon-arrow-left">이전</i></a>
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
													<a href="#">${i}</a>
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
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:choose>
								<c:when test="${requestNextPage <= requestPage.totalPage}">
									<a href="#" >다음<i class="icon-arrow-right"></i></a>
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
						<table class="history_table">
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
							<c:forEach var="workLog" items="${workLogs}">
								<tr>
									<td colspan="5" class="boardLine"></td>
								</tr>
								<tr>
									<td>${workLog.rowNumLogNo}</td>
									<td>20051</td>
									<td>2016.05.06~2016.10.30 (2016.04.30)</td>
									<td>건설업체</td>
									<td>진행중</td>
								</tr>
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
						<div class="boardPage" style="display: inline-block;">

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
									<a href="#"> <i class="icon-arrow-left">이전</i></a>
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
													<a href="#">${i}</a>
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
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${transferNextPage <= transferPage.totalPage}">
									<a href="#">다음<i class="icon-arrow-right"></i></a>
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
						<div class="boardPage" style="display: inline-block;">

							<!-- 임대 신청 이전 페이지, 다음 페이지 변수 선언 -->
							
							<!-- var prevPage = parseInt( (currentPage-1) /10 * 10)
							var nextPage = prevPage + 11 -->
							
							<fmt:parseNumber
								value="${(((callPage.currentPage-1)/10)-(((callPage.currentPage-1)/10)%1))*10}"
								var="callPrevPage">
							</fmt:parseNumber>
							<fmt:parseNumber value="${callPrevPage+11}" var="callNextPage">
							</fmt:parseNumber>							

							<c:choose>
								<c:when test="${callPrevPage > 0}">
									<a href="${callPrevPage}"><i class="icon-arrow-left">이전</i></a>
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
													<a href="#">${i}</a>
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
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>
							<c:choose>
								<c:when test="${callNextPage <= callPage.totalPage}">
									<a href="${callNextPage}">다음<i class="icon-arrow-right"></i></a>
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
						<table class="history_table">
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
						<div class="boardPage" style="display: inline-block;">

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
									<a href="#"> <i class="icon-arrow-left">이전</i></a>
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
													<a href="#">${i}</a>
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
													<a href="#">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</c:if>

							<c:choose>
								<c:when test="${callRequestNextPage <= callRequestPage.totalPage}">
									<a href="#{callRequestNextPage}">다음<i class="icon-arrow-right"></i></a>
								</c:when>
								<c:otherwise>
									<a style="color: black;">끝<i class="icon-arrow-right"></i></a>
								</c:otherwise>
							</c:choose>
						</div>
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

	
	/* <c:url value="" var=""></c:url>
	$(document).on("click", "#ID값", function(){
		var dd = $(this).html() -> 이전, 다음
		
		if(dd == '이전'){
			var currentPage = $(this).attr("href");
		}
		
		$.ajax(){
			url: ${},
			method: "GET",
			data: {currentPage : currentPage}, 
			success : function(map){
				var callPage = map.callPage;
				var callWorkLogs = map.callWorkLogs;
				
				str ="";
				$.each($(callWorkLogs), function(idx, item){
					
					var fromDate = new Date(callWorkLogs.fromDate).format("yyyy-MM-dd");
					var toDate =  
					
					str+=
				})
				$("#callWorkLog").append(str);
				
				
				
				
				
				
				
				
			},
			error : function(xhr, status, error){
				alert("존재하지 않는 페이지입니다.");
			}
		}
	}) */
	
	
	
</script>
</html>