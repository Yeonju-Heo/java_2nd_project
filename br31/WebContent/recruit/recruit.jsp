<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
section.recruit {
	width: 1400px;
	margin: auto;
	text-align: center;
}
.title {
	margin: 70px 0;
}
.title p {
	margin-bottom: 5px;
}
.title span {
	font-size: 15px;
}
.title p:before, .title p:after {
	width: 36px;
	height: 26px;
	display: inline-block;
	background-repeat: no-repeat;
	background-position: center;
	content: "";
}
.title p:before {
	margin-right: 5px;
	background-image: url("http://localhost:9000/br31/images/icon_title_1.png");
}
.title p:after {
	margin-left: 5px;
	background-image: url("http://localhost:9000/br31/images/icon_title_2.png");
}
.title img {
	display: inline-block;
	margin: 0 10px;
}
.recruit_type {
	display: inline-block;
	width: 900px;
	text-align: center;
	margin-bottom: 150px;
}
.recruit_type section {
	width: 400px;
	height: 410px;
	display: inline-block;
	padding: 40px 0;
	border: 2px solid #dedede;
	border-radius: 5px;
}
.recruit_type>section img{
	display: block;
	margin: 20px auto;
}
.recruit_type p {
	font-size: 13px;
	margin: 20px 0 30px 0;
}
.recruit_type a {
	color: white;
	font-weight: bold;
	padding: 10px 30px;
	border-radius: 50px;
	background-color: #ff7c9e;
	text-decoration: none;
}
.recruit_type .type1 {
	float: left;
}
.recruit_type .type2 {
	float: right;
}

</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	
	<!-- content -->
	<section class="recruit">
		<div class="title">
			<p><img src="http://localhost:9000/br31/images/jobs_title.gif"></p>
			<span>당신의 소중한 꿈, 배스킨라빈스와 함께</span>
		</div>
		<div class="recruit_type">
			<section class='type1'>
				<img src='http://localhost:9000/br31/images/jobs_title2.gif' alt='BACKINROBBINS'>
				<img src='http://localhost:9000/br31/images/jobs_title3.gif' alt='아르바이트'>
				<img src='http://localhost:9000/br31/images/jobs_img_1.jpg' alt='아르바이트'>
				<p>
				즐거운 일터에서 함께 일하며 경험을 쌓고,<br>
				다양한 혜택이 함께하는  최고의 기회를 누려보세요!<br>
				가맹점 아르바이트는<br>
				아르바이트 포털 사이트에서 모집하고 있습니다.
				</p>
				<a href="http://www.albamon.com/" target="_blank">자세히보기</a>
			</section>
			<section class='type2'>
				<img src='http://localhost:9000/br31/images/jobs_title2.gif' alt='BACKINROBBINS'>
				<img src='http://localhost:9000/br31/images/jobs_title4.gif' alt='사무직'>
				<img src='http://localhost:9000/br31/images/jobs_img_2.jpg' alt='사무직'>
				<p>
				끊임없는 혁신으로 성공을 창조해온 배스킨라빈스!<br>
				이곳에서 당신의 소중한 꿈을 펼쳐보세요!<br>
				배스킨라빈스 사무직은<br>
				비알코리아 사이트를 통해 모집하고 있습니다.
				</p>
				<a href="https://spc.recruiter.co.kr/appsite/company/index" target="_blank">자세히보기</a>
			</section>
		</div>	
	</section>
	
	
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
</body>
</html>