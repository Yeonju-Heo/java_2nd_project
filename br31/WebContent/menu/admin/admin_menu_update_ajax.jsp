<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.br31.dao.*,com.br31.vo.*,java.util.*,com.google.gson.*" %>
<%
	String pname = request.getParameter("pname");
	MenuDAO dao = new MenuDAO();
	MenuVO vo = dao.getAdminContent(pname);
	dao.close();
	
	String rec_text = "";
	String hash_text = "";
	String al_text = "";
	if(vo!=null){
		if(vo.getRec_flavor()!=null){
			for(int i=0;i<vo.getRec_flavor().length;i++) {
				if(i==vo.getRec_flavor().length-1) {
					rec_text += vo.getRec_flavor()[i];
				}else {
					rec_text += vo.getRec_flavor()[i]+",";
				}
			}
		}
		
		if(vo.getHashtag()!=null){
			for(int i=0;i<vo.getHashtag().length;i++) {
				if(i==vo.getHashtag().length-1) {
					hash_text += vo.getHashtag()[i];
				}else {
					hash_text += vo.getHashtag()[i]+",";
				}
			}
		}
		
		if(vo.getAllergy()!=null){
			for(int i=0;i<vo.getAllergy().length;i++) {
				if(i==vo.getAllergy().length-1) {
					al_text += vo.getAllergy()[i];
				}else {
					al_text += vo.getAllergy()[i]+",";
				}
			}
		}
	}
	
	
	JsonObject jobj = new JsonObject();
	Gson gson = new Gson();
	jobj.addProperty("pname",vo.getPname());
	jobj.addProperty("eng_pname",vo.getEng_pname());
	jobj.addProperty("intro",vo.getIntro());
	jobj.addProperty("order_type",vo.getOrder_type());
	jobj.addProperty("rec_flavor", rec_text);
	jobj.addProperty("hashtag", hash_text);
	jobj.addProperty("pfile", vo.getPfile());
	jobj.addProperty("psfile", vo.getPsfile());
	jobj.addProperty("one_amount", vo.getOne_amount());
	jobj.addProperty("kcal", vo.getKcal());
	jobj.addProperty("natrium",vo.getNatrium());
	jobj.addProperty("sugar", vo.getSugar());
	jobj.addProperty("fat", vo.getFat());
	jobj.addProperty("protein", vo.getProtein());
	jobj.addProperty("caffeine", vo.getCaffeine());
	jobj.addProperty("allergy", al_text);
	
	out.write(gson.toJson(jobj));
%>