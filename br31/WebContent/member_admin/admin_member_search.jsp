<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*, java.util.ArrayList, com.google.gson.*" %>        
<%
	String category = request.getParameter("category");
	String sname = request.getParameter("sname");
	
	MemberDAO dao = new MemberDAO();
	ArrayList<MemberVO> list = dao.getList(category, sname);
	
	//자바의 list 객체의 데이터를 JSON 객체로 변환 후 전송
	//JSON 객체 형태로 변환해주는 라이브러리 ----> GSON
	//최종 전송 데이터 타입 var jdata = {"jlist" : [{"rno":1, "empno":7369,"ename":"SMITH"},{...}]  };
	JsonObject jdata = new JsonObject();
	JsonArray jlist = new JsonArray();
	Gson gson = new Gson();
	
	for(MemberVO vo : list){
		JsonObject jobj = new JsonObject();
		jobj.addProperty("rno", vo.getRno());
		jobj.addProperty("id", vo.getId());
		jobj.addProperty("name", vo.getName());
		jobj.addProperty("birth", vo.getBirth());
		jobj.addProperty("hp", vo.getHp());
		jobj.addProperty("addr", vo.getAddr());
		jobj.addProperty("email", vo.getEmail());
		jobj.addProperty("point", vo.getPoint());
		jobj.addProperty("mdate", vo.getMdate());
		jobj.addProperty("choice", vo.getChoice());
		
		jlist.add(jobj);
	}
	
	jdata.add("jlist", jlist);
	
	out.write(gson.toJson(jdata));
%>    
