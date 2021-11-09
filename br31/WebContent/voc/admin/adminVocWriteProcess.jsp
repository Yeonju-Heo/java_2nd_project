<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.util.*" %>
<%
	String vid = request.getParameter("vid");
	String answer = request.getParameter("answer");

	VocDAO dao = new VocDAO();
	VocVO vo = dao.getContent(vid);
	boolean result = dao.getInsertResult(vid, answer);
	
	if(result) {
		response.sendRedirect("admin_voc_content.jsp?vid="+vid);
	} else {
		response.sendRedirect("../errorPage.jsp");
	}
%>