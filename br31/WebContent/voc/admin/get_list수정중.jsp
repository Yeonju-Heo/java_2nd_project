<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.util.*, com.google.gson.*" %>
<%
	VocDAO dao = new VocDAO();

	String qtype = request.getParameter("qtype");
	String ctype = request.getParameter("ctype");
	String status = request.getParameter("status");
	
	/****** 페이징 처리 */
	String rpage = request.getParameter("rpage");
	
 	System.out.println("*(**************)");
	System.out.println("페이지번호>>>"+rpage);
	
	int startCount = 0;
	int endCount = 0;
	int pageSize = 10;	
	int reqPage = 1;	
	int pageCount = 1;	
	int dbCount = dao.execTotalCount(qtype, ctype, status);
	
	if(dbCount % pageSize == 0){
		pageCount = dbCount/pageSize;
	}else{
		pageCount = dbCount/pageSize + 1;
	}
	
 	if(!rpage.equals("null")){
		reqPage = Integer.parseInt(rpage);
		startCount = (reqPage - 1) * pageSize + 1;
		endCount = reqPage *pageSize;
	}else{
		startCount = 1;
		endCount = 10;
	}
	/* 페이징 처리 ******/
	
	
	ArrayList<VocVO> list = dao.getList(qtype, ctype, startCount, endCount, status);
	
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
	jdata.addProperty("dbCount", dbCount);
	jdata.addProperty("pageSize", pageSize);
	jdata.addProperty("rPage", reqPage);
	out.write(gson.toJson(jdata));
	
	
	/*******************************************/
	

 	System.out.println("startCount >>>" + startCount);
 	System.out.println("endCount >>>" + endCount);
 	System.out.println("qtype >>>" + qtype);
 	System.out.println("ctype >>>" + ctype);
 	System.out.println("status >>>" + status);
 	System.out.println("pageSize >>>" + pageSize);
 	System.out.println("rPage >>>" + reqPage);
 	System.out.println("jdata >>>" + jdata);
 	

	
	

	
%> 



