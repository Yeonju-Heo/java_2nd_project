<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>
	
	<!-- content -->
	<div class = "content">
		<section class = "joinSuccess">
				<h1>회원가입 성공</h1>
			<div>	
				<span>배스킨 라빈스 회원이 되신걸 환영합니다.</span><br>
				<span>로그인 하시고 배스킨 라빈스의 더 많은 혜택을 누리세요!</span>
			</div>	
			<div>
				<a href = "http://localhost:9000/br31/index.jsp"><button type = "button" class = "btn_cancle">홈으로</button></a>
				<a href = "http://localhost:9000/br31/login/login.jsp"><button type = "button" class = "btn_confrim">로그인하기</button></a>
			</div>
		</section>
		
	</div>

	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
	

</body>
</html>