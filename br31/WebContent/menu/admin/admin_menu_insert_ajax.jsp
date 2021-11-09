<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.br31.dao.*,com.br31.vo.*,java.util.*,com.google.gson.*" %>
<%
	String pname = request.getParameter("pname");
	MenuDAO dao = new MenuDAO();
	boolean p_check = dao.getPnameCheck(pname);
	dao.close();
	JsonObject jdata = new JsonObject();
	Gson gson = new Gson();
	jdata.addProperty("p_check",p_check);
	
	out.write(gson.toJson(jdata));
%>