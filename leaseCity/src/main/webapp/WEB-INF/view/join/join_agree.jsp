<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class=login>
		<img src="<%=request.getContextPath()%>/images/login/agree.png">
		<div class="agree">
			<h4>leaseCity 이용약관 동의(필수)</h4>
			<div class="agree_inner">
			<div>제1조(목적)</div>
			<div>이 약관은 leaseCity가 운영·관리하는 각종 교육 및 시설물 등 이용과 관련하여, 제공되는 인터넷 서비스(이하 “서비스”라 한다)를 이용함에 있어 이용자의 권리․ 의무 및 책임사항을 규정함을 목적으로 합니다</div>
			<div>제2조(정의)</div>
			<div>① "회원"이라 함은 leaseCity 웹사이트에 개인정보를 제공하여 회원등록을 한 자로서, leaseCity가 제공하는 서비스를 계속적으로 이용할 수 있는 자를 말합니다.</div>
			<div>② ‘비회원’이라 함은 회원에 가입하지 않고 “관리자”이 제공하는 서비스를 이용하는 자를 말합니다.</div>
			<div>제3조 (약관의 명시와 개정)</div>
			<div>① “괸리자”는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처(전화, 팩스, 전자우편 주소 등) 등을 이용자가 알 수 있도록 leaseCity에서 볼 수 있도록한다.</div>
			<div>② “관리자”는 약관의규제등에관한법률, 전자거래기본법, 전자서명법, 정보통신망이용촉진등에관한법률, 방문판매등에관한법률, 소비자보호법 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.</div>
			<div>제4조(서비스의 제공 및 변경)</div>
			<div>①“이용자_1”가 제공하기로 "이용자_2"와 계약을 체결한 서비스의 내용을 재화의 품절 또는 기술적 사양의 변경등의 사유로 변경할 경우에는 “이용자_1”은 이로 인하여 "이용자_2"가 입은 손해를 배상합니다. 단, “이용자_1”에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</div>
			<div>제5조(서비스의 중단)</div>
			<div>① “관리자”는 컴퓨터 등 정보통신설비의 보수점검․ 교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.</div>
			<div>② “관리자”는 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단 “관리자”에 고의 또는 과실이 없는 경우에는 그러하지 아니합니다.</div>
			</div><br><br>
			<h4>회원정보 이용 대한 안내(필수)</h4>
			<div class="agree_inner">
			<div>제6조(회원가입)</div>
			<div>① 이용자는 “관리자”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.</div>
			<div>② “관리자”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각호에 해당하지 않는 한 회원으로 등록합니다.</div>
			<div>제7조(회원 탈퇴 및 자격 상실 등)</div>
			<div>① 회원은 “관리자”에 언제든지 탈퇴를 요청할 수 있으며 “관리자”은 즉시 회원탈퇴를 처리합니다.</div>
			<div>② 회원이 다음 각호의 사유에 해당하는 경우, “관리자”은 회원자격을 제한 및 정지시킬 수 있습니다.</div>
			<div>1. 가입 신청시에 허위 내용을 등록한 경우</div>
			<div>2. “관리자”을 이용하여 구입한 재화․ 용역 등의 대금, 기타 “관리자”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우</div>
			<div>3. 다른 사람의 “관리자” 이용을 방해하거나 그 정보를 도용하는 등 전자거래질서를 위협하는 경우</div>
			<div>4. “관리자”을 이용하여 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우</div>
			<div>③ “관리자”이 회원 자격을 제한․ 정지 시킨후, 동일한 행위가 2회이상 반복되거나 30일이내에 그 사유가 시정되지 아니하는 경우 “관리자”은 회원자격을 상실시킬 수 있습니다.</div>
			<div>④ “관리자”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소전에 소명할 기회를 부여합니다.</div>
			</div>
	</div>
	<form class="agree_input">
		<input type="submit" formaction="<%=request.getContextPath() %>/join_input" formmethod="post" value="동의">
		<input type="submit" formaction="<%=request.getContextPath() %>/index" formmethod="get" value="비동의">
	</form>
	</div>
	<!--Bottom-->
	<section id="bottom" class="main"> <!--Container-->
	<div class="container">

		<!--row-fluids-->
		<div class="row-fluid">

			<!--Contact Form-->
			<div class="span3">
				<ul class="unstyled address">
					<li><img
						src="<%=request.getContextPath() %>/images/logo/logo2.png" /></li>
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
							src="<%=request.getContextPath() %>/images/building/build1.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build2.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build3.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build4.png"
							alt="" /></li>
					</ul>
				</div>
				<div class="row-fluid">
					<ul class="thumbnails">
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build5.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build6.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build7.png"
							alt="" /></li>
						<li class="span3"><img
							src="<%=request.getContextPath() %>/images/building/build8.png"
							alt="" /></li>
					</ul>
				</div>

			</div>

		</div>
		<!--/row-fluid-->
	</div>
	<!--/container--> <jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>