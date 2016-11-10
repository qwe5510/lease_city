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
<title>HOME | LEASE CITY</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width">

<!-- <!-- <link rel="stylesheet" href="css/reset.css"> -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/sl-slide.css">

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

<title>HOME | LEASE CITY</title>

</head>
<body>
	<!-- 메인으로 이동 시 보이는 메시지 -->
	<c:if test="${!empty index_message }">
		<script>
			alert("${index_message }");
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
								src="<%=request.getContextPath()%>/images/slider/경복궁.png" alt="" />
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

	<section id="clients" class="main" style="padding-bottom: 0px;">
		<div class="container">
			<div class="row-fluid">
				<c:choose>
					<c:when test="${empty sessionScope.admin and empty sessionScope.loginUser}">
						<div class="span2" style="height: 350px;">
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
												<li class="span3"><a
													href="<%=request.getContextPath()%>/lease_request"><img
														src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/board"><img
														src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/question/answer"><img
														src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/introduction"><img
														src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
											</ul>
										</div>
									</div>

									<div class="item">
										<div class="row-fluid">
											<ul class="thumbnails">
												<li class="span3"><a
													href="<%=request.getContextPath()%>/lease_request"><img
														src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/question/answer"><img
														src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/board"><img
														src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>introduction"><img
														src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
											</ul>
										</div>
									</div>

									<div class="item">
										<div class="row-fluid">
											<ul class="thumbnails">
												<li class="span3"><a
													href="<%=request.getContextPath()%>/lease_request"><img
														src="<%=request.getContextPath()%>/images/menu/임대.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/board"><img
														src="<%=request.getContextPath()%>/images/menu/커뮤니티.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath()%>/question/answer"><img
														src="<%=request.getContextPath()%>/images/menu/Q&A.PNG"></a></li>
												<li class="span3"><a
													href="<%=request.getContextPath() %>introduction"><img
														src="<%=request.getContextPath()%>/images/menu/소개.PNG"></a></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- /Carousel items -->

							</div>
							<video width="300" height="200" controls>
								<source src="https://www.youtube.com/watch?v=y2OFPvYxZuY.mp4" type="video/mp4">
							</video>
						</div>
					</c:when>
					<c:otherwise>
					<div style="width: 100%;">
						<div style="float: left; width: 180px;">
						<div class="clearfix">
						<h3 class="pull-left">Lease City</h3>
						</div>
						<p>website that is able to be a function of medium between
						construction company's and heavy equipment company's</p>
						</div>
						<div class="today_lease">
							<h4>금주의 임대요청</h4><br>
							<div id="SpecialRolling">
								<div id="Prev0"></div>
								<div id="Next0"></div>
							</div>
							<div id="SpecialRolling">
								<div id="Prev1"></div>
								<div id="Next1"></div>
							</div>
							<div id="SpecialRolling">
								<div id="Prev2"></div>
								<div id="Next2"></div>
							</div>
							<div id="SpecialRolling">
								<div id="Prev3"></div>
								<div id="Next3"></div>
							</div>
						</div>
						<div style="float:left; width: 380px; display: inline-block;">
							<div class="bxslider">
							<div class="weatherGegion" id="seoul"">
							<!-- weather widget start --><div id="m-booked-weather-bl250-60879"> <a href="//booked.kr/weather/seoul-18406" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number">-3</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>6&deg;</div> <div class="booked-wzs-day-n">L: -7&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">서울특별시</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val">-3&deg;</td> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>8&deg;</td> <td class="week-day-val"><span class="plus">+</span>7&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>12&deg;</td> </tr> <tr> <td class="week-day-val">-3&deg;</td> <td class="week-day-val">-5&deg;</td> <td class="week-day-val">-3&deg;</td> <td class="week-day-val">-2&deg;</td> <td class="week-day-val">-3&deg;</td> <td class="week-day-val">-4&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-60879'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=18406&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="incheon"">
							<!-- weather widget start --><div id="m-booked-weather-bl250-19383"> <a href="//booked.kr/weather/incheon-w651440" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number">-2</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>7&deg;</div> <div class="booked-wzs-day-n">L: -5&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">인천</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val">-2&deg;</td> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>11&deg;</td> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> </tr> <tr> <td class="week-day-val">-2&deg;</td> <td class="week-day-val">-3&deg;</td> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> <td class="week-day-val">0&deg;</td> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> <td class="week-day-val">0&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-19383'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651440&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="busan"">
							<!-- weather widget start --><div id="m-booked-weather-bl250-82528"> <a href="//booked.kr/weather/busan-12084" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>4</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>15&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>5&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">부산광역시</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>10&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>10&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-82528'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=12084&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" class="weatherGegion" id="daejeon">
							<!-- weather widget start --><div id="m-booked-weather-bl250-8435"> <a href="//booked.kr/weather/daejeon-w651381" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>24</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>34&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>25&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">대전</div> <div class="booked-wzs-250-175-date">화요일, 09 8월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>수</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-03"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>24&deg;</td> <td class="week-day-val"><span class="plus">+</span>31&deg;</td> <td class="week-day-val"><span class="plus">+</span>31&deg;</td> <td class="week-day-val"><span class="plus">+</span>31&deg;</td> <td class="week-day-val"><span class="plus">+</span>33&deg;</td> <td class="week-day-val"><span class="plus">+</span>35&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>24&deg;</td> <td class="week-day-val"><span class="plus">+</span>22&deg;</td> <td class="week-day-val"><span class="plus">+</span>22&deg;</td> <td class="week-day-val"><span class="plus">+</span>21&deg;</td> <td class="week-day-val"><span class="plus">+</span>24&deg;</td> <td class="week-day-val"><span class="plus">+</span>26&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-8435'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651381&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="gwangju">
							<!-- weather widget start --><div id="m-booked-weather-bl250-74459"> <a href="//booked.kr/weather/gwangju-w651419" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>2</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>10&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>2&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">광주</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-06"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>2&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>12&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>15&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>2&deg;</td> <td class="week-day-val"><span class="plus">+</span>2&deg;</td> <td class="week-day-val"><span class="plus">+</span>7&deg;</td> <td class="week-day-val"><span class="plus">+</span>5&deg;</td> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-74459'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651419&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="jeju">
							<!-- weather widget start --><div id="m-booked-weather-bl250-49720"> <a href="//booked.kr/weather/jeju-si-w651461" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>9</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>14&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>9&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">제주</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>19&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>9&deg;</td> <td class="week-day-val"><span class="plus">+</span>12&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-49720'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651461&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="anyang">
							<!-- weather widget start --><div id="m-booked-weather-bl250-37314"> <a href="//booked.kr/weather/anyang-si-w651464" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-18"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>10</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>10&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>10&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">경기도</div> <div class="booked-wzs-250-175-date">수요일, 13 4월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> <td>화</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>19&deg;</td> <td class="week-day-val"><span class="plus">+</span>22&deg;</td> <td class="week-day-val"><span class="plus">+</span>19&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>13&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>7&deg;</td> <td class="week-day-val"><span class="plus">+</span>2&deg;</td> <td class="week-day-val"><span class="plus">+</span>3&deg;</td> <td class="week-day-val"><span class="plus">+</span>6&deg;</td> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> <td class="week-day-val"><span class="plus">+</span>4&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-37314'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651464&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="gangneung">
							<!-- weather widget start --><div id="m-booked-weather-bl250-77316"> <a href="//booked.kr/weather/kang-neung-w651437" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-03"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>23</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>23&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>18&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">강원도</div> <div class="booked-wzs-250-175-date">일요일, 29 5월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>월</td> <td>화</td> <td>수</td> <td>목</td> <td>금</td> <td>토</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>20&deg;</td> <td class="week-day-val"><span class="plus">+</span>20&deg;</td> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>21&deg;</td> <td class="week-day-val"><span class="plus">+</span>21&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>15&deg;</td> <td class="week-day-val"><span class="plus">+</span>15&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>15&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-77316'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651437&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="seosan">
							<!-- weather widget start --><div id="m-booked-weather-bl250-4247"> <a href="//booked.kr/weather/suisan-w651388" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-18"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>18</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>18&deg;</div> <div class="booked-wzs-day-n">L: <span class="plus">+</span>18&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">충청도</div> <div class="booked-wzs-250-175-date">토요일, 22 10월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>일</td> <td>월</td> <td>화</td> <td>수</td> <td>목</td> <td>금</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>19&deg;</td> <td class="week-day-val"><span class="plus">+</span>19&deg;</td> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>18&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>16&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>11&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-4247'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651388&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							<div class="weatherGegion" id="jeonju">
							<!-- weather widget start --><div id="m-booked-weather-bl250-13770"> <a href="//booked.kr/weather/jeonju-w651452" class="booked-wzs-250-175" style="background-color:#137AE9;"> <div class="booked-wzs-250-175-data wrz-01"> <div class="booked-wzs-250-175-right"> <div class="booked-wzs-day-deck"> <div class="booked-wzs-day-val"> <div class="booked-wzs-day-number"><span class="plus">+</span>1</div> <div class="booked-wzs-day-dergee"> <div class="booked-wzs-day-dergee-val">&deg;</div> <div class="booked-wzs-day-dergee-name">C</div> </div> </div> <div class="booked-wzs-day"> <div class="booked-wzs-day-d">H: <span class="plus">+</span>7&deg;</div> <div class="booked-wzs-day-n">L: -2&deg;</div> </div> </div> <div class="booked-wzs-250-175-city">전라도</div> <div class="booked-wzs-250-175-date">수요일, 09 11월</div> <div class="booked-wzs-left"> <span class="booked-wzs-bottom-l">7일 예보 보기</span> </div> </div> </div> <table cellpadding="0" cellspacing="0" class="booked-wzs-table-250"> <tr> <td>화</td> <td>목</td> <td>금</td> <td>토</td> <td>일</td> <td>월</td> </tr> <tr> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-18"></div></td> <td class="week-day-ico"><div class="wrz-sml wrzs-01"></div></td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> <td class="week-day-val"><span class="plus">+</span>7&deg;</td> <td class="week-day-val"><span class="plus">+</span>11&deg;</td> <td class="week-day-val"><span class="plus">+</span>10&deg;</td> <td class="week-day-val"><span class="plus">+</span>17&deg;</td> <td class="week-day-val"><span class="plus">+</span>14&deg;</td> </tr> <tr> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> <td class="week-day-val">-2&deg;</td> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> <td class="week-day-val"><span class="plus">+</span>6&deg;</td> <td class="week-day-val"><span class="plus">+</span>1&deg;</td> </tr> </table> </a> </div><script type="text/javascript"> var css_file=document.createElement("link"); css_file.setAttribute("rel","stylesheet"); css_file.setAttribute("type","text/css"); css_file.setAttribute("href",'//s.bookcdn.com/css/w/booked-wzs-widget-275.css?v=0.0.1'); document.getElementsByTagName("head")[0].appendChild(css_file); function setWidgetData(data) { if(typeof(data) != 'undefined' && data.results.length > 0) { for(var i = 0; i < data.results.length; ++i) { var objMainBlock = document.getElementById('m-booked-weather-bl250-13770'); if(objMainBlock !== null) { var copyBlock = document.getElementById('m-bookew-weather-copy-'+data.results[i].widget_type); objMainBlock.innerHTML = data.results[i].html_code; if(copyBlock !== null) objMainBlock.appendChild(copyBlock); } } } else { alert('data=undefined||data.results is empty'); } } </script> <script type="text/javascript" charset="UTF-8" src="http://widgets.booked.net/weather/info?action=get_weather_info&ver=4&cityID=w651452&type=3&scode=2&ltid=3457&domid=593&cmetric=1&wlangID=24&color=137AE9&wwidth=250&header_color=ffffff&text_color=333333&link_color=08488D&border_form=1&footer_color=ffffff&footer_text_color=333333&transparent=0"></script><!-- weather widget end -->
							</div>
							</div>
						</div>
						</div>	
					</c:otherwise>
				</c:choose>
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
	<!-- 검색어 만들기 -->
	<!-- /SL Slider -->
