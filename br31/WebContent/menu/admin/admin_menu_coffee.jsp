<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.br31.dao.*,com.br31.vo.*,java.util.*, com.br31.vo.SessionVO" %>
<%
SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
	if(svo.getId().equals("admin")){
		MenuDAO dao = new MenuDAO();
		String status= "coffee";
		ArrayList<MenuVO> list = dao.getAdminList(status);
		
		MenuVO thisvo = new MenuVO();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/admin_menu.css">
</head>
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>

/******
	팝업창 띄우기
*****/

function updatePop(){
	window.open("admin_menu_update.jsp?category=coffee&status=before","","width = 800, height = 900, top = 25, left = 800");
}
function writePop(){
	window.open("admin_menu_write.jsp?category=coffee&status=before","","width = 800, height = 900, top = 50, left = 800");
}
function deletePop(){
	window.open("admin_menu_delete.jsp?category=coffee&status=before","","width = 800, height = 400, top = 50, left = 800");
}

function ajax_list(pname){
	$.ajax({
		url:"admin_menu_nutrient_ajax.jsp?pname="+pname,
		success:function(result){
			//실행결과에 따른 처리.
			var jdata = JSON.parse(result);
			//var output = "<button class='exit' id='exit'>&times;</button>";
			var output = "<table class='nutrient_info'>";
			output += "<tr><th>제품명</th><td>"+jdata.pname+"</td></tr>";
			output += "<tr><th>1회 제공량(g)</th><td>"+jdata.one_amount+"</td></tr>";
			output += "<tr><th>열량(kcal)</th><td>" + jdata.kcal + "</td></tr>";
			output += "<tr><th>나트륨(mg)</th><td>"+jdata.natrium+"</td></tr>";
			output += "<tr><th>당류(g)</th><td>"+jdata.sugar+"</td></tr>";
			output += "<tr><th>포화지방(g)</th><td>"+jdata.fat+"</td></tr>";
			output += "<tr><th>단백질(g)</th><td>"+jdata.protein+"</td></tr>";
			output += "<tr><th>카페인(mg)</th><td>"+jdata.caffeine+"</td></tr>";
			output += "<tr><th>알레르기 성분</th><td>"+jdata.allergy+"</td></tr></table>";
			
			$("#modal_content").append(output);
		}//success
	});//ajax
}//ajax_list function

$(document).ready(function(){
	$("td").find("button").click(function(){
		$("#modal_content").empty();
		var x = document.activeElement;
		var index = $(x).parents("tr").index();
		var pname = $("#menu_table").find("tr").eq(index).find("span").text();
		ajax_list(pname);
		
		$("#modal").show();
		$("#overlay").css({"pointer-events":"auto"});
	}); 
	$("#modal").find("button").click(function(){
		$("#modal").hide();
		$("#overlay").css({"pointer-events":"none"});
	});
	$("#overlay").click(function(){
		$("#modal").hide();
		$("#overlay").css({"pointer-events":"none"});
	});
	$("#btn_update").click(function(){
		updatePop();
	});
	$("#btn_delete").click(function(){
		deletePop();
	});
	$("#btn_write").click(function(){
		writePop();
	});
	
	
});//document.ready

</script>
<body>

<!-- header -->
	<jsp:include page = "../../admin_header.jsp"></jsp:include>

<!-- content -->
<section class="page">
<div class="content">
<h3 class="title">메뉴 관리</h3>
<form name="menu_view" action="admin_menu_coffee.jsp" method="get" class="menu_form" id="menu_form">
<input type="hidden" id="hidden_tag" name="status">
	<div class="category">
		<ul class="category">
			<li><a href="admin_menu_icecream.jsp">아이스크림</a></li>
			<li class="selected"><a href="admin_menu_coffee.jsp">커피</a></li>
		</ul>
	</div>
	<div class="buttons">
		<ul class="buttons">
			<li><button type="button" class="update" id="btn_write">등록</button></li>
			<li><button type="button" class="update" id="btn_update">수정</button></li>
			<li><button type="button" class="update" id="btn_delete">삭제</button></li>
		</ul>
	</div>
<div class="table">
	<ul>
		<li>
			<table class="menu_coffee" id="menu_table">
				<tr>
					<th>메뉴 이름</th>
					<th>영어 이름</th>
					<th>메뉴 설명</th>
					<th>해쉬태그</th>
					<th>메뉴 사진</th>
					<th>영양정보</th>
				</tr>
				<% for(MenuVO vo:list){ 
					thisvo = vo;
				%>
				<tr>
					<td id="pname"><span><%=vo.getPname() %></span></td>
					<td><%=vo.getEng_pname() %></td>
					<td><%=vo.getIntro() %></td>
					<td>
						<ul>
						<% if(vo.getHashtag()==null){ %>
							<li>-</li>
						<% }else{
							for(String hash:vo.getHashtag()){
							%>
							<li><%= hash %></li>
							<%} 
							}%>
						</ul>
					</td>
					<td><img class="p_image" src="http://localhost:9000/br31/menu/images/<%=vo.getPsfile() %>"></td>
					<td><button type="button" class="nutrients_more" id="nutrients">보기</button></td>
				</tr>
				<%} %>
			</table>
		</li>
	</ul>
</div>
</form>
<div class="modal" id="modal">
	<button class="exit" id="exit">&times;</button>
	<div class="modal_content" id="modal_content">
</div>
</div>
	<div class="overlay" id="overlay"></div>
</div>
</section>
<!-- footer -->
	<jsp:include page = "../../footer.jsp"></jsp:include>
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