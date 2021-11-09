 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null) {
		
		String vid = request.getParameter("vid");
		VocDAO dao = new VocDAO();
		VocVO vo = dao.getContent(vid);
		
		if(svo.getId().equals(vo.getId())) {
		
		String content = vo.getContent().replace("\r\n", "<br>");
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
		
		$("#voc_image").click(function() {
			var width = this.naturalWidth;
			var height = this.naturalHeight;
			var left = ($(window).scrollLeft() + ($(window).width() - width) / 2);
	        
			var option = "width=" + this.naturalWidth + ", height=" + this.naturalHeight + ", top=200, left=" + left;
			window.open($(this).attr("src"), "image", option);
		});
		
		$("#btnVocDelete").click(function() {
			var con = confirm("문의를 삭제하시겠습니까?");
			if(con) {
				$(location).attr("href", "vocDeleteProcess.jsp?vid=<%=vo.getVid()%>");
			}
		});
		
		$("#btnGoBack").click(function() {
			window.history.back();
		});
				
	});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="cs_header.jsp"></jsp:include>
	
	<!-- content -->
	<div class="cs_content">
		<section class="voc_content">
			<h3>1:1 문의 내용</h3>
			<div class="voc_content_detail">
				<div class="details">
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
							<td colspan=6><%= content %>
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
							<% if(vo.getAnswer() != null && !vo.getAnswer().equals("NULL")) { %>
								<td><%= vo.getAnswer().replace("\r\n", "<br>") %></td>
							<% } else { %>
								<td style="color:red"> ※ 답변 대기 중인 문의입니다. </td>
							<% } %>
						</tr>
					</table>
				</div>
				<div class="btn_area">
					<div class="area_left">
						<button type="button" id="btnGoBack">목록</button>
					</div>
					<div class="area_right">
						<a href="http://localhost:9000/br31/voc/voc_update.jsp?vid=<%=vo.getVid()%>"><button type="button" id="btnVocUpdate">수정</button></a>
						<button type="button" id="btnVocDelete">삭제</button>
					</div>
				</div>
			</div>
		</section>	
	</div>
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
<%		} else { %>
			<script>
				window.alert("접근 권한이 없습니다.");
				location.href = "http://localhost:9000/br31/index.jsp";	
			</script>
<% 		}
	}else{ %>
		<script>
			window.alert("로그인 후 사용 가능합니다.");
			location.href = "http://localhost:9000/br31/login/login.jsp";
		</script>
<%	} %>