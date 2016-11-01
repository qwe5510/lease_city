<!DOCTYPE html>
<html class="no-js">
<!--<![endif]-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<title>HOME | LEASE CITY</title>
</head>
<body>
	<!-- 가입 절차 설명 메시지 -->
	<c:if test="${!empty join_message }">
		<script type="text/javascript">
			var msg = '${join_message }'
			alert(msg);
		</script>
	</c:if>
	<jsp:include page="./layout/header.jsp"></jsp:include>
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
										<li class="span3"><a href="<%=request.getContextPath()%>/lease_request"><img
												src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/board"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/question/answer"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/introduction"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
									</ul>
								</div>
							</div>

							<div class="item">
								<div class="row-fluid">
									<ul class="thumbnails">
										<li class="span3"><a href="<%=request.getContextPath()%>/lease_request"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/question/answer"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/board"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath() %>introduction"><img
												src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
									</ul>
								</div>
							</div>

							<div class="item">
								<div class="row-fluid">
									<ul class="thumbnails">
										<li class="span3"><a href="<%=request.getContextPath()%>/lease_request"><img
												src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/board"><img
												src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath()%>/question/answer"><img
												src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
										<li class="span3"><a href="<%=request.getContextPath() %>introduction"><img
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
	<jsp:include page="./layout/footer.jsp"></jsp:include>
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