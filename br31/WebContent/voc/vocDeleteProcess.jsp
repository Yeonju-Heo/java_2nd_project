<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.io.*" %>

<%
	String vid = request.getParameter("vid");

	VocDAO dao = new VocDAO();
	String vsfile = dao.getVsfile(vid);
	boolean result = dao.getDeleteResult(vid);
	
 	if(result) {
 		if(vsfile != null) {
 			String savePath = request.getServletContext().getRealPath("/upload");
 			File file = new File(savePath + "/" + vsfile);
 			
 			if(file.exists()) file.delete();
 		}
		response.sendRedirect("voc_list.jsp");
	} else {
		response.sendRedirect("../errorPage.jsp");
	}

%>
