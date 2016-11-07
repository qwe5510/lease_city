<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="evaluate">
	<div class="evaluate_menu">
	</div>
	<div  class="evaluate_main">
	<div style="padding: 50px;">
	<c:choose>
		<c:when test="${compare eq '건설' }">
			<table class="evaluate_main_table">
		<tr>
			<td><h3>건설중기 평가</h3></td>
			<td>전혀그렇지않다</td>
			<td>가끔그렇지않다</td>
			<td>보통이다</td>
			<td>좋았다</td>
			<td>매우좋았다</td>
		</tr>
		<tr class="table_space">
			<td><span>업무 수당을 제대로 받았습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>업무 환경이 만족스러웠습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>업무 도중 부당한 대우를 받은 경험이 있습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>업무 도중 업체과실로 인한 재해를 당한 경험이 있습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="5"/></td>
		</tr>
		<tr>
			<td colspan="5">
			<button id="evaluate_confirm"><i class="icon-pencil"></i>평가</button>
			<button id="evaluate_cancel"><i class="icon-remove"></i>취소</button>
			</td>
		</tr>
		</table>
		</c:when>
		<c:otherwise>
			<table class="evaluate_main_table">
		<tr>
			<td><h3>건설중기 평가</h3></td>
			<td>전혀그렇지않다</td>
			<td>가끔그렇지않다</td>
			<td>보통이다</td>
			<td>좋았다</td>
			<td>매우좋았다</td>
		</tr>
		<tr class="table_space">
			<td><span>시간을 엄수하여 업무를 하였습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check1" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>중장비의 상태가 온전하였습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check2" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>계약 기간 중,불성실한 작업태도를 보였습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check3" value="5"/></td>
		</tr>
		<tr class="table_space">
			<td><span>계약 기간 중, 과실로 인한 사고가 있었습니까?</span></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="1"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="2"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="3"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="4"/></td>
			<td class="evaluate_check"><input type="radio" name="check4" value="5"/></td>
		</tr>
		<tr>
			<td colspan="5">
			<button id="evaluate_confirm"><i class="icon-pencil"></i>평가</button>
			<button id="evaluate_cancel"><i class="icon-remove"></i>취소</button>
			</td>
		</tr>
		</table>
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
	<c:url value="/myinfo" var="myinfo"/>
	$("#evaluate_confirm").on("click",function(){
		location.href="${myinfo}";
	})
	
	<c:url value="/history" var="history"/>
	$("#evaluate_cancel").on("click",function(){
		location.href="${history}";
	})
</script>
</html>