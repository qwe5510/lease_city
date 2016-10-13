<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src='//uchat.co.kr/uchat.php' charset='UTF-8'></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../layout/header.jsp"></jsp:include>
	<div class="board">
	<div class="uchat">
	 <script >
      u_chat({
        room : 'yhj123',
        chat_record : true,
        width : '400',
        height : '400',
		conversation_limi : true,
      	in_sound : true,
      	say_id : true,
      });
	</script>
	</div>
	<div class="community">
		유챗
	</div>
	</div>
	<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>


</html>