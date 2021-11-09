<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO) session.getAttribute("svo");
	if(svo != null && svo.getId().equals("admin")) {
		String vid = request.getParameter("vid");	
		VocDAO dao = new VocDAO();
		VocVO vo = dao.getContent(vid);
		
		String content = vo.getContent().replace("\r\n", "<br>");
		String answer = vo.getAnswer().replace("\r\n", "<br>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 문의</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
	$("#btnAnswerDelete").click(function() {
		var con = confirm("답변을 삭제하시겠습니까?");
		if(con) {
			$(location).attr("href", "adminVocDeleteProcess.jsp?vid=<%=vo.getVid()%>");
		}
	});
	
	$("#voc_image").click(function() {
		var width = this.naturalWidth;
		var height = this.naturalHeight;
		var left = ($(window).scrollLeft() + ($(window).width() - width) / 2);
        
		var option = "width=" + this.naturalWidth + ", height=" + this.naturalHeight + ", top=200, left=" + left;
		window.open($(this).attr("src"), "image", option);
	});
});

</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>
	<jsp:include page="admin_cs_header.jsp"></jsp:include>
	
	<!-- content -->
	<div class="cs_content">
		<section class="voc_content">
			<h3>[관리자] 고객 1:1 문의</h3>
			<div class="voc_content_detail">
				<div class="details">
					<span>※ 답변은 자세하고 정확하게 작성해주시기 바랍니다.</span>
					<table>
						<tr>
							<th colspan=6>문   의   내   용</th>
						</tr>
						<tr>
							<th>상담유형</th>
							<td colspan=2><%= vo.getQtype() %></td>
							<th>내용유형</th>
							<td colspan=2><%= vo.getCtype() %></td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan=5><%= vo.getTitle() %></td>
						</tr>
						<tr>
							<th>작성일</th>
							<td colspan=5><%= vo.getVdate() %></td>
						</tr>
						<tr>
							<th>내용</th>
							<td colspan=6><%= content %></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<% if(vo.getVsfile() != null) { %>
								<td colspan=5><img src="http://localhost:9000/br31/upload/<%= vo.getVsfile() %>" height="150px" id="voc_image"></td>
							<% } else { %>
								<td colspan=5>없음 </td>
							<% } %>
						</tr>
						<tr>
							<th>이름</th>
							<td><%= vo.getName() %></td>
							<th>이메일</th>
							<td><%= vo.getEmail() %></td>
							<th>전화번호</th>
							<% if(!vo.getHp().equals("--")) { %>
								<td><%= vo.getHp() %></td>
							<% } else { %>
								<td>미입력</td>
							<% } %>
						</tr>
					</table>
				</div>
				<div class="answer">
					<table>
						<tr>
							<th>문   의   답   변</th>
						</tr>
						<tr>
							<td><%= answer %></td>
						</tr>
					</table>
				</div>
				<div class="btn_area">
					<div class="area_left">
						<a href="http://localhost:9000/br31/voc/admin/admin_voc_list.jsp?status=NO"><button type="button">목록</button></a>
					</div>
					<div class="area_right">
						<a href="http://localhost:9000/br31/voc/admin/admin_voc_update.jsp?vid=<%=vo.getVid()%>"><button type="button">답변수정</button></a>
						<a><button type="button" id="btnAnswerDelete">답변삭제</button></a>
					</div>
				</div>
			</div>
		</section>	
	</div>
	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>

</body>
</html>
<%	} else {%>
	<script>
		alert("접근 권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<%	} %>