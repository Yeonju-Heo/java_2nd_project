<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.*,com.br31.vo.*, java.util.*,java.io.*" %>


<%

String category = request.getParameter("category");
String status = request.getParameter("status");
String pname = request.getParameter("pname");
MenuDAO dao = new MenuDAO();
MenuVO vo = dao.getAdminContent(pname);
String psfile = vo.getPsfile();
boolean result = dao.getDeleteResult(pname);
dao.close();
if(result){
	if(psfile!=null){
		
	  String savePath = request.getServletContext().getRealPath("/menu/images");
	  
	  File file = new File(savePath+"/"+psfile);
	  if(file.exists()){
		  file.delete();
	  }
	}
 }


if(result){
	status="after";
	response.sendRedirect("admin_menu_delete.jsp?category="+category+"&status="+status);
 }else if(result==false){
	 
 }
 
%>