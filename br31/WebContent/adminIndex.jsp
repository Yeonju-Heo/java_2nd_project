<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.*, com.br31.vo.*, java.util.*,com.br31.vo.SessionVO" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
		if(svo.getId().equals("admin")){
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://localhost:9000/myweb2/js/jquery-3.6.0.min.js"></script>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<body>
	<!-- header -->
	<jsp:include page = "admin_header.jsp"></jsp:include>
	
	<!-- content -->
	<div class = "adIndex_content">
		<h1>관리자님 환영합니다.</h1>
		<span>상단 메뉴를 통해 해당 페이지로 이동할 수 있습니다.</span>
		<a href = "http://localhost:9000/br31/index.jsp"><button>배스킨 라빈스 홈페이지로 돌아가기</button></a>
	</div>
	<!-- footer -->
	<!-- <div class = "adIndex_footer">
		<span>Copyright ⓒ 2016 BRKOREA Company. All Rights Reserved.</span>
	</div> -->
	
</body>
</html>
<% }else{%>
	<script>
		window.alert("접근권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<% } %>
<% }else{%>
	<script>
		window.alert("로그인후 사용이 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %>