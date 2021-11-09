<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href = "http://localhost:9000/br31/choi.css">
<script>

/******
	팝업창 띄우기
*****/

$(document).on('click', '#button_phone',function(){
	var popupHeight = 400;
	var popupWidth = 500;

	var popupX = (window.screen.width/2) - (popupWidth / 2);
	var popupY= (window.screen.height/2) - (popupHeight / 2);	

	window.open('login_phone.jsp', 'window', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY + ', scrolbars = no ');

});

$(document).on('click', '#button_ipin',function(){
	var popupHeight = 400;
	var popupWidth = 500;

	var popupX = (window.screen.width/2) - (popupWidth / 2);
	var popupY= (window.screen.height/2) - (popupHeight / 2);	

	window.open('login_ipin.jsp', 'window', 'status=no, height=' + popupHeight  + ', width=' + popupWidth  + ', left='+ popupX + ', top='+ popupY + ', scrolbars = no ');
});

</script>

</head>
<body>
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include> 
	
	
	<!-- content -->
	<div class = "login_search_content">
		<section class = "id_search_content">
		 	<div class = "login_search_title">
		 		<h1>아이디/비밀번호 찾기</h1>
		 		<span>아이디가 기억나지 않으세요?<br>
		 		본인인증을 통해 아이디를 확인하실 수 있어요!</span>
		 	</div>
		 	<div class = "s_content">
		 		<div class = "si_show">
		 			<a href = "login_id_search.jsp"><span>아이디 찾기</span></a>
		 			<a href = "login_pass_search.jsp"><span>비밀번호 초기화</span></a>
		 		</div>
		 		<div>
		 			<div>
		 				<button type = "button" id =  "button_phone"></button>
		 			</div>
		 			<div>
		 				<button type = "button" id = "button_ipin"></button>
		 			</div>
		 		</div>
		 	</div>
		</section>
		<section class = "go_join">
			<div>
				<span>아직 배스킨라빈스 회원이 아니세요?</span>
				<span>ONEPASS 간편 가입으로 멤버십과 SPC 다양한 브랜드 혜택을 모두 이용 할 수 있어요!</span>
				<a href = "http://localhost:9000/br31/join/join.jsp"><button type = "button" class = "go_join_button">회원가입 바로가기</button></a>
			</div>
		</section>
	
	
	</div>
	

	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
</body>
</html>