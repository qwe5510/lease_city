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
<!-- <!-- <link rel="stylesheet" href="css/reset.css"> -->
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
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath()%>/images/ico/apple-touch-icon-57-precomposed.png">
</head>

<body>
	<!--Header-->
	<header class="navbar navbar-fixed-top">
		<div class="notification">
		<div id="notification_li">
			<span id="notification_count"></span> 
			<a href="#" id="notificationLink">새 알림</a>
			<div id="notificationContainer">
				<div id="notificationTitle">Notifications</div>
				<div id="notificationsBody" class="notifications">
					<ul class="notificationContent"></ul>
				</div>
				<div id="notificationFooter">
					<a href="#">See All</a>
				</div>
			</div>
		</div></div>
		<div class="navbar-inner">
			<div class="container">
				<!-- <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a> -->
				<a id="logo" class="pull-left" href="<%=request.getContextPath()%>/index"></a>
				<div class="nav-collapse collapse pull-right">
					<ul class="nav">
						<li>
							<table>
								<tr>
									<th><select>
											<option>임대</option>
											<option>커뮤니티</option>
											<option>Q&A</option>
											<option>중기업체</option>
									</select></th>
									<th><input type="text" placeholder="검색어를 입력해주세요."></th>
									<th><input type="button" value="검색"></th>
								</tr>
							</table>
						</li>
						<li class="dropdown" id="con"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown">임대 <i
								class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath() %>/lease_call">임대 신청/조회</a></li>
								<li><a href="<%=request.getContextPath() %>/inquery_heavy">중기업체조회</a></li>
							</ul></li>
						<li id="con"><a href="<%=request.getContextPath() %>/board">커뮤니티</a></li>
						<li class="dropdown" id="con"><a href="<%=request.getContextPath() %>/help/FAQ"
							class="dropdown-toggle" data-toggle="dropdown">고객센터 <i
								class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath() %>/help/FAQ">자주 묻는 질문</a></li>
								<li><a href="<%=request.getContextPath() %>/help/qna">Q&A</a></li>
							</ul></li>
						<li id="con"><a href="<%=request.getContextPath() %>/introduction">소개</a></li>
						<c:url value="/login" var="login"></c:url>
						<c:url value="/logout" var="logout"></c:url>
						<c:choose>
							<c:when test="${!empty loginUser or !empty admin}">
								<li id="con"><a href=${logout }><i class="icon-signout"></i></a></li>
							</c:when>
							<c:otherwise>
								<li id="con"><a href=${login }><i class="icon-lock"></i></a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</header>
	<!-- /header -->
