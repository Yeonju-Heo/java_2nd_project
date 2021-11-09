<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.MemberVO, com.br31.dao.MemberDAO" %>    
<%
	String id = request.getParameter("id");

	MemberDAO dao = new MemberDAO();
	boolean result = dao.userDeleteUpdate(id);
	
	dao.close();
	
	System.out.println(result);
	
	if(result){	
		session.invalidate();
		response.sendRedirect("http://localhost:9000/br31/mypage/userUpdateLoading.jsp");
	}else{
		response.sendRedirect("http://localhost:9000/br31/error_page.html");
	}
%>