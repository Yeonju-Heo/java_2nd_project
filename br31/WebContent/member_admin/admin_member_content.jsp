<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.*, com.br31.vo.*, java.util.*, com.br31.vo.SessionVO" %>
<%
	MemberDAO dao = new MemberDAO();
	
	String id = request.getParameter("id");
	String rno = request.getParameter("rno");
	
	MemberVO vo = dao.getMemberContent(id); 
	dao.close();
	
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
		if(svo.getId().equals("admin")){
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://localhost:9000/myweb2/js/jquery-3.6.0.min.js"></script>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">

</head>
<body>
	<div class = "member_content">
		<!-- header -->
		<jsp:include page = "../admin_header.jsp"></jsp:include>
		
		<section class = "ad_m_header">
			<div class = "member_title">
				<div>
					<img src = "http://localhost:9000/br31/images/spoon_left.PNG" class = "spoon_img">
					<h1>회원 정보</h1>
					<img src = "http://localhost:9000/br31/images/spoon_right.PNG" class = "spoon_img">
				</div>
			</div>
		</section>
		<!-- content -->
		<section class = "member_content">
			<table class = "m_content_table">
				<tr>
					<th>번호</th>
					<td><%= rno %></td>
					<th>이름</th>
					<td><%= vo.getName() %></td>
					<th>성별</th>
					<td><%= vo.getGender() %></td>
					<th>나이</th>
					<td><%= vo.getBirth() %></td>
					<th>포인트</th>
					<td><%= vo.getPoint() %></td>
					<th>가입일</th>
					<td><%= vo.getMdate() %></td>
				</tr>
				<tr>
					<th>휴대전화 번호</th>
					<td colspan = "11"><%= vo.getHp() %></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan = "11"><%= vo.getEmail() %></td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan = "11"><%= vo.getAddr() %></td>
				</tr>
				<tr class = "admintable_btn">
					<td colspan = "12">
						<% if(vo.getChoice() == 1){ %>
						<button type = 'button' class = 'btn_confrim' >회원탈퇴</button>
						<% }else{ %> 
						<button type = 'button' class = 'btn_confrim2' disabled>회원탈퇴</button>
						<% } %>
						<a href = "http://localhost:9000/br31/member_admin/admin_member.jsp"><button type = "button" class = "btn_cancle">이전으로</button></a>
					</td>
				</tr>
			</table>		
		</section>
	</div>
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