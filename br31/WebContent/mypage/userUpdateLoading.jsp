<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
</head>
<body>
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>
	
	<div class = "content">
		<div class = "unregister">
			<div>
				<img src = "http://localhost:9000/br31/images/baskin_logo_admin.png">
			</div>
			<div class = "unregister_content">
				<span>회원탈퇴가 완료되었습니다.</span><br>
				<p>그동안 배스킨라빈스 서비스를 이용해 주셔서 감사합니다.<br>
				보다 더 나은 서비스로 다시 찾아 뵙겠습니다.</p>
			</div>
			<div>
				<a href = "http://localhost:9000/br31/index.jsp"><button type = "button" class = "btn_confrim">배스킨 라빈스 첫화면</button></a>
			</div>
		</div>
	</div>	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>

</body>
</html>