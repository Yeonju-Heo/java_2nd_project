<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="com.br31.dao.*, com.br31.vo.*, java.util.*" %>
 <%
 	String pname = request.getParameter("pname");
 	String category = request.getParameter("category");
 	MenuDAO dao = new MenuDAO();
 	MenuVO vo = dao.getMenuIcecreamContent(pname);
 	String pre_pname = dao.getNextMenuPname(pname, category, "previous"); 
 	String next_pname = dao.getNextMenuPname(pname, category, "next");
 	dao.close();
 	
 	int height;
	height = 1700;
 	
 	String insta_code = "배스킨라빈스"; 
 	insta_code += pname.replace(" ","");
 	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/menu_select.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>
	
	$(document).ready(function(){
		
		$(window).scroll(function(){
			if(pageYOffset<=300){
				$("#btn_left").animate({top : 300+'px'}, 110);
				$("#btn_right").animate({top : 300+'px'}, 110); 
			}else if(pageYOffset>500 && pageYOffset< <%=height%> ){
				$("#btn_left").animate({top : pageYOffset+100+'px'}, 110);
				$("#btn_right").animate({top : pageYOffset+100+'px'}, 110);
			}
		});
		/*
		var tracks = document.getElementsByName("coffee_list");
		var contentsize = document.getElementById("content").offsetWidth; 
		
		for(var i=0;i<2;i++){
			var tracksize = tracks[i].offsetWidth;
			tracks[i].onmousemove = function(){
				var start = -(window.innerWidth-contentsize)/2+400;
				var x = start-(event.clientX);
	
				if(x<= (start+window.innerWidth-tracksize+950)){
					x = (start+window.innerWidth-tracksize+950);
				}else if(x>=start){
					x = start;
				}
				var left = x +"px";
				tracks[i].style.transform = "translateX("+left+")";
				tracks[i].style.transition = "transform 0.2s"
			}
		}
		*/
		//var contentsize = document.getElementById("content").offsetWidth; 
		//var tracksize = document.getElementById("coffee_list_1").offsetWidth;
		$("#copy_link").click(function(){
			prompt("주소를 복사해서 사용해주세요.",window.location.href);
		});
		
		var rect = document.getElementById("coffee_border_1").getBoundingClientRect();
		var contentsize = document.getElementById("coffee_border_1").clientWidth; 
		var tracksize = document.getElementById("coffee_list_1").clientWidth; 
		var start = rect.left;
		var end = start+contentsize;
		$("#coffee_border_1").mousemove(function(){
			var x = event.offsetX;
			var y = 0;
			if(x>=contentsize/2){
				y = start-contentsize;
			}else if(x<contentsize/2){
				y= 0;	
			}
			var left = y +"px";
			$("#coffee_list_1").css({"transform":"translateX("+left+")"});
			$("#coffee_list_1").css({"transition":"transform 0.5s"});
		});
		
		$("#coffee_border_2").mousemove(function(){
			var x = event.offsetX;
			var y = 0;
			if(x>=contentsize/2){
				y = start-contentsize;
			}else if(x<contentsize/2){
				y= 0;	
			}
			var left = y +"px";
			$("#coffee_list_2").css({"transform":"translateX("+left+")"});
			$("#coffee_list_2").css({"transition":"transform 0.5s"});
		});
	});
	
	
</script>
</head>
<body>
<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>

<!-- content -->
<section class="page">
<section class="inner_page">


<!-- button -->
	<span class="btn_index">
		<%if(!pre_pname.equals("null")){ %>
		<a href="http://localhost:9000/br31/menu/menu_coffee_select.jsp?pname=<%=pre_pname%>&category=<%=category%>"><button class="left" id="btn_left">&lt;</button></a>
		<%} %>
	</span>
	<span class="btn_index">
		<%if(!next_pname.equals("null")){ %>
		<a href="http://localhost:9000/br31/menu/menu_coffee_select.jsp?pname=<%=next_pname%>&category=<%=category%>"><button class="right" id="btn_right">&gt;</button></a>
		<%} %>
	</span>

<div class="content" id="content">
	<section class="top_info">
		<label class="eng_name">
		<%if(vo.getEng_pname()!=null){ %>
		 	<%=vo.getEng_pname()%>
		<%}%>
		</label>
		<h1 class="kor_name"><%=vo.getPname() %></h1>
		<label class="p_explain"><%=vo.getIntro() %></label>
		<div class="no_bg">
			<div class="icecream_img">
				<img src="images/<%=vo.getPsfile()%>">
			</div>
			<a href="http://localhost:9000/br31/map/map.jsp"><button class="btn_store_check">판매 매장 확인</button></a>
			<div class="icons_cf">
				<a href="https://www.facebook.com/search/posts/?q=배스킨라빈스<%=pname%>" target="_blank"><img src="images/icon_facebook.png"></a>
				<a href="https://twitter.com/search?q=배스킨라빈스 <%=pname %>&src=typed_query" target="_blank"><img src="images/icon_twitter.png"></a>
				<a href="#" id="copy_link"><img src="images/icon_copy.png"></a>
			</div>
		</div>
	</section>
	<section class="coffee_info">
		<h3 class="coffee_info_title">배스킨라빈스 커피는 어떻게 만들어졌을까요?</h3>
		<img src="images/h_hot_coffee.jpg">
		<div class="coffee_bg" id="coffee_bg">
			<div class="coffee_border" id="coffee_border_1">
			</div>
				<div class="coffee_list" id="coffee_list_1">
					<img src="images/img_hot_coffee_list_1.jpg">
					<img src="images/img_hot_coffee_list_2.jpg">
					<img src="images/img_hot_coffee_list_3.jpg">
					<img src="images/img_hot_coffee_list_4.jpg">
					<img src="images/img_hot_coffee_list_5.jpg">
					<img src="images/img_hot_coffee_list_6.jpg">
					<img src="images/img_hot_coffee_list_7.jpg">
				</div>
		</div>
		<img src="images/h_ice_coffee.jpg">
		<div class="coffee_bg">
			<div class="coffee_border" id="coffee_border_2">
			</div>
				<div class="coffee_list" id="coffee_list_2">
					<img src="images/img_ice_coffee_list_1.jpg">
					<img src="images/img_ice_coffee_list_2.jpg">
					<img src="images/img_ice_coffee_list_3.jpg">
					<img src="images/img_ice_coffee_list_4.jpg">
					<img src="images/img_ice_coffee_list_5.jpg">
					<img src="images/img_ice_coffee_list_6.jpg">
					<img src="images/img_ice_coffee_list_7.jpg">
				</div>
		</div>
		
	</section>
	<section class="instagram">
		<h3 class="title">인스타그램에서 만나는</h3>
		<label class="hashtag">#<%=vo.getPname() %></label>
		<label class="hashtag">#배스킨라빈스</label>
		<div class="insta_icon"><a href="https://www.instagram.com/explore/tags/<%=insta_code %>/" target="_blank"><img src="http://localhost:9000/br31/images/sns_instagram.png"></a></div>
	</section>
	<a href="http://localhost:9000/br31/menu/menu_coffee.jsp"><button class="list">목록</button></a>
</div>

</section>
</section>

<!-- 이벤트, happy order 하단 띠 -->
<jsp:include page = "menu_select_footer.jsp"></jsp:include>
<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
	
</body>
</html>