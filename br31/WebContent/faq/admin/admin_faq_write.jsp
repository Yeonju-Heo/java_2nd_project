<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.vo.*" %>
<%
	SessionVO svo = (SessionVO) session.getAttribute("svo");
	if(svo != null && svo.getId().equals("admin")) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>	
	$(document).ready(function() {
		$("#btnFaqSave").click(function() {
			if($("input[name='ftype']:checked").length == 0) {
				alert("유형을 선택해주세요.");
				$("input[name='ftype']:eq(0)").focus();
				return false;
			} else if($("#title").val()=="") {
				alert("제목을 입력해주세요.");
				$("#title").focus();
				return false;
			} else if($("#content").val()=="") {
				alert("내용을 입력해주세요.");
				$("#content").focus();
				return false;
			} else {
				faq_write_form.submit();
			}
		});
		
		$("#btnFaqCancel").click(function() {
			window.history.back();
		});
	});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>
	<jsp:include page="admin_cs_header.jsp"></jsp:include>
	
	<div class="faq_content">
		<h3>FAQ 등록</h3>
		<form name="faq_write_form" action="adminFaqWriteProcess.jsp" method="post" class="admin_faq_form" enctype="multipart/form-data">
			<table>
				<tr>
					<th>
						<label>유형</label>
					</th>
					<td>
						<input type="radio" name="ftype" value="ftype1">제품
						<input type="radio" name="ftype" value="ftype2">포인트
						<input type="radio" name="ftype" value="ftype3">회원
						<input type="radio" name="ftype" value="ftype4">기타
					</td>
				</tr>
				<tr>
					<th>
						<label><img src="http://localhost:9000/br31/images/icon_question.gif" alt="question_icon"></label>
					</th>
					<td>
						<input type="text" name="title" id="title">
					</td>
				</tr>
				<tr>
					<th>
						<label><img src="http://localhost:9000/br31/images/icon_answer.gif" alt="answer_icon"></label>
					</th>
					<td>
						<textarea name="content" id="content"></textarea>
					</td>
				</tr>
				<tr>
					<th>
						<label>첨부파일</label>
					</th>
					<td>
						<input type="file" name="ffile">
					</td>
				</tr>
			</table>
			<div class="faq_write_btns">
				<button type="button" id="btnFaqSave">등록</button>
				<button type="button" id="btnFaqCancel">취소</button>
			</div>
		</form>
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