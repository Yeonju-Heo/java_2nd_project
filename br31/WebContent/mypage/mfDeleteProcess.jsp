<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*" %> 
<%
	String id = request.getParameter("id");
	String pname = request.getParameter("pname");
	
	MypageDAO dao = new MypageDAO();
	int result = dao.getmfDeleteResult(id, pname);
	 
	out.write(String.valueOf(result));
%>