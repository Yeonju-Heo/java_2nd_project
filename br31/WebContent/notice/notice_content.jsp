<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.br31.dao.NoticeDAO"%>
<%@page import="com.br31.vo.NoticeVO"%>
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
<link rel="stylesheet" href="http://localhost:9000/br31/css/br31.css">
</head>
<body id="br_about">
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>

	<!-- content -->
		
	<div id="content">
		<div class="inner_content">
			<div class="board_view_wrap">
				<h3 class="board_title">
					<span><img src="../images/ico_notice_view.gif" alt=""></span>
					<span class="txt"><img src="../images/tit_notice_view.gif" alt="br notice"></span>
					공지사항
				</h3>
			</div>
			<header class="board_view_header">
				<h4 class="name"><%=vo.getTitle()%></h4>
				<div class="subtit">
					<p class="period"><%=vo.getMdate()%></p>
					<nav class="sns">
						<ul>
							<li>
								<a href="#none" role="button" data-sns="facebook">
									<img src="../images/icon_facebook.png" alt="FACEBOOK">
								</a>
							</li>
							<li>
								<a href="#none" role="button" data-sns="twitter">
									<img src="../images/icon_twitter.png" alt="TWITTER">
								</a>
							</li>
							<li>
								<a href="#none" role="button" data-sns="copyurl">
									<img src="../images/icon_copy.png" alt="copy">
								</a>
							</li>
						</ul>
					</nav>
				</div>
			</header>
			<div class="borad_file">
							</div>
			<div class="board_view_content" style="">
				<p style="text-align: left;" align="left"><img src="http://localhost:9000/br31/upload/<%=vo.getNfile() %>" ></p><%=content==null?"":content %>
                            </div>

            			<div class="board_view_btn">
				<a href="notice_list.jsp">목록</a>
			</div>
		</div>

	</div>
	
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>