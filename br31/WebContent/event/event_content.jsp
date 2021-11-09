<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.br31.dao.EventDAO"%>
<%@page import="com.br31.vo.EventVO"%>
<%
	//

String articleno = request.getParameter("articleno");
String rno = request.getParameter("rno");

EventDAO dao = new EventDAO();

EventVO vo = dao.getContent(Integer.parseInt(articleno));
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
<body id="br_event">
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
		
	<!-- content -->
	<article id="wrap" class="br_event_view">
	<div id="content">
		<div class="inner_content">
			<div class="event_view_wrap">
				<h3 class="event_title">
									<span><img src="../images/ico_store_event.gif" alt=""></span>
					<span class="txt"><img src="../images/tit_store_event.gif" alt="store event"></span>
					매장 이벤트
								</h3>
				<header class="event_view_header">
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
				<div class="event_view_content">
					<p><img src="http://localhost:9000/br31/upload/<%=vo.getNfile2() %>"><br style="clear:both;">&nbsp;</p>				</div>

				<div class="event_view_alert">
				<%=content==null?"":content %>
					</div>

				<div class="event_view_btn">
					<a href="event_list.jsp">목록</a>
				</div>
			</div>
		</div>
		<nav class="page_prevnext page_prevnext2" style="top: 1817px;">
			<ul>
											</ul>
		</nav>
	</div>
	</article>
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>