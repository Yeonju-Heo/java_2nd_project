<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.MemberVO, com.br31.dao.MemberDAO"%>
<%
	String id = request.getParameter("id");
	System.out.println(id);

	MemberVO vo = new MemberVO();
	MemberDAO dao = new MemberDAO();
	
	boolean result = dao.getDeleteResult(id);
	
	System.out.println(result);
	
	if(result){	
		response.sendRedirect("http://localhost:9000/br31/member_admin/admin_member.jsp");
	}else{
		response.sendRedirect("http://localhost:9000/br31/error_page.html");
	}
	
%>