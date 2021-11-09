<%@page import="com.br31.dao.NoticeDAO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//

String articleno = request.getParameter("articleno");
String rno = request.getParameter("rno");

NoticeDAO dao = new NoticeDAO();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/admin_br31_m.css">
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>

	<!-- content -->
	<div class="content">
		<section class="notice_delete">
			<h3 class="line_title">
			<span> <img
				src="http://localhost:9000/br31/images/h_notice.png" alt="NOTICE">
			</span> [관리자] 공지사항
			</h3>
				<div class="content_layout">
				<h3>정말로 삭제하시겠습니까?</h3>
				<div>
					<a href="notice_delete_process.jsp?articleno=<%=articleno%>">
						<button type="button" class="btn_style2">삭제완료</button>
					</a>
					<a href="notice_content.jsp?articleno<%=articleno%>&rno=<%=rno%>">
						<button type="button" class="btn_style2">이전 페이지</button>
					</a>
					<a href="notice_list.jsp">
						<button type="button" class="btn_style2">목록</button>
					</a>
				</div>
			</div>
		</section>
	</div>

	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>
</body>
</html>