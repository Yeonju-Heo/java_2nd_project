<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.FaqDAO, com.br31.vo.FaqVO, java.io.*" %>

<%
	String fid = request.getParameter("fid");

	FaqDAO dao = new FaqDAO();
	String fsfile = dao.getFsfile(fid);
	boolean result = dao.getDeleteResult(fid);

	if(result) {
		if(fsfile != null) {
			String savePath = request.getServletContext().getRealPath("/upload");
			File file = new File(savePath + "/" + fsfile);
			if(file.exists()) file.delete();
		}
		response.sendRedirect("admin_faq_list.jsp");
	} else {
		response.sendRedirect("../../error_page.html");
	}
	
%>
