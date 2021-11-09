<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*, com.br31.vo.SessionVO" %>    
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");

	if(svo != null){	
		MemberDAO dao = new MemberDAO();
		String id = svo.getId();
		MemberVO vo = dao.getMypageData(id);
		dao.close();
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배스킨라빈스</title>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
</head>
<body>
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>
	
	<!-- content -->
	<div class = "content">
		<section class = "m_menu">
			<nav>
			<img src = "http://localhost:9000/br31/images/mybr.PNG">
			<h4>회원님을 위한 배스킨라빈스의 다양한 정보</h4>
				<ul>
					<a href = "mypage.jsp"><img src = "http://localhost:9000/br31/images/1st_mypage_onclick.PNG"></a>
					<a href = "mypage_f_shop.jsp"><img src = "http://localhost:9000/br31/images/2st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/2st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/2st_mypage.PNG'"></a>
					<a href = "mypage_f_flavor.jsp"><img src = "http://localhost:9000/br31/images/3st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/3st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/3st_mypage.PNG'"></a>
					<a href = "mypage_update.jsp"><img src = "http://localhost:9000/br31/images/4st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/4st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/4st_mypage.PNG'"></a>
					<a href = "mypage_unregister.jsp"><img src = "http://localhost:9000/br31/images/5st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/5st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/5st_mypage.PNG'"></a>
				</ul>
			</nav>
		</section>
		<section class = "m_page">
			<fieldset>
				<legend><img src = "http://localhost:9000/br31/images/myhappypoint.PNG"></legend>
				<div class = "card_div">	
					<div class = "card_section">
						<div>
						<fieldset>
							<img src = "http://localhost:9000/br31/images/card_img.PNG">
							<div class = "m_pageDivSpan">
								<span><%=vo.getCard() %></span>
							</div>
						</fieldset>
						</div>
						<div class = "hello">
							<span>안녕하세요</span>
							<span><%=vo.getName()%>님!</span>
						</div>
					</div>
				</div>	
				
				<div class = "point_section">
					<div>
						<img src = "http://localhost:9000/br31/images/happypoint_img.PNG">
					</div>
					<div>
						<span>해피포인트는 어떻게 발급 받나요?</span>
					</div>
					<div>
						<span>
						파리크라상,파리바게뜨, 배스킨라빈스, 던킨도너츠, 파스쿠찌, 빚은등<br>
						전국 6천여개의 해피포인트 가맹점에서 1,000원 이상 구매 후<br>
						요청 시 즉시 발급해 드립니다.
						</span>
					</div>
					<div>
						<button type = "button" class = "btn_pcheck">해피포인트 카드 등록</button>
						<button type = "button" class = "btn_pconfrim">해피포인트 상세내역 확인</button>
					</div>
				</div>	
				<div class = "point_show">
					<div>
						<span>사용가능 총 포인트</span>
					</div>
					<div>
						<span><%=vo.getPoint() %></span>
					</div>	
					<div>	
						<img src = "http://localhost:9000/br31/images/point_logo.PNG">
					</div>
				</div>
				
			</fieldset>
		</section>
		<section class = "m_page">
			<div class = "point_product">
				<span>해피포인트로 선물(구매) 가능한 제품</span>
				<span>*해피마켓에서 해피포인트로 배스킨라빈스 모바일 교환권을 선물하세요!</span>
			</div>
		</section>
		<section class = "m_page">
			<div class = "point_product">
				<div class = "promotion">
					<span>해피포인트 프로모션</span>
					<div>
						<a href = "#"><img src = "http://localhost:9000/br31/images/promotion_mypage.PNG"></a>
					</div>
					<div>	
						<a href = "#"><img src = "http://localhost:9000/br31/images/happypoint_img_mypage.PNG"></a>
					</div>
					<div>	
						<a href = "#"><span>메가 해피 데이즈! 케이크 최대 7,000원 OFF!</span></a>
						<a href = "#"><span>2021.05.14~2021.06.13</span></a>
					</div>
				</div>
			</div>
		</section>
	</div>
	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
	
</body>
</html>
<% }else{%>
	<script>
		window.alert("로그인후 사용이 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %>