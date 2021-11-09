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
		<section class = "loginFail">
				<h1>로그인에 실패했습니다.</h1>
			<div class = "loginF">	
				<div>
					<span>아이디/비밀번호를 잘못 입력하셨나요?</span>
					<a href = "http://localhost:9000/br31/login/login.jsp"><button type = "button" class = "btn_loginF">다시 로그인하기</button></a>
				</div>
				<div>
					<span>아이디/비밀번호를 잊어버리셨나요?</span>
					<a href = "http://localhost:9000/br31/login/login_id_search.jsp"><button type = "button" class = "btn_loginF">아이디/비밀번호 찾기</button></a>
				</div>
				<div>	
					<span>아직 회원이 아니신가요?<br>
					회원가입 하시고 배스킨 라빈스의 더 많은 혜택을 누리세요!</span>
					<a href = "http://localhost:9000/br31/join/join.jsp"><button type = "button" class = "btn_loginF">회원가입</button></a>
				</div>	
			</div>
		</section>
		
	</div>

	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
	

</body>
</html>