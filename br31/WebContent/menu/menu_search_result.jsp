<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.br31.dao.*, com.br31.vo.*, java.util.*" %>
<% 
	String category = request.getParameter("category");
	String pname=request.getParameter("pname");
	String hashtag = request.getParameter("hashtag");
	String[] allergies = request.getParameterValues("allergy");
	
	MenuDAO dao = new MenuDAO();
	ArrayList<MenuVO> list = dao.getSearchResult(category, pname, hashtag, allergies);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/menu_list.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	
	$(document).ready(function(){
		$("#btn_search").click(function(){
			$("#modal").show();
			$("#overlay").css({"opacity":"1","pointer-events":"auto"});
		});
		$("#exit").click(function(){
			$("#modal").hide();
			$("#overlay").css({"opacity":"0","pointer-events":"none"});
		});
		$("#overlay").click(function(){
			$("#modal").hide();
			$("#overlay").css({"opacity":"0","pointer-events":"none"});
		});
	});
	
	
</script>
</head>
<body>
<!-- header -->
<jsp:include page = "../header.jsp"></jsp:include>

<!-- content -->
<section class="page">
<div class="search_result_title">
	<div class="title">
		<div class="title_left"></div>
		<img src="http://localhost:9000/br31/menu/images/h_search_result.png">
		<div class="title_right"></div>
	</div>
</div>
<div class="search_result_label">
	<label>검색결과 총</label>
	<label id="search_count" class="search_count"><%= list.size() %></label>
	<label>건 검색되었습니다.</label>
</div>
<div class="search_result_button">
	<button id="btn_search">다시 검색하기</button>
</div>
<jsp:include page="menu_search_box.jsp">
		<jsp:param name="category" value="<%=category %>" />
</jsp:include>

<section class="icecream_menu">
		<div class="icecream_menu">
		<section class="search_result">
		<table class="icecream_menu">
			<% 
				int i=1;
				for(MenuVO vo : list){ 
					if(i%4==1){%>
					<tr class="src_one">
					<% }%>
					<td class="src_one">
					<%if(category.toUpperCase().equals("ICECREAM")){ %>
						<a href="menu_icecream_select.jsp?pname=<%=vo.getPname()%>&category=<%=category %>" class="outer">
							<span class="depth1">
							<% if(vo.getSet_check()==0){%>
								<span class="depth2">
									<label class="name"><%=vo.getPname() %></label>
									<%
									if(vo.getHashtag()!=null){
										for(int v=0; v<vo.getHashtag().length; v++){
										%>
										<label class="hashtag"><%=vo.getHashtag()[v] %></label>
										 <%
										 if(v>=2){
												v = vo.getHashtag().length;
											}  
										}
									}
									 %>
									<img src="http://localhost:9000/br31/menu/images/<%=vo.getPsfile() %>">				
								</span>
							<%}else{ %>
								<span class="depth2_no_bg">
									<label class="name"><%=vo.getPname() %></label>
									<%
									if(vo.getHashtag()!=null){
										for(int v=0; v<vo.getHashtag().length; v++){
										%>
										<label class="hashtag"><%=vo.getHashtag()[v] %></label>
										 <%
										 if(v>=2){
												v = vo.getHashtag().length;
											}  
										}
									}
									 %>
									<img src="http://localhost:9000/br31/menu/images/<%=vo.getPsfile() %>">				
								</span>
							<%} %>
							</span>
						</a>
					<%}else{ %>
						<a href="menu_coffee_select.jsp?pname=<%=vo.getPname()%>&category=<%=category %>" class="outer">
							<span class="depth1">
								<span class="depth2_no_bg">
									<label class="name"><%=vo.getPname() %></label>
									<%
									if(vo.getHashtag()!=null){
										for(int v=0; v<vo.getHashtag().length; v++){
										%>
										<label class="hashtag"><%=vo.getHashtag()[v] %></label>
										 <%
										 if(v>=2){
												v = vo.getHashtag().length;
											}  
										}
									}
									 %>
									<img src="http://localhost:9000/br31/menu/images/<%=vo.getPsfile() %>">				
								</span>
							</span>
						</a>
					<%} %>
					</td>
				<% 
				if(i%4==0 || vo.getPname().equals(list.get(list.size()-1).getPname())){ %>
					</tr>
			  <%}
				i++;
			}%>
			</table>
		</section>
		</div>
	</section>

</section>

<!-- footer -->
<jsp:include page = "../footer.jsp"></jsp:include>

</body>
</html>