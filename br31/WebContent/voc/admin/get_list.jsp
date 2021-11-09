<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.util.ArrayList, com.google.gson.*" %>
<%
	VocDAO dao = new VocDAO();

	String qtype = request.getParameter("qtype");
	String ctype = request.getParameter("ctype");
	String status = request.getParameter("status");
	int start = Integer.parseInt(request.getParameter("start"));
	int end = Integer.parseInt(request.getParameter("end"));
	
	ArrayList<VocVO> list = dao.getList(qtype, ctype, start, end, status);
	
	JsonObject jdata = new JsonObject();
	JsonArray jlist = new JsonArray();
	Gson gson = new Gson();
	
	for(VocVO vo : list) {
		JsonObject jobj = new JsonObject();
		jobj.addProperty("vid", vo.getVid());
		jobj.addProperty("rno", vo.getRno());
		jobj.addProperty("qtype", vo.getQtype());
		jobj.addProperty("ctype", vo.getCtype());
		jobj.addProperty("title", vo.getTitle());
		jobj.addProperty("vdate", vo.getVdate());
		jobj.addProperty("status", vo.getStatus());
		if(vo.getStatus().equals("답변대기")) {
			jobj.addProperty("link", "http://localhost:9000/br31/voc/admin/admin_voc_write.jsp?vid="+vo.getVid());
		} else {
			jobj.addProperty("link", "http://localhost:9000/br31/voc/admin/admin_voc_content.jsp?vid="+vo.getVid());
		}
		
		jlist.add(jobj);
	}
	
	jdata.add("jlist", jlist);
	out.write(gson.toJson(jdata));
	
	
	

	

	
%> 