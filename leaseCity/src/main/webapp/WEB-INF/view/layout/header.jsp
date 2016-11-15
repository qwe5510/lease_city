<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/main.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/css/sl-slide.css">


<script
	src="<%=request.getContextPath() %>/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>

<!-- Le fav and touch icons -->
<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x7"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-57-precomposed.png">
</head>
<body>
	<!--Header-->
	<header class="navbar navbar-fixed-top">
		<div class="notification" style="display: none;">
			<div id="notification_li">
				<span id="notification_count"></span> 
				<a href="#" id="notificationLink" class="label label-notify">새 알림</a>
				<div id="notificationContainer">
					<div id="notificationTitle">알림</div>
					<div id="notificationsBody" class="notifications">
						<ul class="notificationContent"></ul>
					</div>
					<div id="notificationFooter">
						<a href="#" onclick="deleteAllNotify()"id="notificationFooterButton">모두 삭제</a>
					</div>
				</div>
			</div>
		</div>
		<div class="navbar-inner">
				<a id="logo" class="pull-left" href="<%=request.getContextPath()%>/index"></a>
				<div class="navi_main">
					<ul class="nav">
						<li>
							<table>
								<tr>
									<th>
										<c:url value="/totalSearch" var="totalSearch"></c:url>
										<form method="get" action="${totalSearch }">
										<select name="serviceKind">
												<option value="LEASE">임대</option>
												<option value="COMMUNITY">커뮤니티</option>
												<option value="Q_AND_A">Q&#38;A</option>
												<option value="HE_SELECT">중기업체</option>
										</select>
										<input id="totalKeyword" name="keyword" type="text" placeholder="검색어를 입력해주세요.">
										<input id="totalBtn" type="submit" value="검색">
										</form>
									</th>
									
								</tr>
							</table>
						</li>
						<li class="dropdown" id="con"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown">임대 <i
								class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath() %>/leaseCall">임대 신청/조회</a></li>
								<li><a href="<%=request.getContextPath() %>/lookupHeavy">중기업체 조회</a></li>
							</ul></li>
						<li id="con"><a href="<%=request.getContextPath() %>/board">커뮤니티</a></li>
						<li class="dropdown" id="con"><a href="<%=request.getContextPath() %>/help/FAQ"
							class="dropdown-toggle" data-toggle="dropdown">고객센터 <i
								class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath() %>/help/FAQ">자주 묻는 질문</a></li>
								<li><a href="<%=request.getContextPath() %>/help/qna">Q&#38;A</a></li>
							</ul></li>
						<li id="con"><a href="<%=request.getContextPath() %>/introduction">소개</a></li>
						<c:url value="/login" var="login"></c:url>
						<c:url value="/logout" var="logout"></c:url>
						<c:url value="/mypage" var="mypage"></c:url>
						<%-- <c:url value="/mypage" var="mypage"></c:url> --%>
						<c:choose>
							<c:when test="${!empty loginUser or !empty admin}">
								<li id="con"><a href=${logout } title="로그아웃"><i class="icon-signout label label-logout"> Logout</i></a></li>
								<li id="con"><a href=${mypage } title="마이페이지" style="padding-left: 0px;"><i class="icon-info-sign label label-my-page"> My Page</i></a></li>
							</c:when>
							<c:otherwise>
								<li id="con"><a href="${login}"><i class="icon-lock label label-login" title="로그인"> Login</i></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
	</header>
	<!-- /header -->
</body>
<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