</body>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery.bxslider.min.js"></script>
<link href="<%=request.getContextPath() %>/css/jquery.bxslider.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery.ba-cond.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.slitslider.js"></script>
<script>
	$(document).ready(function(){
	  $('.bxslider').bxSlider({
		  slideWidth:280,
		  nextSelector: '#next', 
		  prevSelector: '#prev', 
		  nextText: 'next', 
		  prevText: 'prev' 
	  });
	});
	$(function() {
        
        
        var Page = (function() {

           var $navArrows = $('#nav-arrows'), slitslider = $('#slider')
                 .slitslider({
                    autoplay : true
                 }),

           init = function() {
              initEvents();
           }, initEvents = function() {
              $navArrows.children(':last').on('click', function() {
                 slitslider.next();
                 return false;
              });

              $navArrows.children(':first').on('click', function() {
                 slitslider.previous();
                 return false;
              });
           };

           return {
              init : init
           };

        })();
        Page.init();
     });

  var leaseCallList;
  <c:url value="/autoSelectLeaseCalls" var="autoSelectLeaseCalls"/>
  function testfunction(val) {
     $.ajax({
        // type을 설정합니다.
        type : 'get',
        url : "${autoSelectLeaseCalls }",
        // 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
        data : {
           //leaseCallNo : val
        },
        // 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
        success : function(res) {
           leaseCallList = res ;
           console.log("가져온 리스트 : " + res);
           //return leaseCommentTitle;
        },
        error : function(xhr, status, error) {
           console.log(status);
        }
     });
     return leaseCallList;
  }

  $(function() {
     
     // 밑에 함수 실행
     RollingText("Prev", "Next", 0);
     // 함수 1
     function RollingText(P, N, idx) {
     
        var maxcnt = 3;

        // 아이디 갖고오기
        var Prev = "#" + P + idx;
        var Next = "#" + N + idx;

        // css 갖고오기
        var pos1 = $(Prev).css("top").replace("px", "");
        var pos2 = $(Next).css("top").replace("px", "");
        //alert('111');

        // animate가 실행될 떄, 올라올 텍스트의 위치 설정
        if (pos1 <= -28) {
           $(Prev).css("top", "28px");
        }
        if (pos2 <= -56) {
           $(Next).css("top", "0px");
        }

        // 첫번째 animate의 값 설정
        fn_Next(idx);

        // (이전 값들 밀어내기)
        $(Prev).delay(100).animate({
           top : "-=28px"
        }, 600, function() {
        });

        // (갱신된 값 갖고 오기)
        $(Next).delay(100).animate({
           top : "-=28px"
        }, 600, function() {
           fn_Next(idx);
           fn_Prev(idx);
           idx++;
           if (idx > maxcnt) {
              setTimeout(function() {
                 RollingText(P, N, 0);
           }, 7000);
              
           } else {
              RollingText(P, N, idx);
           }
        });
     }
     //다음이 지나가고 이전꺼에 다음 순위 불러오는 처리 Ajax
     function fn_Prev(val) {
        //console.log("1  : " + testfunction(val) + " and " + val);
        if( testfunction(val) == undefined) {
           console.log("undefind ..");
           //RollingText(vPrev, vNext, 0);
           return;
        }
        
        var text = testfunction(val);
        var PrevVal = "#" + "Prev" + val;
        if( val < testfunction(val).length) {
           $(PrevVal).empty().append("<div><a href=http://localhost:9090/leaseCity/leaseCall/read?leaseCallNo="+ testfunction(val)[val].leaseCallNo + ">"  + testfunction(val)[val].leaseCommentTitle + "</a></div>");
        } else {
           $(PrevVal).empty().append("");
        }
     }
     //다음 순위 불러오는 함수 처리 Ajax
     function fn_Next(val) {
        //console.log("2 : " + testfunction(val) + " and " + val);
        //consolo.log("length : " + testfunction(val).length);
        if( testfunction(val) == undefined) {
           console.log("undefind ..");
           //RollingText(vPrev, vNext, 0);
           return;
        }
        var text = testfunction(val);
        var NextVal = "#" + "Next" + val;
        if( val < testfunction(val).length ) {
           $(NextVal).empty().append("<div><a href=http://localhost:9090/leaseCity/leaseCall/read?leaseCallNo="+ testfunction(val)[val].leaseCallNo + ">"  + testfunction(val)[val].leaseCommentTitle + "</a></div>");
        } else {
           $(NextVal).empty().append("");
        }
     }
  });
		
	// 함수 1 : 실시간 임대 요청 업데이트
	var leaseCallList;
	<c:url value="/autoSelectLeaseCalls" var="autoSelectLeaseCalls"/>
	function realtimeUpdateLeaseCalls(val) {
		$.ajax({
			// type을 설정합니다.
			type : 'get',
			url : "${autoSelectLeaseCalls }",
			// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
			data : {
				//leaseCallNo : val
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(res) {
				leaseCallList = res ;
				console.log("가져온 리스트 : " + res);
				//return leaseCommentTitle;
			},
			error : function(xhr, status, error) {
				console.log(status);
			}
		});
		return leaseCallList;
	}
</script>
</body>
</html>