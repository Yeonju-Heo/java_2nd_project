<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.MemberDAO, com.br31.vo.MemberVO" %>   

<jsp:useBean id = "vo" class = "com.br31.vo.MemberVO"	/>
<jsp:setProperty  name = "vo" property = "*" />  

<% 
	/*MemberVO vo = new MemberVO();

	vo.setId(request.getParameter("id"));
	vo.setPass(request.getParameter("pass"));
	vo.setName(request.getParameter("name"));
	vo.setGender(request.getParameter("gender"));
	vo.setBirth(request.getParameter("birthday"));
	vo.setHp1(request.getParameter("phone1"));
	vo.setHp2(request.getParameter("phone2"));
	vo.setHp3(request.getParameter("phone3"));
	vo.setAddr1(request.getParameter("addr_num"));
	vo.setAddr2(request.getParameter("addr"));
	vo.setEmail1(request.getParameter("email1"));
	vo.setEmail2(request.getParameter("email2"));*/
	
	
	MemberDAO dao = new MemberDAO();
	String card = dao.getNewCard(10);
	System.out.println(card);
	vo.setCard(card);
	System.out.println(vo.getCard());
	boolean result = dao.getJoinResult(vo);
	
	if(result == true){
		response.sendRedirect("joinSuccess.jsp");
		
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