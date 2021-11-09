<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.MemberDAO, com.br31.vo.SessionVO, com.br31.vo.MemberVO" %>
<jsp:useBean id = "vo" class = "com.br31.vo.MemberVO"	/>
<jsp:setProperty name = "vo" property = "*"	/>    
<% 
	MemberDAO dao = new MemberDAO();
	SessionVO svo = dao.getLoginResult(vo);
	
	if(svo.getResult() == 1){
		svo.setId(vo.getId());
		session.setAttribute("svo", svo);
		response.sendRedirect("http://localhost:9000/br31/index.jsp");
	}else{
		response.sendRedirect("http://localhost:9000/br31/login/loginFail.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>