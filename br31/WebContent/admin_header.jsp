<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/commons.css">
<script>
	$(document).ready(function() {
		
		
		$(window).scroll(function () {
			var header_height = $(".main_bar").offset().top + $(".menu_bar").offset().top;
			var scroll = $(document).scrollTop();
			
			if(scroll > 200) {
				$(".admin_msg").addClass("fixed");
			} else {
				$(".admin_msg").removeClass("fixed");
			}
			
		}); 
		

		
	});
</script>
</head>
<body>
	<header>
		<div class="main_bar">
			<div class="sns">
				<nav>
					<ul>
						<li><a href="#"><img src="http://localhost:9000/br31/images/sns_youtube.png"></a></li>
						<li><a href="#"><img src="http://localhost:9000/br31/images/sns_instagram.png"></a></li>
						<li><a href="#"><img src="http://localhost:9000/br31/images/sns_blog.png"></a></li>
						<li><a href="#"><img src="http://localhost:9000/br31/images/sns_twitter.png"></a></li>
						<li><a href="#"><img src="http://localhost:9000/br31/images/sns_facebook.png"></a></li>
					</ul>
				</nav>
			</div>
			<div>
				<a href="http://localhost:9000/br31/adminIndex.jsp"><img src="http://localhost:9000/br31/images/admin_header.png" class="admin_logo"></a>
			</div>
			<div>
				<a href="http://localhost:9000/br31/index.jsp" target="_blank">홈페이지</a>
			</div>
		</div>

		<!-- 메뉴바 -->
		<div class="menu_bar">
			<nav class="menu">
				<ul>
					<li class="main_menu1">
						<a href="http://localhost:9000/br31/login/logout.jsp">LOGOUT</a>
						<!-- <a href="#"></a> -->
						<div class="submenu">
							<ul>
								<li><img src="http://localhost:9000/br31/images/happypoint_app.png"></li>
							</ul>
						</div>
					</li>
					<li class="main_menu2"><a href="http://localhost:9000/br31/member_admin/admin_member.jsp">회원정보 관리</a>
						<div class="submenu">
							<ul>
								<li><img src="http://localhost:9000/br31/images/monthly_menu.png"></li>
							</ul>
						</div>
					</li>
					<li><a href="http://localhost:9000/br31/menu/admin/admin_menu_icecream.jsp">메뉴·영양성분 관리</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/menu/admin/admin_menu_icecream.jsp">아이스크림</a></li>
								<li><a href="http://localhost:9000/br31/menu/admin/admin_menu_coffee.jsp">커피</a></li>
							</ul>
						</div>
					</li>
					<!-- 
					<li><a href="#">영양성분 관리</a>
						<div class="submenu">
							<ul>
								<li><a href="#">아이스크림</a></li>
								<li><a href="#">커피</a></li>
							</ul>
						</div>
					</li>
					 -->
					<li><a href="#">이벤트 관리</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/event/admin/event_list.jsp">진행이벤트</a></li>
								<li><a href="http://localhost:9000/br31/event/admin/event_list.jsp">당첨자발표</a></li>
							</ul>
						</div>
					</li>
					<li><a href="#">매장 관리</a>
						<div class="submenu">
							<ul>
								<li><a href="#">매장정보</a></li>
								<li><a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp">고객센터</a></li>
							</ul>
						</div>
					</li>
					<li><a href="#">정보 관리</a>
						<div class="submenu">
							<ul>
								<li><a href="http://localhost:9000/br31/notice/admin/notice_list.jsp">공지사항</a></li>
								<!-- <li><a href="#">채용정보</a></li> -->
							</ul>
						</div>
					</li>
				</ul>
				<div class="menu_bg"></div>
			</nav>
		</div>
		<div class="admin_msg">※ 관리자 계정으로 접속 중입니다.</div>
	</header>


</body>
</html>