$("#totalBtn").on("click",function(e){
	var keyword = $("#totalKeyword").val();
	var searchRegExp = /^[ㄱ-ㅎ가-힣0-9a-zA-Z!@#$^&*)(_=+-/*]{2,}$/;
	if(!searchRegExp.test(keyword)){
		alert("조건이 알맞지 않습니다.\n(%를 제외한 2글자 이상 문자.)");
		return false;
	}
}) 

	// (반복문 초기 실행)
	window.onload = function() {
		repeatloop(); // 반복문 첫 실행
		// (로그인 확인 후) HeaderNotification 실행 
		if ("${sessionScope.loginUser.userId}" != "") {
			headerNotification("${sessionScope.loginUser.userId}");
		} else if("${sessionScope.admin.userId}" != "") {
			headerNotification("${sessionScope.admin.userId}");
		} 
	}
	// 반복 함수
	function repeatloop() {
		setTimeout("repeatloop()", 1000 * 60); //refresh 빈도 1000 = 1초
		// (로그인 확인 후) footNotification 실행 

		if ("${sessionScope.loginUser.userId}" != "") {
			footNotification("${sessionScope.loginUser.userId}");
		} else if("${sessionScope.admin.userId}" != "") {
			footNotification("${sessionScope.admin.userId}");
		}
	}

	// 중요 알람 1 : footNotificatino 계속 확인 후, 실행
	<c:url value="/confirmNotify" var="confirmNotify"/>
	function footNotification(userId) {

		$.ajax({
			type : 'post',
			url : "${confirmNotify }",
			data : {
				userId : userId
			},
			success : function(res) {
				
				var notify = ""; // (test용 변수)
				var title = userId + " 님"; // notification의 title
				var iconDataURI = "http://vehicle-free.com/highresolution/l_023.jpg";
				
				// 1. notification 에 보여줄 정보
				// ( notify가 있다면 && notify가 1개 이상 있으면 표시 )
				if (res != "" && res.length > 0) {
					
					// 알림 시, 바로 HeaderNotify 생성
					if ("${sessionScope.loginUser.userId}" != "") {
						//alert("로그인 아이디 : " + "${sessionScope.loginUser.userId}");
						headerNotification("${sessionScope.loginUser.userId}");
					} else if("${sessionScope.admin.userId}" != "") {
						headerNotification("${sessionScope.admin.userId}");
					}
					
					var options = {
						body : res.length + "개의 새 알림이 있습니다.",
						icon : iconDataURI
					}
					
					// 데이스탑 알림 요청 및 notifyCheck = 'Y'로 업뎃하기 (foot 2번 실행x) 
					var notification = new Notification(title, options);
					$(res).each(function(idx, data) {
						updateNotify(data);
					});
					
					// 알림 클릭 시, 링크이동 및 삭제
					notification.onclick = function () {
						window.open(res[res.length-1].notifyLink, "_self");
						deleteNotify(res[res.length-1].notifyNo);
						notification.close();
					};
					
					// (내용 클릭시, notify 닫기)
					$(".notificationContent").click(function() {
						notification.close();
					});
					// (모두 삭제 클릭시, notify 닫기)
					$("#notificationFooterButton").click(function(e) {
						e.preventDefault();
						notification.close();
					});
					
					$(document).click(function() {
						notification.close();
					});
					// (5초뒤 얼람 메시지 닫기)
					setTimeout(function() {
						notification.close();
					}, 5000);
					
					} else {
						//alert("notify 없음");
					}

			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});
	}
	
	// (단위 기능 1 : 알림 삭제)
	<c:url value="/deleteNotify" var="deleteNotify"/>
		function deleteNotify(notifyNo) {
			$.ajax({
				type : 'post',
				url : "${deleteNotify }",
				data : {
					notifyNo : notifyNo
				},
				success : function(res) {},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
		}
		
		// (단위 기능 2 : 알림 더이상 울리지 않게 하기)
		<c:url value="/updateNotify" var="updateNotify"/>
			function updateNotify(notify) {
				$.ajax({
					type : 'post',
					url : "${updateNotify }",
					data : {
						notifyNo : notify.notifyNo
					},
					success : function(res) {},
					error : function(xhr, status, error) {
						alert(error);
					}
				});
			}
			
			// 중요 기능 2 : headerNotification 있는지 확인 후, 실행
			<c:url value="/confirmHeaderNotify" var="confirmHeaderNotify"/>
				function headerNotification(userId) {
					
					$.ajax({
						type : 'post',
						url : "${confirmHeaderNotify }",
						data : {
							userId : userId
						},
						success : function(res) {
							
							// ( notify가 있다면 && notify가 1개 이상 있으면 표시 )
							if (res != "" && res.length > 0) {
								
								// 알람의 숫자 표시
								document.getElementById("notification_count").innerHTML = res.length;
								// 알림 숨김 취소 (열기) 
								$(".notification").css("display", "block");
								// (알림 내용 초기화, 이거 안하면 2배로 늘어남 )
								$(".notificationContent").html('');
								
								// 내용 별로 다르게 메시지 표시
								$(res).each(function(idx, data) {
									var date = new Date(res[res.length - (1 + idx)].notifyDate);
									// 임대 업무에 관한 notify 필터
									if ( res[res.length - (1 + idx)].leaseCallNo != null || res[res.length - (1 + idx)].leaseDirectNo != null
											|| res[res.length - (1 + idx)].leaseRequestNo != null || res[res.length - (1 + idx)].leaseSelectionNo != null
											|| res[res.length - (1 + idx)].leaseTransferNo != null) {
										// 1-1. 임대 요청이 도착했을 때,
										if ( res[res.length - (1 + idx)].leaseCallNo != null ) {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! 새로운 임대 요청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
										// 1-2. 임대 직접 요청이 도착했을 때,
										if ( res[res.length - (1 + idx)].leaseDirectNo != null ) {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! 새로운 임대 직접 요청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
										// 1-3. 임대 신청이 도착했을 때,
										if ( res[res.length - (1 + idx)].leaseRequestNo != null ) {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! 새로운 임대 신청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
										// 1-4. 임대 양도가 도착했을 때,
										if ( res[res.length - (1 + idx)].leaseTransferNo != null ) {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! 새로운 임대 양도 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
									}
									// 게시판 업무에 관하여
									if ( res[res.length - (1 + idx)].attribute != null ) {
										// 2. 커뮤니티 게시판에 댓글 달릴 때,
										if (res[res.length - (1 + idx)].attribute == 'COMMUNITY') {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! 게시물에 새로운 댓글이 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
										// 3. Q&A 게시판에 답변 달릴 때,
										if (res[res.length - (1 + idx)].attribute == 'Q_AND_A') {
											$(".notificationContent").append("<li><a href="+ res[res.length - (1 + idx)].notifyLink + " onClick=deleteNotify("+ res[res.length - (1 + idx)].notifyNo + ")>"  + res[res.length - (1 + idx)].userId + "님! Q&A에 새로운 답변이 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
										}
									}
								});
							} else {
								$(".notification").css("display", "none");
							}
						},
						error : function(xhr, status, error) {
							alert(error);
						}
					});
				}
				
	// (단위 기능 3 : 알림 모두 삭제)
	<c:url value="/deleteAllNotify" var="deleteAllNotify"/>
	function deleteAllNotify() {
		
		// 로그인 유저 확인
		var deleteAllUserId = "";
		
		if( "${sessionScope.admin.userId}" != "") {
			deleteAllUserId = "${sessionScope.admin.userId}"
		} else if( "${sessionScope.loginUser.userId}" != "" ) {
			deleteAllUserId = "${sessionScope.loginUser.userId}"
		} 
			
		$.ajax({
			// type을 설정합니다.
			type : 'post',
			url : "${deleteAllNotify }",
			// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
			data : {
				userId : deleteAllUserId
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(res) {
				$(".notificationContent").html('');
				$(".notification").css("display", "none");
			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});
	}
	
	// 알림 css 설정
	$(document).ready(function() {
		$("#notificationLink").click(function() {
			$("#notificationContainer").fadeToggle(300);
			return false;
		});

		$(document).click(function() {
			$("#notificationContainer").hide();
		});

	});
	
	
	
	
</script>
</html>