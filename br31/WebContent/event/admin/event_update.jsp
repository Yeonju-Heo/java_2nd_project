<%@page import="com.br31.vo.EventVO"%> 
<%@page import="com.br31.dao.EventDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//

String articleno = request.getParameter("articleno");
String rno = request.getParameter("rno");

EventDAO dao = new EventDAO();

EventVO vo = dao.getContent(Integer.parseInt(articleno));
dao.close();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/admin_br31_m.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	window.onload = function() {
		$("#btn_update").click(function() {
			if ($("#btitle").val() == "") {
				alert("제목을 입력해주세요");
			} else {
				board_update_form.submit();
			}
		});
	}

	$(document).ready(function() {
		$("input[type='file']").on("change", function() {
			if (window.FileReader) {
				var filename = $(this)[0].files[0].name;
				$("#fname").text("").text(filename);
			}
		});
	});
</script>
<style type="text/css">
span#fname {
	width: 150px;
	display: inline-block;
	font-size: 12px;
	margin-left: -385px;
	padding: 2px 0 0 2px;
	background: white;
}
</style>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>

	<!-- content -->
	<div class="content">
		<section class="board_write">
			<h3 class="line_title">
				<span> <img src="../../images/eventtitle.png" alt="event">
				</span> [관리자] 이벤트
			</h3>
			<form name="event_update" action="event_update_process.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" value="<%=vo.getArticleno()%>" name="articleno" id="articleno">
				<table class="content_layout">
					<tr>
						<th>제목</th>
						<td>
							<input type="text" name="title" value="<%=vo.getTitle()%>">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="ncontent"><%=vo.getNcontent()%></textarea>
						</td>
					</tr>
					<tr>
						<th>파일첨부</th>
						<td>
							<%
								if (vo.getNfile() != null) {
								out.print("<input type='file' name='nfile' value='" + vo.getNsfile() + "'> <span id='fname'>" + vo.getNsfile() + "</span>");
							} else {
								out.print("<input type='file' name='nfile' value='" + vo.getNsfile() + "'> <span id='fname'>선택된 파일 없음</span>");
							}
							%>
						</td>
					</tr>
					<tr>
						<th>파일첨부2</th>
						<td>
							<%
								if (vo.getNfile2() != null) {
								out.print("<input type='file' name='nfile2' value='" + vo.getNsfile2() + "'> <span id='fname'>" + vo.getNsfile2() + "</span>");
							} else {
								out.print("<input type='file' name='nfile2' value='" + vo.getNsfile2() + "'> <span id='fname'>선택된 파일 없음</span>");
							}
							%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" class="btn_style2">수정완료</button>
							<button type="reset" class="btn_style2">취소</button>
							<a href="event_content.jsp?articleno=<%=vo.getArticleno()%>&rno=<%=rno%>">
								<button type="button" class="btn_style2">이전 페이지</button>
							</a>
							<a href="event_list.jsp">
								<button type="button" class="btn_style2">목록</button>
							</a>
						</td>
					</tr>
				</table>
			</form>
		</section>
	</div>

	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>
</body>
</html>