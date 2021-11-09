<%@page import="com.br31.vo.NoticeVO"%> 
<%@page import="com.br31.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//

String articleno = request.getParameter("articleno");
String rno = request.getParameter("rno");

NoticeDAO dao = new NoticeDAO();

NoticeVO vo = dao.getContent(Integer.parseInt(articleno));
String content = null;
if (vo != null && vo.getNcontent()!=null) {
	content = vo.getNcontent().replaceAll("\n", "<br>");
}
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
		<section class="notice_content">
			<h3 class="line_title">
			<span> <img
				src="http://localhost:9000/br31/images/h_notice.png" alt="NOTICE">
			</span> [관리자] 공지사항
			</h3>
			<table class="content_layout">
				<tr>
					<th>번호</th>
					<td><%=rno%></td>
					<th>날짜</th>
					<td><%=vo.getMdate()%></td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="5"><%=vo.getTitle()%></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="5">
						<%
							if (vo.getNsfile() != null) {
							out.write("<img alt='' src='http://localhost:9000/br31/upload/" + vo.getNsfile() + "'> ");
						}
						%>
						<br>
						<%=content==null?"":content %>
					</td>
				</tr>
				<tr>
					<td colspan="6">
						<a href="notice_update.jsp?articleno=<%=vo.getArticleno()%>&rno=<%=rno%>">
							<button type="button" class="btn_style2">수정</button>
						</a>
						<a href="notice_delete.jsp?articleno=<%=vo.getArticleno()%>&rno=<%=rno%>">
							<button type="button" class="btn_style2">삭제</button>
						</a>
						<a href="notice_list.jsp">
							<button type="button" class="btn_style2">목록</button>
						</a>
						<a href="http://localhost:9000/br31/adminIndex.jsp">
							<button type="button" class="btn_style2">홈으로</button>
						</a>
					</td>
				</tr>
			</table>
		</section>
	</div>
 
	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>
</body>
</html>