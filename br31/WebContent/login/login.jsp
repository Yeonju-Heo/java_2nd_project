<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href = "http://localhost:9000/br31/choi.css">
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		$("button#loginBtn").click(function(){
			if($("#id").val() == ""){
				alert("아이디를 입력해주세요");
				
			}else if($("#pass").val() == ""){
				alert("비밀번호를 입력해주세요");
				
			}else{
				login_form.submit();
				
			}
			
		});
		
		$("#id").keyup(function(){
			$("#id").css("background-color","rgb(232, 240, 254)");
			
		});
		
	});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include> 
	
	<!-- content -->
	<div class = "content">
		<section class = "login">
			<div class = "title">
				<img src = "http://localhost:9000/br31/images/h_login.png">
				<span>배스킨 라빈스 홈페이지에 오신 것을 환영합니다.</span>
			</div>
			
			<div class = "login_div">
				<span>배스킨라빈스 로그인 </span>
				<span>해피포인트 아이디로 간편하게 로그인 하세요.</span>
				
				<!-- 로그인 -->	
				<form name = "login_form" action = "login_process.jsp" method = "post" class = "login_form"> 
					<fieldset>
						<ul>
							<div>
								<input type = "login"  id = "id" name = "id" placeholder = "아이디를 입력하세요" >
								<input type = "password" id = "pass" name = "pass" placeholder = "비밀번호를 입력하세요">
							</div>
							<div>
								<button type = "button" id = "loginBtn">로그인</button>
							</div>
						</ul>
					</fieldset>
				</form>
				<div class = "login_option">	
					<ul>
						<div>
							<a href = "login_id_search.jsp"><li>아이디 찾기</li></a> 
							<a href = "login_pass_search.jsp"><li>비밀번호 재발급</li></a> 
							<a href = "../join/join.jsp"><li>해피포인트 가입</li></a> 
						</div>	
					</ul>
				</div>
			</div>
			
			<div class = "info_div">
				<div>
				<span>SPC 통합회원 서비스</span>
					<p class = "info_content">
						하나의 ID/Password로 SPC가 운영하는 사이트(배스킨라빈스, 던킨도너츠,<br> 
						해피포인트카드, 파리바게뜨, 파리크라상, 파스쿠찌, SPC그룹,우리밀愛)를 한번에!!<br>
						간단한 동의 절차만 거치면 하나의 ID/Password로 제휴사이트를<br>
						로그인 하실 수 있습니다. <br>
					</p>
				</div>
				<div>
					<span>고객센터</span>
					<span class = "info_content">운영시간</span>
					<span class = "info_content2">월~금 09:00~17:30 토/일요일 휴무</span><br>
					
					<span class = "info_content">Tel.</span>
					<span class = "info_content2">080-555-3131(수신자부담)</span>
				</div>
			</div>
			
			<div class = "middle_info">
				<p>해피포인트 회원이 아니시라면 지금 해피포인트에 가입하시고 <br>
				다양한 혜택을 경험하세요.</p>
			</div>
			
			<div class = "show_benefit"">
				<div class = "d1">
					<div>
					<img src = "http://localhost:9000/br31/images/login_benefit.PNG">
					</div>
					<div>
						<span>혜택 하나</span>
						<span>배스킨라빈스 온라인 이벤트<br>
						행사에 참여할 수 있습니다.</span>
					</div>
				</div>
				<div class = "d2">
					<div>
					<img src = "http://localhost:9000/br31/images/login_benefit2.PNG">
					</div>
					<div>
						<span>혜택 둘</span>
						<span>월별 신제품을 보다<br>
						먼저 만날 수 있습니다.</span>
					</div>
				</div>
				<div class = "d3">
					<div>
					<img src = "http://localhost:9000/br31/images/login_benefit3.PNG">
					</div>
					<div>
						<span>혜택 셋</span>
						<span>배스킨라빈스 이벤트 정보<br>
						메일링을 받아 볼 수 있습니다.</span>
					</div>
				</div>
			</div>
			
		</section>
	</div>
	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
</body>
</html>