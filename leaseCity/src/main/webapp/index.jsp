<!DOCTYPE html>
<html class="no-js">
<!--<![endif]-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Home | Nova</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">


<!-- <!-- <link rel="stylesheet" href="css/reset.css"> -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/sl-slide.css">


<script
	src="<%=request.getContextPath()%>/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>

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

	<!-- 가입 절차 설명 메시지 -->
	<c:if test="${!empty join_message }">
		<script type="text/javascript">
			var msg = '${join_message }'
			alert(msg);
		</script>
	</c:if>
	
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
								<li><a href="career.html">임대 신청/조회</a></li>
								<li><a href="registration.html">중기업체조회</a></li>
							</ul></li>
						<li id="con"><a href="about-us.html">커뮤니티</a></li>
						<li class="dropdown" id="con"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown">고객센터 <i
								class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="career.html">자주 묻는 질문</a></li>
								<li><a href="registration.html">도움말</a></li>
								<li><a href="terms.html">Q&A</a></li>
							</ul></li>
						<li id="con"><a href="blog.html">소개</a></li>
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

	<section id="slide-show">
		<div id="slider" class="sl-slider-wrapper">
			Slider Items
			<div class="sl-slider">
				Slider Item1
				<div class="sl-slide item1" data-orientation="horizontal"
					data-slice1-rotation="-25" data-slice2-rotation="-25"
					data-slice1-scale="2" data-slice2-scale="2">
					<div class="sl-slide-inner">
						<div class="container">
							<img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/경복궁.png"
								alt="" />
							<h2>경복궁</h2>
							<h4 class="gap">규모 43만 2702.87</h4>
							<h4 class="gap">소재지 서울특별시 종로구 세종로1</h4>
							<h4 class="gap">문화재 지정일 1963년 01월 21일</h4>
						</div>
					</div>
				</div>
				/Slider Item1 Slider Item2
				<div class="sl-slide item2" data-orientation="vertical"
					data-slice1-rotation="10" data-slice2-rotation="-15"
					data-slice1-scale="1.5" data-slice2-scale="1.5">
					<div class="sl-slide-inner">
						<div class="container">
							<img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/카사밀라.png"
								alt="" />
							<h2>Casa Mila</h2>
							<h4 class="gap">규모 1만 2000</h4>
							<h4 class="gap">바르셀로나 신도시계획 당시 세워진 연릭 주택</h4>
							<h4 class="gap">동굴같은 출입구, 독특한 모습 하지만</h4>
							<h4 class="gap">내부에는 현대적인 설비를 모두 갖추고 있다.</h4>
						</div>
					</div>
				</div>
				Slider Item2 Slider Item3
				<div class="sl-slide item3" data-orientation="horizontal"
					data-slice1-rotation="3" data-slice2-rotation="3"
					data-slice1-scale="2" data-slice2-scale="1">
					<div class="sl-slide-inner">
						<div class="container">
							<img class="pull-right"
								src="<%=request.getContextPath()%>/images/slider/피사의사탑.png"
								alt="" />
							<h2>Tower at Pisa</h2>
							<h4 class="gap">건축가 보나노 피사노</h4>
							<h4 class="gap">소재지 이탈리아 피사</h4>
							<h4 class="gap">피사의 십자형 두오모는 그 원주형 캄파닐레(종탑)와 원형 세례당과 함께
								세계에서도 가장 보기드문 건물군 중의 하나이다</h4>
						</div>
					</div>
				</div>
				Slider Item3

			</div>
			/Slider Items Slider Next Prev button
			<nav id="nav-arrows" class="nav-arrows">
				<span class="nav-arrow-prev"><i class="icon-angle-left"></i></span>
				<span class="nav-arrow-next"><i class="icon-angle-right"></i></span>
			</nav>
			/Slider Next Prev button

		</div>
	</section>

	<section id="clients" class="main">
		<div class="container">
			<div class="row-fluid">
				<div class="span2">
					<div class="clearfix">
						<h4 class="pull-left">Lease City</h4>
						<div class="pull-right">
							<a class="prev" href="#myCarousel" data-slide="prev"><i
								class="icon-angle-left icon-large"></i></a> <a class="next"
								href="#myCarousel" data-slide="next"><i
								class="icon-angle-right icon-large"></i></a>
						</div>
					</div>
					<p>website that is able to be a function of medium between
						construction company's and heavy equipment company's</p>
				</div>
				<div class="span10">
					<div id="myCarousel" class="carousel slide clients">
						<!-- Carousel items -->
						<div class="carousel-inner">
							<div class="active item">
								<div class="row-fluid">
									<ul class="thumbnails">
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
									</ul>
								</div>
							</div>

							<div class="item">
								<div class="row-fluid">
									<ul class="thumbnails">
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
									</ul>
								</div>
							</div>

							<div class="item">
								<div class="row-fluid">
									<ul class="thumbnails">
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="#"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
									</ul>
								</div>
							</div>
						</div>
						<!-- /Carousel items -->

					</div>
				</div>
			</div>
		</div>
	</section>

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

	<!--Footer-->
	<footer id="footer">
		<div class="container">
			<div class="row-fluid">
				<div class="span5 cp">Kongju National University Jang Pil Sik
					Yoon Hyun Joon Yang suo Ho CopyRighter</div>
				<!--/Copyright-->
				<div class="span6">
					<ul class="social pull-right">
						<li><a href="#"><i class="icon-facebook"></i></a></li>
						<li><a href="#"><i class="icon-twitter"></i></a></li>
						<li><a href="#"><i class="icon-pinterest"></i></a></li>
						<li><a href="#"><i class="icon-linkedin"></i></a></li>
						<li><a href="#"><i class="icon-google-plus"></i></a></li>
						<li><a href="#"><i class="icon-youtube"></i></a></li>
						<li><a href="#"><i class="icon-tumblr"></i></a></li>
						<li><a href="#"><i class="icon-dribbble"></i></a></li>
						<li><a href="#"><i class="icon-rss"></i></a></li>
						<li><a href="#"><i class="icon-github-alt"></i></a></li>
						<li><a href="#"><i class="icon-instagram"></i></a></li>
					</ul>
				</div>

				<div class="span1">
					<a id="gototop" class="gototop pull-right" href="#"><i
						class="icon-angle-up"></i></a>
				</div>
				<!--/Goto Top-->
			</div>
		</div>
	</footer>
	<!--/Footer-->

	<!--  Login form -->
	<div class="modal hide fade in" id="loginForm" aria-hidden="false">
		<div class="modal-header">
			<i class="icon-remove" data-dismiss="modal" aria-hidden="true"></i>
			<h4>Login Form</h4>
		</div>
		<!--Modal Body-->
		<div class="modal-body">
			<form class="form-inline" action="index.html" method="post"
				id="form-login">
				<input type="text" class="input-small" placeholder="Email">
				<input type="password" class="input-small" placeholder="Password">
				<label class="checkbox"> <input type="checkbox">
					Remember me
				</label>
				<button type="submit" class="btn btn-primary">Sign in</button>
			</form>
			<a href="#">Forgot your password?</a>
		</div>
		<!--/Modal Body-->
	</div>
	<!--  /Login form -->
	<script src="js/vendor/jquery-1.9.1.min.js"></script>
	<script src="js/vendor/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<!-- Required javascript files for Slider -->
	<script src="js/jquery.ba-cond.min.js"></script>
	<script src="js/jquery.slitslider.js"></script>
	<!-- /Required javascript files for Slider -->

	<!-- SL Slider -->
	<script type="text/javascript"> 
$(function() {
    var Page = (function() {

        var $navArrows = $( '#nav-arrows' ),
        slitslider = $( '#slider' ).slitslider( {
            autoplay : true
        } ),

        init = function() {
            initEvents();
        },
        initEvents = function() {
            $navArrows.children( ':last' ).on( 'click', function() {
                slitslider.next();
                return false;
            });

            $navArrows.children( ':first' ).on( 'click', function() {
                slitslider.previous();
                return false;
            });
        };

        return { init : init };

    })();
    Page.init();
});
</script>
	<!-- /SL Slider -->
</body>
</html>