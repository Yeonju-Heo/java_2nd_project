<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*" %>    
<%
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO();
	
	vo.setEmail1(request.getParameter("email1"));
	vo.setEmail2(request.getParameter("email2"));
	vo.setName(request.getParameter("name"));
	String type = request.getParameter("type");
	
	System.out.println(vo.getEmail());
	System.out.println(vo.getName());
	System.out.println(type);
	
	boolean result = dao.getIdSearchResult(vo);
	
	String sid = "";
	String pid = "";
	
	if(result){
		sid = dao.getIdSearch(vo);
	}else{
		if(type.equals("id")){
			out.println("<script>alert('입력하신 정보를 확인해주세요');</script>");
			response.sendRedirect("login_phone.jsp");
		}else{
			out.println("<script>alert('입력하신 정보를 확인해주세요');</script>");
			response.sendRedirect("login_ipin.jsp");
		}
		
	} 
	
	pid = sid.replaceAll("[0-9]", "*");
			
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
	
	function searchpass(){
		window.opener.location.href = "http://localhost:9000/br31/login/login_pass_search.jsp";
		close();
	}

</script>
</head>
<body>
	<div class = "sresult">
		<div>
			<span>고객님이 가입하신 아이디는</span>
			<span><%= pid %></span>
			<span>입니다.</span>
		</div>
		<button type = "button" id = "btn_cancle" class = "btn_cancle" onclick = "gologin()">로그인</button>
		<button type = "button" id = "btn_confrim" class = "btn_confrim" onclick = "searchpass()">비밀번호 찾기</button>
	</div>
</body>
</html>