</body>
<script src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script>

	// (반복문 초기 실행)
	window.onload = function() {
		repeatloop();
		if ("${sessionScope.loginUser.userId}" != null) {
			//alert("로그인 아이디 : " + "${sessionScope.loginUser.userId}");
			headerNotification("${sessionScope.loginUser.userId}");
		} 
		if("${sessionScope.admin.userId}" != null) {
			headerNotification("${sessionScope.admin.userId}");
		}
	}
	// 반복 함수
	function repeatloop() {
		setTimeout("repeatloop()", 1000 * 5); //refresh 빈도 1000 = 1초
		if ("${sessionScope.loginUser.userId}" != null) {
			//alert("유저 로그인 아이디 : " + "${sessionScope.loginUser.userId}");
			footNotification("${sessionScope.loginUser.userId}");
		} 
		if("${sessionScope.admin.userId}" != null) {
			//alert("관리자 로그인 아이디 : " + "${sessionScope.admin.userId}");
			footNotification("${sessionScope.admin.userId}");
		}
	}

	<c:url value="/confirmNotify" var="confirmNotify"/>
	function footNotification(userId) {

		$.ajax({
			// type을 설정합니다.
			type : 'post',
			url : "${confirmNotify }",
			// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
			data : {
				userId : userId
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(res) {
				// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
				var notify = ""; // (test용 변수)
				var title = userId + " 님"; // notification의 title
				var iconDataURI = "http://vehicle-free.com/highresolution/l_023.jpg";
				// notify가 있다면

				if (res != "") {
					// 1. notification 에 보여줄 정보
					// ( notify가 1개 이상 있으면 표시 )
					if (res.length > 0) {
						// 알림 시, 바로 HeaderNotify 생성
						if ("${sessionScope.loginUser.userId}" != null) {
							//alert("로그인 아이디 : " + "${sessionScope.loginUser.userId}");
							headerNotification("${sessionScope.loginUser.userId}");
						} 
						if("${sessionScope.admin.userId}" != null) {
							headerNotification("${sessionScope.admin.userId}");
						}
						var options = {
							body : res.length + "개의 새 알림이 있습니다.",
							icon : iconDataURI
						}
						// 데이스탑 알림 요청 및 notifyCheck = 'Y'로 업뎃하기
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
						// 5초뒤 얼람 메시지 닫기
						setTimeout(function() {
							notification.close();
						}, 5000);
						//document.getElementById("notificationLink").innerHTML = res.length + "개의 알람";
					}

					// 2. header에 보여줄 정보
					// 각 notify 별로 정보 갖고오기
					$(res).each(function(idx, data) {
						if (res.attribute != null) {
							alert("leaseCallNo에 아무것도 없음");
						}
					});

				} else {
					//alert("notify 없음");
				}
			},
			error : function(xhr, status, error) {
				alert(error);
			}
		});
	}
	
	<c:url value="/deleteNotify" var="deleteNotify"/>
		function deleteNotify(notifyNo) {
			
			//alert("삭제할 알림 : " + notify.notifyNo);
			$.ajax({
				// type을 설정합니다.
				type : 'post',
				url : "${deleteNotify }",
				// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
				data : {
					notifyNo : notifyNo
				},
				// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
				success : function(res) {
					
				},
				error : function(xhr, status, error) {
					alert(error);
				}
			});
		}
		
		<c:url value="/updateNotify" var="updateNotify"/>
			function updateNotify(notify) {
				
				//alert("수정할 알림 : " + notify.notifyNo);
				$.ajax({
					// type을 설정합니다.
					type : 'post',
					url : "${updateNotify }",
					// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
					data : {
						notifyNo : notify.notifyNo
					},
					// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
					success : function(res) {
						
					},
					error : function(xhr, status, error) {
						alert(error);
					}
				});
			}
			
			<c:url value="/confirmHeaderNotify" var="confirmHeaderNotify"/>
				function headerNotification(userId) {
					
					$.ajax({
						// type을 설정합니다.
						type : 'post',
						url : "${confirmHeaderNotify }",
						// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
						data : {
							userId : userId
						},
						// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
						success : function(res) {
							// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
							var test = ""; // (test용 변수)
							
							// notify가 있다면
							if (res != "") {
								// 1. notification 에 보여줄 정보
								// ( notify가 1개 이상 있으면 표시 )
								document.getElementById("notification_count").innerHTML = res.length;
								if (res.length > 0) {
									//var html = "";
									$(res).each(function(idx, data) {
										var date = new Date(data.notifyDate);
										// 임대 업무에 관한 notify 필터
										if ( data.leaseCallNo != null || data.leaseDirectNo != null
												|| data.leaseRequestNo != null || data.leaseSelectionNo != null
												|| data.leaseTransferNo != null) {
											// 1-1. 임대 요청이 도착했을 때,
											if ( data.leaseCallNo != null ) {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 새로운 임대 요청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
											// 1-2. 임대 직접 요청이 도착했을 때,
											if ( data.leaseDirectNo != null ) {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 새로운 임대 직접 요청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
											// 1-3. 임대 신청이 도착했을 때,
											if ( data.leaseRequestNo != null ) {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 새로운 임대 신청 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
											// 1-4. 임대 선정이 도착했을 때,
											if ( data.leaseSelectionNo != null ) {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 새로운 임대 선정 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
											// 1-5. 임대 양도가 도착했을 때,
											if ( data.leaseTransferNo != null ) {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 새로운 임대 양도 메시지가 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
										}
										// 게시판 업무에 관하여
										if ( data.attribute != null ) {
											// 2. 커뮤니티 게시판에 댓글 달릴 때,
											if (data.attribute == 'COMMUNITY') {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! 게시물에 새로운 댓글이 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
											// 3. Q&A 게시판에 답변 달릴 때,
											if (data.attribute == 'Q_AND_A') {
												$(".notificationContent").append("<li><a href="+ data.notifyLink + " onClick=deleteNotify("+ data.notifyNo + ")>"  + data.userId + "님! Q&A에 새로운 답변이 도착했습니다.<br>" + date.toLocaleString() + "</a></li>");
											}
										}
									});
								}
							} else {
								//alert("headerNotify 없음");
							}
						},
						error : function(xhr, status, error) {
							alert(error);
						}
					});
				}
	
	$(document).ready(function() {
		$("#notificationLink").click(function() {
			$("#notificationContainer").fadeToggle(300);
			$("#notification_count").fadeOut("slow");
			return false;
		});

		//Document Click
		$(document).click(function() {
			$("#notificationContainer").hide();
		});
		//Popup Click
		$("#notificationContainer").click(function() {
			//return false
		});

	});
</script>
</html>