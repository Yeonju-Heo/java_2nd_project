<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		//폼체크
		$("button#pop_confrim").click(function(){
			if($("#ipin").val() == ""){
				alert("아이핀을 입력해주세요");
				$("#ipin").focus();
				return false
				
			}else if($("#email1").val() == ""){
				alert("이메일을 입력해주세요");
				$("#email1").focus();
				return false
				
			}else if($("#email2").val() == ""){
				alert("이메일 주소를 선택해주세요");
				$("#email3").focus();
				return false
				
			}else{
				login_phone_form.submit();
			}
			
		});//form_check
		
		//이메일 체크
		$("#email3").change(function(){
			if($("#email3").val() == "choice"){
				alert("다른 주소를 선택해주세요");
				$("#email3").focus();
				$("#email2").val("");
			}else{
				$("#email2").val($("#email3").val());
			}
		});
		
		
	});
</script>
</head>
<body>
	<!-- content -->
	<div class = "pop_content">
		<form name = "login_phone_form" action = "http://localhost:9000/br31/login/idSearchProcess.jsp" method = "post">
			<input type = "hidden" name = "type" value = "ipin">
			<ul>
				<li>
					<label>이름</label>
					<input type = "text" name = "name" id= "ipinName" placeholder = "이름을 입력해주세요">
				</li>
				<li class = "ipin_style">
					<label>아이핀</label>
					<input type = "text" id = "ipin" placeholder = "아이핀 id를 입력해주세요">
				</li>
				<li>
					<label>이메일</label>
					<input type = "text" name = "email1" id = "email1"><span> @ </span>
					<input type = "text" name = "email2" id = "email2">
					<select id = "email3" class = "select_style">
						<option value = "선택">선택</option>
						<option value = "naver.com" id = "addr1">naver.com</option>
						<option value = "gmail.com" id = "addr2">gmail.com</option>
						<option value = "daum.net" id = "addr3">daum.net</option>
						<option value = "직접입력" id = "addr4">직접입력</option>
					</select>
					<!-- <span>*등록된 이메일로 아이디가 발송됩니다.</span> -->
				</li>
				<li>
					<button type = "button" class = "btn_confrim" id = "pop_confrim">인증하기</button>
					<button type = "button" class = "btn_cancle" onclick="self.close();" id = "pop_cancle">취소</button>
				</li>
			</ul>
		</form>
	</div>
</body>
</html>