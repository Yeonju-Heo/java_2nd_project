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
 	
 	int height;
 	if(vo.getRec_flavor()!=null){
 		height = 1700;
 	}else{
 		height = 1300;
 	}
 	
 	String insta_code = pname.replace(" ","");
 	SessionVO svo = (SessionVO)session.getAttribute("svo");
 	
 	int result = 0;
 	if(svo != null){
 		MypageDAO mdao = new MypageDAO();
 		result = mdao.getStarCount(svo.getId(), pname);
 		mdao.close();
 	}
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
		
		$("#star_button").hover(function(){
			$("#star_button").attr("src","http://localhost:9000/br31/images/star_button_onclick.PNG")
			$("#arrowbox").show();
		},
		function(){
			$("#star_button").attr("src","http://localhost:9000/br31/images/star_button.PNG")
			$("#arrowbox").hide();
		});
		$(window).scroll(function(){
			if(pageYOffset<=300){
				$("#btn_left").animate({top : 300+'px'}, 110);
				$("#btn_right").animate({top : 300+'px'}, 110); 
			}else if(pageYOffset>500 && pageYOffset< <%=height%> ){
				$("#btn_left").animate({top : pageYOffset+100+'px'}, 110);
				$("#btn_right").animate({top : pageYOffset+100+'px'}, 110);
			}
		});
		$("#copy_link").click(function(){
			prompt("주소를 복사해서 사용해주세요.",window.location.href);
		});
		
		//클릭이벤트 추가
		$("img[name=btn_star]").click(function(){
			<% if(svo != null){ %>
				<% if(vo.getSet_check()==0){%>
					var btn_s = $("img[name=btn_star]").attr("id");
						if(btn_s == "star_button"){
								$.ajax({
									url:"http://localhost:9000/br31/mypage/mfUpdateProcess.jsp?id=<%=svo.getId()%>&pname=<%=vo.getPname()%>",
									success:function(result){
										if(result==1){
											$("#star_button").attr("src","http://localhost:9000/br31/images/star_button_onclick.PNG");
											$("#star_button").attr("id","star_button_onclick");
											location.reload();
										}
									}
								});
							}else{
								$.ajax({
									url:"http://localhost:9000/br31/mypage/mfDeleteProcess.jsp?id=<%=svo.getId()%>&pname=<%=vo.getPname()%>",
									success:function(result){
										if(result==1){
											$("#star_button_onclick").attr("src","http://localhost:9000/br31/images/star_button.PNG");
											$("#star_button_onclick").attr("id","star_button");
											location.reload();
										}
									}
								});
							}
					<%}else{%>
						alert("좋아하는 맛 등록은 팩 메뉴가 아닌 것만 가능합니다.");
					<%}
				}else{%>
				alert("로그인 후 이용가능합니다.");
				return false;
			<%}%>
			
		});
		/*
		$("#btn_left").hover(function(){
			$("#btn_left").css({"border" : "1px solid rgb(243,125,160)", "width" : "230px",
				"border-radius" : "40px", "text-align" : "left", "padding-left" : "30px", "transition":"width 300ms"});
		},
		function(){
			$("#btn_left").css({"border" : "1px solid rgb(187,187,187)", "width" : "80px",
				"border-radius" : "100%", "text-align" : "left","transition":"300ms"});
			$("#btn_image").remove();
			$("#btn_label").remove();
			
		});
		*/
		
	});
</script>
</head>
<body>
<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>

<!-- content -->
<section class="page" id="page">
<section class="inner_page" id="inner_page">


<!-- button -->
	<span class="btn_index" id="btn_index">
		<%if(!pre_pname.equals("null")){ %>
		<a href="http://localhost:9000/br31/menu/menu_icecream_select.jsp?pname=<%=pre_pname%>&category=<%=category%>"><button class="left" id="btn_left">&lt;</button></a>
		<%} %>
	</span>
	<span class="btn_index" id="btn_index">
		<%if(!next_pname.equals("null")){ %>
		<a href="http://localhost:9000/br31/menu/menu_icecream_select.jsp?pname=<%=next_pname%>&category=<%=category%>"><button class="right" id="btn_right">&gt;</button></a>
		<%} %>
	</span>

