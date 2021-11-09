<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
section.main {
	text-align: center;
}
section.main_top {
	/* position: relative; */
}
section.main .banner a {
	margin-bottom: 0;
	height: 150px;
	display: block;
	background: #ef9dc1 url("http://localhost:9000/br31/images/main_banner.jpg") no-repeat center;
}
section.main .br_event {
	width: 1400px;
	margin: auto;
	text-align: center;
	padding: 50px 0 0 30px;
}
section.main ul {
	list-style-type: none;
	padding: 0;
}
section.main .event_list ul li {
	margin: 5px;
	display: inline-block;
}
section.main .event_list img{
	display: block;
	margin-top: 15px;
}
section.main .event_list span {
	display: block;
	text-align: left;
	font-size: 14px;
	margin-top: 5px;
	letter-spacing: -1px;
}
section.main .event_list li span:nth-child(4) {
	font-size: 12px;
	color: darkgray;
	margin-top: 10px;
}
section.main .event_list a {
	text-decoration: none;
	color: black;
}
section.main .br_menu {
	width: 100%;
	height: 700px;
	margin: 100px 0;
	text-align: center;
	display: inline-block;
	background: url("http://localhost:9000/br31/images/bg_menu.jpg") no-repeat center top;
}
section.main .br_menu div {
	width: 1400px;
	text-align: center;
	margin: auto;
	padding: 50px
}
section.main .store_order, section.main .sns, section.main .instagram {
	width: 1400px;
	margin: auto;
	text-align: center;
}
section.main .store_order li {
	display: inline-block;
	text-align: center;
	margin: 50px 0 0 0;
}
section.main .store_order ul, section.main .sns ul {
	width: 1400px;
	margin: auto;
}
section.main .store_order li>a img{
	display: block;
	margin: 30px 0;
}
section.main .sns {
	margin: 50px auto;
	text-align: center;
}
section.main .sns li {
	display: inline-block;
	text-align: center;
	margin: 30px 5px;
}
section.main .instagram>div div {
	width: 270px;
	height: 270px;
	overflow: hidden;
	display: inline-block;
}
section.main .instagram>div img {
	width: 270px;
	height: 270px;
}
section.main .instagram {
	margin-bottom: 100px; 
}
section.main .instagram span {
	display: inline-block;
	margin-bottom: 30px;
}
section.main .instagram div img:hover {
	transform: scale(1.2);
	transition: transform 0.7s;
}
.carousel {
	position: relative
}

.carousel.pointer-event {
	-ms-touch-action: pan-y;
	touch-action: pan-y
}

.carousel-inner {
	position: relative;
	width: 100%;
	height: 600px;
	overflow: hidden;
	margin-top: 3px;
}

.carousel-inner div:nth-child(1) {
	background-color: #ef9dc1;
}
.carousel-inner div:nth-child(2) {
	background-color: #76e1e7;
}
.carousel-inner div:nth-child(3) {
	background-color: #fc637f;
}

.carousel-inner::after {
	display: block;
	clear: both;
	content: ""
}

.carousel-item {
	position: relative;
	display: none;
	float: left;
	width: 100%;
	margin-right: -100%;
	-webkit-backface-visibility: hidden;
	backface-visibility: hidden;
	transition: -webkit-transform .6s ease-in-out;
	transition: transform .6s ease-in-out;
	transition: transform .6s ease-in-out, -webkit-transform .6s ease-in-out
}

@media ( prefers-reduced-motion :reduce) {
	.carousel-item {
		transition: none
	}
}

.carousel-item-next, .carousel-item-prev, .carousel-item.active {
	display: block
}

.active.carousel-item-right, .carousel-item-next:not (.carousel-item-left
	){
	-webkit-transform: translateX(100%);
	transform: translateX(100%)
}

.active.carousel-item-left, .carousel-item-prev:not (.carousel-item-right
	){
	-webkit-transform: translateX(-100%);
	transform: translateX(-100%)
}

.carousel-fade .carousel-item {
	opacity: 0;
	transition-property: opacity;
	-webkit-transform: none;
	transform: none
}

.carousel-fade .carousel-item-next.carousel-item-left, .carousel-fade .carousel-item-prev.carousel-item-right,
	.carousel-fade .carousel-item.active {
	z-index: 1;
	opacity: 1
}

