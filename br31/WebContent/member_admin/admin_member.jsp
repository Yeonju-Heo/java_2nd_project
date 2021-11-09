<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.dao.*, com.br31.vo.*, java.util.*,com.br31.vo.SessionVO" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
	if(svo.getId().equals("admin")){ 
		
		MemberDAO dao = new MemberDAO();
		ArrayList<MemberVO> list = dao.getList();
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		
		ajax_list("total", null);	//body 로딩 후 전체 리스트 출력 함수 호출
		
		
		/**************************
			전체리스트 출력 함수
		****************************/		
		function ajax_list(category, sname){
			$.ajax({
				url : "admin_member_search.jsp?category="+category+"&sname="+sname,
				success : function(result){
					
					//alert(result);
					var jdata = JSON.parse(result);			
					
					//2. DHTML을 이용하여 테이블 생성 후 출력
					var output = "<table class = 'admtable' id = 'table'>";
					output += "<tr><th>번호</th><th>아이디</th><th>이름</th><th>생년월일</th><th>전화번호</th><th>주소</th><th>이메일</th><th>포인트</th><th>가입일자</th><th>회원삭제</th></tr>";
					
					for(var i in jdata.jlist){
							output += "<tr>";
							output += "<td>" + jdata.jlist[i].rno + "</td>";
							output += "<td><a href = 'http://localhost:9000/br31/member_admin/admin_member_content.jsp?id="+jdata.jlist[i].id+"&rno="+jdata.jlist[i].rno+"'>" + jdata.jlist[i].id + "</a></td>";
							output += "<td>" + jdata.jlist[i].name + "</td>";
							output += "<td>" + jdata.jlist[i].birth + "</td>";
							output += "<td>" + jdata.jlist[i].hp + "</td>";
							output += "<td>" + jdata.jlist[i].addr + "</td>";
							output += "<td>" + jdata.jlist[i].email + "</td>";
							output += "<td>" + jdata.jlist[i].point + "</td>";
							output += "<td>" + jdata.jlist[i].mdate + "</td>";
							if(jdata.jlist[i].choice==1){
								/* output+="<td><button type = 'button' class = 'btn_unregister'>회원삭제</button></td>" */
								output+="<td><a href = 'http://localhost:9000/br31/mypage/userDeleteProcess.jsp?id="+jdata.jlist[i].id+"'><button button type = 'button' class = 'btn_unregister'>회원삭제</button></a></td>"; 
							}else{
								output+="<td><button type = 'button' class = 'btn_unregister' disabled>회원삭제</button></td>"
							} 
							output += "</tr>";
					}				
					
					output += "</table>";
					
					$("#table").remove();
					$("div#member_list").after(output);
					
				}//success
				
			});//ajax
			
		}//ajax_list function
		
		
		/**************************
			 검색 기능
		****************************/
		$("#btn_search").click(function(){
			if($("#stype").val() != "total"){
				if($("#member_search").val() == ""){
					alert("검색 데이터를 입력해주세요");
					$("#member_search").focus();
					return false;
				}else{
					//alert($("#search_name").val());
					var category = $("#stype").val();
					var sname = $("#member_search").val();
					ajax_list(category, sname);
				}
			}else{
				var category = $("#stype").val();
				var sname = $("#member_search").val();
				ajax_list(category, sname);
			}
		});
		
		/**************************
			필터기능
		****************************/
		$("button[name=btnFilter]").click(function(){
			var id = $(this).attr("id");
			
			if(id == "filter"){	
				$(this).attr("id","filter_onclick");
				$(this).removeClass("btn_confrim");
				$(this).addClass("btn_cancle");
				
				ajax_list("choice", null);
				
			}else if(id == "filter_onclick"){
				$(this).attr("id","filter")
				$(this).removeClass("btn_cancle");
				$(this).addClass("btn_confrim");
				
				ajax_list("total", null);
			}	
		
		});
		
		
		
		/**************************
			카테고리 변경시 호출
		****************************/
		$("#stype").change(function(){
			if($(this).val() == "total"){
				$("#member_search").val("");
			}
		});
		
		
	});
</script>
</head>
<body>
	<div class = "member_content">
	
		<!-- header -->
		<jsp:include page = "../admin_header.jsp"></jsp:include>
		
		<section class = "ad_m_header">
			<div class = "member_title">
				<div>
					<img src = "http://localhost:9000/br31/images/spoon_left.PNG" class = "spoon_img">
					<h1>회원 관리</h1>
					<img src = "http://localhost:9000/br31/images/spoon_right.PNG" class = "spoon_img">
				</div>
			</div>
		</section>
		<!-- content -->
		<div class = "member_search">
			<select id = "stype" class = "mselect">
				<option value = "total" name = "total">선택</option>
				<option value = "id" name = "id">아이디</option>
				<option value = "name" name = "name">이름</option>
			</select>
			<input type = "text" id = "member_search">
			<button type = "button" id = "btn_search" name = "searchword" class = "btn_cancle">검색</button>
		</div>
		<div class = "filter_section">
			<button id = "filter" class = "btn_confrim" name = "btnFilter">탈퇴회원만 보기</button>
		</div>
		<section class = "ad_m_content">
			<div id = "member_list">
			</div>			
		</section>
		<!-- footer -->
		<section class = "ad_m_footer">
			<img src = "http://localhost:9000/br31/images/baskin_logo_admin.png">
		</section>
		
	</div>
</body>
</html>
<% }else{%>
	<script>
		window.alert("접근권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<% } %>
<% }else{%>
	<script>
		window.alert("로그인후 사용이 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %> 