<div class="content">
	<section class="top_info">
		<label class="eng_name">
		<%if(vo.getEng_pname()!=null){ %>
		 	<%=vo.getEng_pname()%>
		<%}%>
	 	</label>
		<h1 class="kor_name" id="kor_name"><%=vo.getPname() %></h1>
		<label class="p_explain"><%=vo.getIntro() %></label>
		<%if(vo.getSet_check()==0){ %>
			<div class="bg">
				<div class="icecream_img">
					<img src="images/<%=vo.getPsfile()%>">
				</div>
					<div class="arrowbox" id="arrowbox"><span>좋아하는 플레이버 등록</span></div>
				<div class="icons">
					<!-- DB에서 데이터를 가져와서 해당 데이터가 선택 되어 있으면 아이디를 star_button_onclick으로 바꾸기 -->
					<% if(result == 1){ %>
					<a href="#"><img src="http://localhost:9000/br31/images/star_button_onclick.PNG" name = "btn_star" id="star_button_onclick"></a>
					<% }else{ %>
					<a href="#"><img src="http://localhost:9000/br31/images/star_button.PNG" name = "btn_star" id="star_button"></a>
					<% } %>
					<a href="https://www.facebook.com/search/posts/?q=<%=pname%>" target="_blank"><img src="images/icon_facebook.png"></a>
					<a href="https://twitter.com/search?q=<%=pname %>&src=typed_query" target="_blank"><img src="images/icon_twitter.png"></a>
					<a href="#" id="copy_link"><img src="images/icon_copy.png"></a>
				</div>
			</div>
		<%}else{ %>
			<div class="no_bg">
				<div class="icecream_img">
					<img src="images/<%=vo.getPsfile()%>">
				</div>
					<div class="arrowbox" id="arrowbox"><span>좋아하는 플레이버 등록</span></div>
				<div class="icons">
					<!-- DB에서 데이터를 가져와서 해당 데이터가 선택 되어 있으면 아이디를 star_button_onclick으로 바꾸기 -->
					<% if(result == 1){ %>
					<a href="#"><img src="http://localhost:9000/br31/images/star_button_onclick.PNG" name = "btn_star" id="star_button_onclick"></a>
					<% }else{ %>
					<a href="#"><img src="http://localhost:9000/br31/images/star_button.PNG" name = "btn_star" id="star_button"></a>
					<% } %>
					<a href="https://www.facebook.com/search/posts/?q=<%=pname%>" target="_blank"><img src="images/icon_facebook.png"></a>
					<a href="https://twitter.com/search?q=<%=pname %>&src=typed_query" target="_blank"><img src="images/icon_twitter.png"></a>
					<a href="#" id="copy_link"><img src="images/icon_copy.png"></a>
				</div>
			</div>
		<%} %>
	</section>
	<section class="size_info">
		<div class="depth1">
			<img class="title" src="images/h_conecup.gif">
			<div class="depth2">
				<img class="size" src="images/size_single_r.png">
				<div class="text">
					<label class="title">싱글레귤러</label>
					<label class="info">한가지 맛을 센스있게<br>
					즐길수 있는 사이즈<br>
					(용기무게 제외 중량 115g)</label>
					<label class="price">3,200원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_single_k.png">
				<div class="text">
					<label class="title">싱글킹</label>
					<label class="info">좋아하는 맛 한가지만 듬뿍<br>
					맛볼 수 있는 사이즈 (중량 145g)</label>
					<label class="price">4,000원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_double_j.png">
				<div class="text">
					<label class="title">더블주니어</label>
					<label class="info">두가지 맛을 조금씩 한번에<br>
					즐기는 사이즈 (중량 150g)</label>
					<label class="price">4,300원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_double_r.png">
				<div class="text">
					<label class="title">더블레귤러</label>
					<label class="info">아이스크림 매니아를 위한<br>
					진정한 더블 사이즈 (중량 230g)</label>
					<label class="price">6,200원</label>
				</div>
			</div>
		</div>
		
		<div class="depth1">
			<img class="title" src="images/h_handpack.gif">
			<div class="depth2">
				<img class="size" src="images/size_pint.png">
				<div class="text">
					<label class="title">파인트</label>
					<label class="info">3가지 맛을 골라먹는 재미가<br>
					있는 사이즈 (중량 320g)</label>
					<label class="price">8,200원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_quarter.png">
				<div class="text">
					<label class="title">쿼터</label>
					<label class="info">4가지 맛을 골라먹는 재미가<br>
					있는 사이즈 (중량 620g)</label>
					<label class="price">15,500원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_family.png">
				<div class="text">
					<label class="title">패밀리</label>
					<label class="info">5가지 맛을 나눠먹는 재미가<br>
					있는 사이즈 (중량 960g)</label>
					<label class="price">22,000원</label>
				</div>
			</div>
			<div class="depth2">
				<img class="size" src="images/size_halfgallon.png">
				<div class="text">
					<label class="title">하프갤런</label>
					<label class="info">6가지 맛을 나눠먹는 재미가<br>
					있는 사이즈 (중량 1200g)</label>
					<label class="price">26,500원</label>
				</div>
			</div>
		</div>
	</section>
	<% if(vo.getRec_flavor()!=null){ %>
		<section class="recommend_flavor">
			<h3 class="title">추천플레이버</h3>
			<table>
				<tr>
					<%  for(String r_ice:vo.getRec_flavor()){ %>
						<td>
							<a href="menu_icecream_select.jsp?pname=<%=r_ice%>&category=icecream">
								<span class="depth1">
									<span class="depth2">
										<label class="name"><%=r_ice %></label>
										<% MenuVO r_vo = dao.getMenuIcecreamContent(r_ice); %>
										<img src="http://localhost:9000/br31/menu/images/<%=r_vo.getPsfile()%>">
									</span>
								</span>
							</a>
						</td>
					<% } %>
				</tr>
			</table>
		</section>
	<% }%>
	<section class="instagram">
		<h3 class="title">인스타그램에서 만나는</h3>
		<label class="hashtag">#<%=vo.getPname() %></label>
		<label class="hashtag">#배스킨라빈스</label>
		<div class="insta_icon"><a href="https://www.instagram.com/explore/tags/<%=insta_code %>/" target="_blank"><img src="http://localhost:9000/br31/images/sns_instagram.png"></a></div>
	</section>
	<a href="http://localhost:9000/br31/menu/menu_icecream.jsp"><button class="list">목록</button></a>
</div>

</section>
</section>

<!-- 이벤트, happy order 하단 띠 -->
<jsp:include page = "menu_select_footer.jsp"></jsp:include>
<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
	
</body>
</html>
<% dao.close();%>