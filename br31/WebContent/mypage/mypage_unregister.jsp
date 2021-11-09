<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.SessionVO" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){	
		
%>        
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
		<section class = "m_menu">
			<nav>
			<img src = "http://localhost:9000/br31/images/mybr.PNG">
			<h4>회원님을 위한 배스킨라빈스의 다양한 정보</h4>
				<ul>
					<a href = "mypage.jsp"><img src = "http://localhost:9000/br31/images/1st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/1st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/1st_mypage.PNG'"></a>
					<a href = "mypage_f_shop.jsp"><img src = "http://localhost:9000/br31/images/2st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/2st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/2st_mypage.PNG'"></a>
					<a href = "mypage_f_flavor.jsp"><img src = "http://localhost:9000/br31/images/3st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/3st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/3st_mypage.PNG'"></a>
					<a href = "mypage_update.jsp"><img src = "http://localhost:9000/br31/images/4st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/4st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/4st_mypage.PNG'"></a>
					<a href = "mypage_unregister.jsp"><img src = "http://localhost:9000/br31/images/5st_mypage_onclick.PNG"></a>
				</ul>
			</nav>
		</section>
		<section class = "m4_page">
			<img src = "">
			<span>정말로 탈퇴하시겠습니까?</span>
			<div>
				<a href = "http://localhost:9000/br31/mypage/mypage.jsp"><button type = "button" name = "unregister" class = "btn_cancle">취소</button></a>
				<a href = "http://localhost:9000/br31/mypage/userDeleteUpdateProcess.jsp?id=<%=svo.getId()%>"><button type = "button" name = "unregister" class = "btn_confrim">탈퇴하기</button></a>
			</div>
		</section>
		
	</div>
	<!-- content -->
	
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