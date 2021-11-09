<%@page import="java.io.File"%>
<%@page import="com.br31.dao.EventDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//
String articleno = request.getParameter("articleno");

EventDAO dao = new EventDAO();
String nsfile = dao.getNsfile(Integer.parseInt(articleno));

boolean result = dao.getDeleteResult(Integer.parseInt(articleno));

if (result) {
	if (nsfile != null) {
		String savePath = request.getServletContext().getRealPath("/upload");
		File file = new File(savePath + "/" + nsfile);
		if (file.exists()) {
			if (file.delete()) {
				System.out.println("파일 삭제 완료~");
			}
		}

	}
}

if (result) {
	response.sendRedirect("event_list.jsp");
}
%>