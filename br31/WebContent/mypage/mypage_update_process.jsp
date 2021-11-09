<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*" %> 
<%-- <jsp:useBean id = "vo" class = "com.br31.vo.MemberVO" 	/>
<jsp:setProperty name = "vo" property = "*"	/>  --%>
<%
	//자바 bean으로 수정하기!

	MemberDAO dao = new MemberDAO();
	
	 MemberVO vo = new MemberVO(); 

	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setBirth(request.getParameter("birth"));
	vo.setHp1(request.getParameter("hp1"));
	vo.setHp2(request.getParameter("hp2"));
	vo.setHp3(request.getParameter("hp3"));
	vo.setAddr1(request.getParameter("addr1"));
	vo.setAddr2(request.getParameter("addr2"));
	vo.setEmail1(request.getParameter("email1"));
	vo.setEmail2(request.getParameter("email2")); 
	
	boolean result = dao.mypageUpdateResult(vo);  
	dao.close();
	
	if(result == true){
		response.sendRedirect("mypage_update.jsp");
		//리스트 페이지로 페이지 이동
	}else{
		response.sendRedirect("http://localhost:9000/br31/error_page.jsp");
	}
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>