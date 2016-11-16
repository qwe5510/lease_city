<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="leasecity.dto.user.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sform" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>평가 하기 | LEASE CITY</title>
<style>
	.evaluate_title > td{
		font-size: 13px;
	}
</style>

</head>
<body>
	<div class="evaluate">
		<div class="evaluate_menu"></div>
		<div class="evaluate_main">
			<div style="padding: 50px;">
					<% 
						User user = (User)session.getAttribute("loginUser");
						if( user != null && user instanceof HeavyEquipmentCompany) {
					%>
						<table class="evaluate_main_table">
							<tr class="evaluate_title">
								<td><h3>건설업체 평가</h3></td>
								<td>전혀그렇지않다</td>
								<td>그렇지않다</td>
								<td>보통이다</td>
								<td>그렇다</td>
								<td>매우그렇다</td>
							</tr>
							<tr class="table_space">
								<td><span>업무 수당을 제대로 받았습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="1" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="5" /></td>
							</tr>
							<tr class="table_space">
								<td><span>업무 환경이 만족스러웠습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="1" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="5" /></td>
							</tr>
							<tr class="table_space">
								<td><span>업무 도중 부당한 대우를 받은 경험이 있습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="5" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="1" /></td>
							</tr>
							<tr class="table_space">
								<td><span>업무 도중 업체과실로 인한 재해를 당한 경험이 있습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="5" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="1" /></td>
							</tr>
							<tr>
								<td colspan="5">
									<button id="evaluate_confirm">
										<i class="icon-pencil"></i>평가
									</button>
									<button id="evaluate_cancel">
										<i class="icon-remove"></i>취소
									</button>
								</td>
							</tr>
						</table>
					<%} else if ( user != null && user instanceof ConstructionCompany) { %>
						<table class="evaluate_main_table">
							<tr>
								<td><h3>중기업체 평가</h3></td>
								<td>전혀그렇지않다</td>
								<td>가끔그렇지않다</td>
								<td>보통이다</td>
								<td>좋았다</td>
								<td>매우좋았다</td>
							</tr>
							<tr class="table_space">
								<td><span>시간을 엄수하여 업무를 하였습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="1" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check1" value="5" /></td>
							</tr>
							<tr class="table_space">
								<td><span>중장비의 상태가 온전하였습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="5" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check2" value="1" /></td>
							</tr>
							<tr class="table_space">
								<td><span>계약 기간 중,불성실한 작업태도를 보였습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="5" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check3" value="1" /></td>
							</tr>
							<tr class="table_space">
								<td><span>계약 기간 중, 과실로 인한 사고가 있었습니까?</span></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="5" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="4" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="3" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="2" /></td>
								<td class="evaluate_check"><input type="radio"
									name="check4" value="1" /></td>
							</tr>
							<tr>
								<td colspan="5">
									<button id="evaluate_confirm">
										<i class="icon-pencil"></i>평가
									</button>
									<button id="evaluate_cancel">
										<i class="icon-remove"></i>취소
									</button>
								</td>
							</tr>
						</table>
				<% }%>

			</div>
		</div>
	</div>
</body>
<script src="http://code.jquery.com/jquery.js"></script>
<script>
	<c:url value="/addEvaluate" var="addEvaluate"/>
	$("#evaluate_confirm").on("click", function() {
		
		var check1 = document.getElementsByName('check1');
		var check2 = document.getElementsByName('check2');
		var check3 = document.getElementsByName('check3');
		var check4 = document.getElementsByName('check4');
		
		var sumPoint = 0;
		var avgPoint = 0;
		
		for ( var i = 0 ; i < check1.length ; i++) {
			if ( check1[i].checked == true) {
				sumPoint += parseInt(check1[i].value);
			}
		}
		for ( var i = 0 ; i < check2.length ; i++) {
			if ( check1[i].checked == true) {
				sumPoint += parseInt(check2[i].value);
			}
		}
		for ( var i = 0 ; i < check3.length ; i++) {
			if ( check1[i].checked == true) {
				sumPoint += parseInt(check3[i].value);
			}
		}
		for ( var i = 0 ; i < check4.length ; i++) {
			if ( check1[i].checked == true) {
				sumPoint += parseInt(check4[i].value);
			}
		}
		
		avgPoint = sumPoint / 4;
		
		$.ajax({
	        type : 'post',
	        url : "${addEvaluate }",
	        data : {
	        	avgPoint : avgPoint
	        },
	        success : function(res) {
	        	
	        	alert(res);
				
	        },
	        error : function(xhr, status, error) {
	        	alert("존재하지 않는 페이지입니다.");
	        }
		});
		
	});

	<c:url value="/history" var="history"/>
	$("#evaluate_cancel").on("click", function() {
		location.href = "${history}";
	})
</script>
</html>