<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<!--Bottom-->
	<section id="bottom" class="main">
		<!--Container-->
		<div class="container">

			<!--row-fluids-->
			<div class="row-fluid">

				<!--Contact Form-->
				<div class="span3">
					<ul class="unstyled address">
					<li>
					<img src="<%=request.getContextPath() %>/images/logo/logo2.png"/>
					</li>
					</ul>
				</div>
				<!--End Contact Form-->

				<!--Important Links-->
				<div id="tweets" class="span3">
					<h4>CopyRighter</h4>
					<div>
						<ul class="arrow">
						<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> 
						<br>Email: wkdvlftlr123@gmail.com</li>
						<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> 
						<br>Email: wkdvlftlr123@gmail.com</li>
						<li><i class="icon-home"></i><strong>Jang Pil Sik</strong> 
						<br>Email: wkdvlftlr123@gmail.com</li>
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
							<li class="span3">
							
							<img src="<%=request.getContextPath() %>/images/building/build1.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build2.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build3.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build4.png"
								 alt="" /></li>
						</ul>
					</div>
					<div class="row-fluid">
						<ul class="thumbnails">
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build5.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build6.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build7.png"
								 alt="" /></li>
							<li class="span3">
							<img src="<%=request.getContextPath() %>/images/building/build8.png"
								 alt="" /></li>
						</ul>
					</div>

				</div>

			</div>
			<!--/row-fluid-->
		</div>
		<!--/container-->
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>