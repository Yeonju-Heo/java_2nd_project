<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*" %>    
<%
	 MemberDAO dao = new MemberDAO();
	String pass = dao.getNewPass(7);
	MemberVO vo = new MemberVO();
	
	vo.setEmail1(request.getParameter("email1"));
	vo.setEmail2(request.getParameter("email2"));
	vo.setName(request.getParameter("name"));
	String type = request.getParameter("type");
	
	boolean result2 = dao.getPassUpdate(vo, pass);
	if(result2){
		out.println("<script>alert('임시비밀번호가 발급되었습니다');</script>");
		
		
	}else{
		if(type.equals("id")){
			out.println("<script>alert('입력하신 정보를 확인해주세요');</script>");
			response.sendRedirect("login_phone.jsp");
		}else{
			out.println("<script>alert('입력하신 정보를 확인해주세요');</script>");
			response.sendRedirect("login_ipin.jsp");
		}
		
	} 
	
	dao.close();
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<script>
	function gologin(){
		window.opener.location.href = "http://localhost:9000/br31/login/login.jsp";
		close();
	}
	
	function searchid(){
		window.opener.location.href = "http://localhost:9000/br31/login/login_id_search.jsp";
		close();
	}

</script>
</head>
<body>
	<div class = "spresult">
		<div>
			<span>고객님의 임시 비밀번호</span>
			<span><%=pass%></span>
			<span>로그인 후 새로운 비밀번호로 변경해주세요.</span>
		</div>
		<button type = "button" id = "btn_cancle" class = "btn_cancle" onclick = "gologin()">로그인</button>
		<a href = "http://localhost:9000/br31/login/login_id_search.jsp"><button type = "button" id = "btn_confrim" class = "btn_confrim" onclick = "searchid()">아이디 찾기</button></a>
	</div>	
</body>
</html>