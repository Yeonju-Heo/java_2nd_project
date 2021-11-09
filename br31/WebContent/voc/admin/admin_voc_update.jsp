<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.*" %>
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
		$("#btnAnswerUpdate").click(function() {
			if($("#voc_answer").val()=="") {
				alert("답변을 입력해주세요.");
				$("#voc_answer").focus();
				return false;
			} else {
				voc_update_form.submit();
			}
		});

		$("#voc_image").click(function() {
			var width = this.naturalWidth;
			var height = this.naturalHeight;
			var left = ($(window).scrollLeft() + ($(window).width() - width) / 2);
	        
			var option = "width=" + this.naturalWidth + ", height=" + this.naturalHeight + ", top=200, left=" + left;
			window.open($(this).attr("src"), "image", option);
		});
		
		$("#btnGoBack").click(function() {
			window.history.back();
		});
	});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>
	<jsp:include page="admin_cs_header.jsp"></jsp:include>
	
	<div class="cs_content">
		<section class="voc_content">
			<h3>고객 접수 문의</h3>
			<form name="voc_update_form" action="adminVocWriteProcess.jsp" method="post">
			<input type="hidden" name="vid" value="<%=vo.getVid() %>">
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
							<td colspan=6><%= vo.getContent() %>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<% if(vo.getVsfile() != null) { %>
								<td colspan=5><img src="http://localhost:9000/br31/upload/<%= vo.getVsfile() %>" id="voc_image"></td>
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
							<td>
								<textarea class="voc_answer" name="answer"><%= vo.getAnswer().replace("<br>", "\r\n") %></textarea>
							</td>
						</tr>
					</table>
				</div>
				<div class="btn_area">
					<div class="area_left">
						<button type="button" id="btnGoBack">목록</button>
					</div>
					<div class="area_right">
						<button type="button" id="btnAnswerUpdate">답변수정</button>
					</div>
				</div>
			</form>
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