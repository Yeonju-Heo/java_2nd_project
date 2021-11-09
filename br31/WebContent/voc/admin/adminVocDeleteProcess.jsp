<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO" %>
<%
	String vid = request.getParameter("vid");

	VocDAO dao = new VocDAO();
	boolean result = dao.getDeleteAnswerResult(vid);
	
	if(result) {
		response.sendRedirect("admin_voc_list.jsp?status=NO");
	} else {
		response.sendRedirect("../errorPage.jsp");
	}
%>

