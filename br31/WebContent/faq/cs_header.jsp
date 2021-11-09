<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<script>
	$(document).ready(function() {
	
		$("button").click(function() {
			$(this).css("border-color", "red");
		});
		
	});
</script>
<style>
	.voc_on {
		border-color: pink;
	}
</style>
</head>
<body>
	<section class="cs_header">
		<div class="title">
			<p><img src="http://localhost:9000/br31/images/h_customer_center.png"></p>
			<span>고객의 소리를 적극 경청하고 고객만족향상 활동을 지속적으로 실천합니다.</span>
		</div>
		<div class="cs_menu">
			<a href="http://localhost:9000/br31/faq/faq_list.jsp"><button type="button" class="btn_faq">자주하는 질문</button></a> 
			<a href="http://localhost:9000/br31/voc/voc_write.jsp"><button type="button" class="btn_voc">1:1 문의</button></a> 
			<a href="http://localhost:9000/br31/voc/voc_list.jsp"><button type="button" class="btn_myvoc">내 문의함</button></a>
		</div>
	</section>
</body>
</html>