<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "com.br31.dao.*,com.br31.vo.*,java.util.*,java.net.URLEncoder" %>
 <%
 SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
	if(svo.getId().equals("admin")){
 	String category = request.getParameter("category");
 	String status = request.getParameter("status");
	if(status.equals("before")){
 	MenuDAO dao = new MenuDAO();
	ArrayList<MenuVO> list = dao.getAdminList(category);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/admin_menu.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		$("#btn_delete").click(function(){
			if($("#pname option:selected").val()=="선택"){
				alert("삭제할 메뉴를 선택해 주세요.");
			}else{
				var check = confirm("메뉴를 삭제하시겠습니까?");
				if(check==true){
					menu_delete.submit();
				}else{
					return false;
				}
			}
		});
	}); 
</script>
</head>
<body>
<!-- content -->
<section class="page_update">
<h3 class="title">메뉴 삭제</h3>
<div class="content_update">
	<form name="menu_delete" action="admin_menu_delete_process.jsp" method="get" class="menu_update">
	<h4>삭제할 메뉴를 선택해주세요.</h4>
		<table class="menu_update_table">
			<tr>
				<th>이름</th>
				<td>
					<select id="pname" name="pname">
						<option value="선택">선택</option>
						<%for(MenuVO a_vo : list){ %>
						<option value="<%=a_vo.getPname()%>"><%=a_vo.getPname() %></option>
						<%} %>
					</select>
				</td>
			</tr>
		</table>
		<div class="update_buttons">
			<button type="button" id="btn_delete" name="btn_submit">삭제</button>
		</div>
		
	</form>
</div>
</section>
</body>
</html>
<% }else if(status.equals("after")){ %>
	<script>
		window.alert("삭제 완료되었습니다.");
		window.close();
	</script>
<% } %>
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