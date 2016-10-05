<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Home | Nova</title>
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
	href="<%=request.getContextPath() %>/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="<%=request.getContextPath() %>/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="<%=request.getContextPath() %>/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="<%=request.getContextPath() %>/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="<%=request.getContextPath() %>/images/ico/apple-touch-icon-57-precomposed.png">
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
			<a id="logo" class="pull-left" href="index.jsp"></a>
			<div class="nav-collapse collapse pull-right">
				<ul class="nav">
					<li>
						<table>
							<tr>
								<th><select>
										<option>�Ӵ�</option>
										<option>Ŀ�´�Ƽ</option>
										<option>Q&A</option>
										<option>�߱��ü</option>
								</select></th>
								<th><input type="text" placeholder="�˻�� �Է����ּ���."></th>
								<th><input type="button" value="�˻�"></th>
							</tr>
						</table>
					</li>
					<li class="dropdown" id="con"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown">�Ӵ� <i
							class="icon-angle-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="career.html">�Ӵ� ��û/��ȸ</a></li>
							<li><a href="registration.html">�߱��ü��ȸ</a></li>
						</ul></li>
					<li id="con"><a href="about-us.html">Ŀ�´�Ƽ</a></li>
					<li class="dropdown" id="con"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown">������ <i
							class="icon-angle-down"></i></a>
						<ul class="dropdown-menu">
							<li><a href="career.html">���� ���� ����</a></li>
							<li><a href="registration.html">����</a></li>
							<li><a href="terms.html">Q&A</a></li>
						</ul></li>
					<li id="con"><a href="blog.html">�Ұ�</a></li>
					<c:url value="/login" var="login"></c:url>
					<li id="con"><a href=${login }> <i class="icon-lock"></i>
					</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	</header>
	<!-- /header -->
</body>
</html>