.carousel-fade .active.carousel-item-left, .carousel-fade .active.carousel-item-right
	{
	z-index: 0;
	opacity: 0;
	transition: opacity 0s .6s
}

@media ( prefers-reduced-motion :reduce) {
	.carousel-fade .active.carousel-item-left, .carousel-fade .active.carousel-item-right
		{
		transition: none
	}
}

.carousel-control-next, .carousel-control-prev {
	position: absolute;
	top: 0;
	bottom: 0;
	z-index: 1;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-align: center;
	align-items: center;
	-ms-flex-pack: center;
	justify-content: center;
	width: 15%;
	color: #fff;
	text-align: center;
	opacity: .5;
	transition: opacity .15s ease
}

@media ( prefers-reduced-motion :reduce) {
	.carousel-control-next, .carousel-control-prev {
		transition: none
	}
}

.carousel-control-next:focus, .carousel-control-next:hover,
	.carousel-control-prev:focus, .carousel-control-prev:hover {
	color: #fff;
	text-decoration: none;
	outline: 0;
	opacity: .9
}

.carousel-control-prev {
	left: 0
}

.carousel-control-next {
	right: 0
}

.carousel-control-next-icon, .carousel-control-prev-icon {
	display: inline-block;
	width: 100px;
	height: 100px;
	background: no-repeat 50%/100% 100%
}

.carousel-control-prev-icon {
	background-image:
		url("http://localhost:9000/br31/images/btn_banner_prev.png")
}

.carousel-control-next-icon {
	background-image:
		url("http://localhost:9000/br31/images/btn_banner_next.png")
}

.carousel-indicators {
	position: absolute;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 15;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-pack: center;
	justify-content: center;
	padding-left: 0;
	margin-right: 15%;
	margin-left: 15%;
	list-style: none
}

.carousel-indicators li {
	box-sizing: content-box;
	-ms-flex: 0 1 auto;
	flex: 0 1 auto;
	width: 30px;
	height: 3px;
	margin-right: 3px;
	margin-left: 3px;
	text-indent: -999px;
	cursor: pointer;
	background-color: #fff;
	background-clip: padding-box;
	border-top: 10px solid transparent;
	border-bottom: 10px solid transparent;
	opacity: .5;
	transition: opacity .6s ease
}

@media ( prefers-reduced-motion :reduce) {
	.carousel-indicators li {
		transition: none
	}
}

.carousel-indicators .active {
	opacity: 1
}

