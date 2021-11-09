<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.io.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%
	String savePath = request.getServletContext().getRealPath("/upload");
	int sizeLimit = 1024*1024*15;
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

	VocVO vo = new VocVO();
	VocDAO dao = new VocDAO();
	
	boolean result = false;

	vo.setVid(multi.getParameter("vid"));
	vo.setQtype(multi.getParameter("qtype"));
	vo.setCtype(multi.getParameter("ctype"));
	vo.setTitle(multi.getParameter("title"));
	vo.setContent(multi.getParameter("content"));
	vo.setName(multi.getParameter("name"));
	vo.setEmail(multi.getParameter("emailId")+"@"+multi.getParameter("emailAddr"));
	vo.setHp(multi.getParameter("hp1")+"-"+multi.getParameter("hp2")+"-"+multi.getParameter("hp3"));
	
 	if(multi.getOriginalFileName("vfile") != null) {
		vo.setVfile(multi.getOriginalFileName("vfile"));
		vo.setVsfile(multi.getFilesystemName("vfile"));
		
		result = dao.getUpdateResult(vo);
		
		if(result) {
			File old_file = new File(savePath+ "/" +multi.getParameter("vsfile_old"));
			if(old_file.exists()) old_file.delete();
		}
		
	} else {
		result = dao.getUpdateResultNoFile(vo);		
	}
	
	
/* 	if(multi.getOriginalFileName("vfile") != null) {
		vo = new VocVO();
		vo.setVid(multi.getParameter("vid"));
		vo.setQtype(multi.getParameter("qtype"));
		vo.setCtype(multi.getParameter("ctype"));
		vo.setTitle(multi.getParameter("title"));
		vo.setContent(multi.getParameter("content"));
		vo.setVfile(multi.getOriginalFileName("vfile"));
		vo.setVsfile(multi.getFilesystemName("vfile"));
		vo.setName(multi.getParameter("name"));
		vo.setEmail(multi.getParameter("emailId")+"@"+multi.getParameter("emailAddr"));
		if(multi.getParameter("hp1").equals(null) && multi.getParameter("hp2").equals(null) && multi.getParameter("hp3").equals(null)) {
			vo.setHp(multi.getParameter("hp1")+"-"+multi.getParameter("hp2")+"-"+multi.getParameter("hp3"));
		} else {
			vo.setHp(null);
		}
		VocDAO dao = new VocDAO();
		result = dao.getUpdateResult(vo);
		if(result) {
			File old_file = new File(savePath+"/"+multi.getParameter("vsfile_old"));
			if(old_file.exists()) {
				old_file.delete();
			}
		}
		
	} else {
		vo = new VocVO();
		vo.setVid(multi.getParameter("vid"));
		vo.setQtype(multi.getParameter("qtype"));
		vo.setCtype(multi.getParameter("ctype"));
		vo.setTitle(multi.getParameter("title"));
		vo.setContent(multi.getParameter("content"));
		vo.setName(multi.getParameter("name"));
		vo.setEmail(multi.getParameter("emailId")+"@"+multi.getParameter("emailAddr"));
		if(multi.getParameter("hp1").equals(null) && multi.getParameter("hp2").equals(null) && multi.getParameter("hp3").equals(null)) {
			vo.setHp(multi.getParameter("hp1")+"-"+multi.getParameter("hp2")+"-"+multi.getParameter("hp3"));
		} else {
			vo.setHp(null);
		}
		VocDAO dao = new VocDAO();
		result = dao.getUpdateResultNoFile(vo);		
	} */
	
	
	if(result) response.sendRedirect("voc_list.jsp");
	
%>