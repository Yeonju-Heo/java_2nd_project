<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.FaqDAO, com.br31.vo.FaqVO, java.io.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%
	String savePath = request.getServletContext().getRealPath("/upload");
	int sizeLimit = 1024 * 1024 * 15;
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());
	
	FaqVO vo = new FaqVO();
	FaqDAO dao = new FaqDAO();
	
	boolean result = false;
	
	vo.setFid(multi.getParameter("fid"));
	vo.setTitle(multi.getParameter("title"));
	vo.setContent(multi.getParameter("content"));
	vo.setFtype(multi.getParameter("ftype"));
	
	if(multi.getOriginalFileName("ffile") != null) {
		vo.setFfile(multi.getOriginalFileName("ffile"));
		vo.setFsfile(multi.getFilesystemName("ffile"));
	
		result = dao.getUpdateResult(vo);
	
		if(result) {
			File file = new File(savePath + "/" + multi.getParameter("fsfile_old"));
			if (file.exists()) file.delete();
		}
	
	} else {
		result = dao.getUpdateResultNoFile(vo);
	}

	if(result) {
		response.sendRedirect("admin_faq_list.jsp");
	} else {
		response.sendRedirect("../errorPage.jsp");
	}
%>