.carousel-caption {
	position: absolute;
	right: 15%;
	bottom: 20px;
	left: 15%;
	z-index: 10;
	padding-top: 20px;
	padding-bottom: 20px;
	color: #fff;
	text-align: center
}
</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="header.jsp"></jsp:include>

	<!-- content -->
	<div class="content">
		<section class="main">
			<div class="main_top">
				<div class="banner"><a href="#" class="banner"></a></div>
				<!-- 캐러셀 -->
				<div id="demo" class="carousel slide" data-ride="carousel">
			
					<!-- Indicators -->
					<ul class="carousel-indicators">
						<li data-target="#demo" data-slide-to="0" class="active"></li>
						<li data-target="#demo" data-slide-to="1"></li>
						<li data-target="#demo" data-slide-to="2"></li>
					</ul>
			
					<!-- The slideshow -->
					<div class="carousel-inner">
						<div class="carousel-item active">
							<a href="#none"><img src="http://localhost:9000/br31/images/main_carousel_1.jpg" alt="carousel1" width="1350" height="600"></a>
						</div>
						<div class="carousel-item">
							<a href="http://localhost:9000/br31/event/event_content.jsp?articleno=5&rno=5"><img src="http://localhost:9000/br31/images/main_carousel_2.jpg" alt="carousel2" width="1350" height="600"></a>
						</div>
						<div class="carousel-item">
							<a href="http://localhost:9000/br31/event/event_content.jsp?articleno=3&rno=3"><img src="http://localhost:9000/br31/images/main_carousel_3.jpg" alt="carousel3" width="1350" height="600"></a>
						</div>
					</div>
			
					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#demo" data-slide="prev">
						<span class="carousel-control-prev-icon"></span>
					</a> 
					<a class="carousel-control-next" href="#demo" data-slide="next">
						<span class="carousel-control-next-icon"></span>
					</a>
				</div>
				<!-- 캐러셀 종료 -->		
			</div>
			

			
			
			<div class="br_event">
				<div>
					<img src="http://localhost:9000/br31/images/h_event.png">
				</div>
				<div class="event_list">
					<ul>
						<li>
							<a href="#">
								<img src="http://localhost:9000/br31/images/banner_delivery.png">
								<img src="http://localhost:9000/br31/images/stit_store.gif">
								<span>해피오더 딜리버리로 간편하게 주문하세요!</span>
								<span>상시진행</span>
							</a>
						</li>
						<li>
							<a href="#">
								<img src="http://localhost:9000/br31/images/banner_delivery_bm.png">
								<img src="http://localhost:9000/br31/images/stit_store.gif">
								<span>배달의 민족에서 빠르게 주문하세요!</span>
								<span>상시진행</span>
							</a>
						</li>
						<li>
							<a href="#">
								<img src="http://localhost:9000/br31/images/banner_delivery_ygy.png">
								<img src="http://localhost:9000/br31/images/stit_store.gif">
								<span>요기요에서 손쉽게 주문하세요!</span>
								<span>상시진행</span>
							</a>
						</li>
						<li>
							<a href="#">
								<img src="http://localhost:9000/br31/images/banner_delivery_kakao.png">
								<img src="http://localhost:9000/br31/images/stit_store.gif">
								<span>카카오톡 주문하기에서 편리하게 주문하세요!</span>
								<span>상시진행</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="br_menu">
				<div>
					<img src="http://localhost:9000/br31/images/h_menu.png">
				</div>
				<div>
					<a href="http://localhost:9000/br31/menu/menu_icecream.jsp">
						<img src="http://localhost:9000/br31/images/img_icecream.png">
					</a>
					<a href="http://localhost:9000/br31/menu/menu_coffee.jsp">
						<img src="http://localhost:9000/br31/images/img_coffee.png">
					</a>
				</div>
			</div>
			<div class="store_order">
				<ul>
					<li>
						<div><img src="http://localhost:9000/br31/images/h_store.png"></div>
						<a href="http://localhost:9000/br31/map/map.jsp"><img src="http://localhost:9000/br31/images/img_store.jpg"></a>
					</li>
					<li>
						<div><img src="http://localhost:9000/br31/images/h_happyorder_delivery.png"></div>
						<a href="#"><img src="http://localhost:9000/br31/images/img_happyorder_delivery.png"></a>
					</li>
				</ul>
			</div>
			<div class="sns">
				<div><img src="http://localhost:9000/br31/images/h_sns.png"></div>
				<ul>
					<li><a href="https://www.youtube.com/user/baskinrobbinskorea" target="_blank"><img src="http://localhost:9000/br31/images/sns_youtube.png"></a></li>
					<li><a href="https://www.instagram.com/baskinrobbinskorea/" target="_blank"><img src="http://localhost:9000/br31/images/sns_instagram.png"></a></li>
					<li><a href="https://blog.naver.com/brgirl31" target="_blank"><img src="http://localhost:9000/br31/images/sns_blog.png"></a></li>
					<li><a href="https://twitter.com/BaskinrobbinsKR" target="_blank"><img src="http://localhost:9000/br31/images/sns_twitter.png"></a></li>
					<li><a href="https://www.facebook.com/baskinrobbinskr/" target="_blank"><img src="http://localhost:9000/br31/images/sns_facebook.png"></a></li>
				</ul>
			</div>
			<div class="instagram">
				<span>
					<img src="http://localhost:9000/br31/images/tit_sns.png">
				</span>
				<div>
					<div><img src="http://localhost:9000/br31/images/insta_1.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_2.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_3.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_4.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_5.jpg"></div>
				</div>
				<div>
					<div><img src="http://localhost:9000/br31/images/insta_6.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_7.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_8.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_9.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_10.jpg"></div>
				</div>
				<div>
					<div><img src="http://localhost:9000/br31/images/insta_11.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_12.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_13.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_14.jpg"></div>
					<div><img src="http://localhost:9000/br31/images/insta_15.jpg"></div>
				</div>
			</div>
		</section>
	</div>

	<!-- footer -->
	<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>