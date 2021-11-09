<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.SessionVO" %>    
<%
	String id = "";
	id = request.getParameter("id");
	String not_login = ""; 
	
	SessionVO svo = (SessionVO)session.getAttribute("svo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/commons.css">
</head>
<body>
	<header>
		<div class="main_bar">
			<div>
				<nav class="sns">
					<ul>
						<li><a href="https://www.youtube.com/user/baskinrobbinskorea" target="_blank"><img src="http://localhost:9000/br31/images/sns_youtube.png"></a></li>
						<li><a href="https://www.instagram.com/baskinrobbinskorea/" target="_blank"><img src="http://localhost:9000/br31/images/sns_instagram.png"></a></li>
						<li><a href="https://blog.naver.com/brgirl31" target="_blank"><img src="http://localhost:9000/br31/images/sns_blog.png"></a></li>
						<li><a href="https://twitter.com/BaskinrobbinsKR" target="_blank"><img src="http://localhost:9000/br31/images/sns_twitter.png"></a></li>
						<li><a href="https://www.facebook.com/baskinrobbinskr/" target="_blank"><img src="http://localhost:9000/br31/images/sns_facebook.png"></a></li>
					</ul>
				</nav>
			</div>
			<div>
				<a href="http://localhost:9000/br31/index.jsp"><img src="http://localhost:9000/br31/images/br_logo.png" class="main_logo"></a>
			</div>
			<div>
				<a href="http://localhost:9000/br31/faq/faq_list.jsp">고객센터</a>
			</div>
		</div>

		<!-- 메뉴바 -->
		<div class="menu_bar">
			<nav class="menu">
				<ul>
					<li>
						<% if(svo == null) { %>
						<a href="http://localhost:9000/br31/login/login.jsp">LOGIN</a>
						<a href="http://localhost:9000/br31/join/join.jsp">JOIN</a>
						<% }else{ %>
						<a href="http://localhost:9000/br31/login/logout.jsp">LOGOUT</a>
						<% if(svo.getId().equals("admin")){ %>
						<a href="http://localhost:9000/br31/adminIndex.jsp">ADMIN</a>
						<%}else{ %>
						<a href="http://localhost:9000/br31/mypage/mypage.jsp">MY PAGE</a>
						<%} %>
						<% } %>
						<div class="submenu">
							<ul>
								<li class="menu_img"><img src="http://localhost:9000/br31/images/happypoint_app.png"></li>
							</ul>
						</div>
					</li>
					<li><a href="#">FLAVOR OF THE MONTH</a>
						<div class="submenu">
							<ul>
								<li class="menu_img"><img src="http://localhost:9000/br31/images/monthly_menu.png"></li>
							</ul>
						</div>
					</li>
					<li>
					<a href="http://localhost:9000/br31/menu/menu_default.jsp">MENU</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/menu/menu_icecream.jsp">아이스크림</a></li> 
								<li><a href="http://localhost:9000/br31/menu/menu_coffee.jsp">커피</a></li>
							</ul>
						</div>
					</li>
					<li>
					<a href="http://localhost:9000/br31/nutrient/nutrient_default.jsp">영양성분 및 알레르기</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/nutrient/nutrient_default.jsp?category=icecream">아이스크림</a></li>
								<li><a href="http://localhost:9000/br31/nutrient/nutrient_default.jsp?category=coffee">커피</a></li>
							</ul>
						</div> 
					</li>
					<li>
					
					<a href="http://localhost:9000/br31/event/event_list.jsp">EVENT</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/event/event_list.jsp">진행이벤트</a></li>
								<li><a href="#">당첨자발표</a></li>
							</ul>
						</div>
					</li>
					<li><a href="#">STORE</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/map/map.jsp">매장정보</a></li>
								<li><a href="http://localhost:9000/br31/faq/faq_list.jsp">고객센터</a></li>
							</ul>
						</div>
					</li>
					<li><a href="#">ABOUT</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/notice/notice_list.jsp">공지사항</a></li>
								<li><a href="http://localhost:9000/br31/recruit/recruit.jsp">채용정보</a></li>
							</ul>
						</div>
					</li>
				</ul>
				<div class="menu_bg"></div>
			</nav>
		</div>
	</header>


</body>
</html>