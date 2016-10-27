<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</html>