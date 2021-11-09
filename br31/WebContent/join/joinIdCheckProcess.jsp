<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.MemberDAO, com.br31.vo.MemberVO" %>    
<%
	String id = request.getParameter("id");
	//System.out.println("id>>>" + id);
	
	MemberDAO dao = new MemberDAO();
	int result = dao.idCheck(id);
	//System.out.print(result);
	//dao.close();
	
	out.write(String.valueOf(result));
%>
