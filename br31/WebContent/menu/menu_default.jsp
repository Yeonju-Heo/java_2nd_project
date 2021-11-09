<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.br31.dao.*, com.br31.vo.*, java.util.*" %>
 <%
 MenuDAO dao = new MenuDAO();
 ArrayList<MenuVO> ice_list = dao.getMenuPromotionList("icecream");
 ArrayList<MenuVO> cf_list = dao.getMenuPromotionList("coffee");
 dao.close();
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/menu_list.css">
</head>
<body>

<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>

<!-- content -->
<div class="content">
	<section class="logo_menu">
	</section>
	
	
<!-- ************coffee menu **********-->
<!-- ************coffee menu **********-->
<!-- ************coffee menu **********-->
<!-- ************coffee menu **********-->

<section class="page">
		<div class="title">
			<div class="title_left"></div>
			<img src="http://localhost:9000/br31/menu/images/h_title_flavor_of_month.png">
			<div class="title_right"></div>
		</div>

		<div class="flavor_of_month">
		<img src="http://localhost:9000/br31/menu/images/logo_flavor_of_month.jpg">
		</div> 

		<div class="title">
			<div class="title_left"></div>
				<img src="http://localhost:9000/br31/menu/images/h_title_icecream.png">
			<div class="title_right"></div>
		</div>
		<div class="btn_more"><a href="menu_icecream.jsp"><button class="btn_more">MORE</button></a></div>
		
	<section class="icecream_menu">
		<div class="icecream_menu">
		<table class="icecream_menu">
			<tr class="src_one">
				<% for(int i=0;i<ice_list.size();i++){ %>
				<td class="src_one">
					<a href="menu_icecream_select.jsp?pname=<%=ice_list.get(i).getPname()%>&category=icecream">
						<span class="depth1">
							<span class="depth2">
								<label class="name"><%=ice_list.get(i).getPname()%></label>
								<%
									if(ice_list.get(i).getHashtag()!=null){
										for(int v=0; v<ice_list.get(i).getHashtag().length; v++){
										%>
										<label class="hashtag"><%=ice_list.get(i).getHashtag()[v] %></label>
										 <%
										 if(v>=2){
												v = ice_list.get(i).getHashtag().length;
											}  
										}
									}
								%>
								<img src="http://localhost:9000/br31/menu/images/<%=ice_list.get(i).getPsfile() %>">					
							</span>
						</span>
					</a>
				</td>
				<%
				if(i==3){
					i=ice_list.size();
				}
				} %>
			</tr>
			</table>
		</div>
	</section>
	
	<div class="title">
		<div class="title_left"></div>
			<img src="http://localhost:9000/br31/menu/images/h_title_coffee.png">
		<div class="title_right"></div>
	</div>
	<div class="btn_more"><a href="menu_coffee.jsp"><button class="btn_more">MORE</button></a></div>
	
	<section class="icecream_menu">
		<div class="icecream_menu">
		<table class="icecream_menu">
			<tr class="src_one">
				<% for(int i=0;i<cf_list.size();i++){ %>
				<td class="src_one">
					<a href="menu_coffee_select.jsp?pname=<%=cf_list.get(i).getPname()%>&category=coffee">
						<span class="depth1">
							<span class="depth2_no_bg">
								<label class="name"><%=cf_list.get(i).getPname()%></label>
								<%
									if(cf_list.get(i).getHashtag()!=null){
										for(int v=0; v<cf_list.get(i).getHashtag().length; v++){
										%>
										<label class="hashtag"><%=cf_list.get(i).getHashtag()[v] %></label>
										 <%
										 if(v>=2){
												v = cf_list.get(i).getHashtag().length;
											}  
										}
									}
								%>
								<img src="http://localhost:9000/br31/menu/images/<%=cf_list.get(i).getPsfile() %>">					
							</span>
						</span>
					</a>
				</td>
				<%
				if(i==3){
					i=ice_list.size();
				}
				} %>
			</tr>
			</table>
		</div>
	</section>
	
</section>
	
</div>

<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
</body>
</html>