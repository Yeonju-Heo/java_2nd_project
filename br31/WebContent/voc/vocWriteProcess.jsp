<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>

<%
	String savePath = request.getServletContext().getRealPath("/upload");
	int sizeLimit = 1024*1024*15;
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

	VocVO vo = new VocVO();
	vo.setQtype(multi.getParameter("qtype"));
	vo.setCtype(multi.getParameter("ctype"));
	vo.setTitle(multi.getParameter("title"));
	vo.setContent(multi.getParameter("content"));
	vo.setVfile(multi.getOriginalFileName("vfile"));
	vo.setVsfile(multi.getFilesystemName("vfile"));
	vo.setName(multi.getParameter("name"));
	vo.setEmail(multi.getParameter("emailId")+"@"+multi.getParameter("emailAddr"));
	vo.setHp(multi.getParameter("hp1")+"-"+multi.getParameter("hp2")+"-"+multi.getParameter("hp3"));
	vo.setId(multi.getParameter("id"));

	VocDAO dao = new VocDAO();
	boolean result = dao.getInsertResult(vo);
	if(result) response.sendRedirect("voc_list.jsp");
	
%>