<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.br31.vo.*, com.br31.dao.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){	 
		
		MypageDAO dao = new MypageDAO();
		
		//즐겨찾기한 메뉴 리스트 받아오기 br31_f_flavor에서 아이디에 따른 pname 받아오기, menuVO, menuDAO를 이용해서 정보 가져오기
		ArrayList<MenuVO> list = dao.getFlavorList(svo.getId());//pname, id, recflavor 정보를 가져오기(해당아이디의 즐겨찾기 목록)
		ArrayList<MenuVO> reclist = dao.getRecFlavorList(svo.getId());//pname, id 정보를 가져오기(해당아이디의 즐겨찾기 목록)
		
		ArrayList<String> namelist = new ArrayList<String>();
		
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "http://localhost:9000/br31/choi.css">
<script src="http://localhost:9000/myweb2/js/jquery-3.6.0.min.js"></script>
<script>
	//클릭하면 별모양 버튼 색이 바뀌도록 구현
	$(document).ready(function(){
		
		//클릭이벤트 추가
		$("button[name=btn_f]").click(function(){
			var btn_s = $(this).attr("id");
				if(btn_s == "btn_favor"){
					$.ajax({
						url:"http://localhost:9000/br31/mypage/mfUpdateProcess.jsp?id=<%=svo.getId()%>&pname="+$(this).attr('value'),
						success:function(result){
							if(result==1){
								$(this).removeClass("btn_favor");
								$(this).addClass("btn_favor_click");
								$(this).attr("id","btn_favor_onclick");
								location.reload();
							}
						}
					});
				}else{
					$.ajax({
						url:"http://localhost:9000/br31/mypage/mfDeleteProcess.jsp?id=<%=svo.getId()%>&pname="+$(this).attr('value'),
						success:function(result){
							if(result==1){
								$(this).removeClass("btn_favor_click");
								$(this).addClass("btn_favor");
								$(this).attr("id","btn_favor");
								location.reload();
							}
						}
					});
				}
		});
		
		/* $("button[name=btn_f]").click(function(){
			var btn_f = $(this).attr("id");
			
			if(btn_f == "btn_favor"){
				//버튼 모양 체크
				$(this).removeClass("btn_favor");
				$(this).addClass("btn_favor_click");
				$(this).attr("id","btn_favor_click");
			}else{
				//별 모양 체크 해제
				$(this).removeClass("btn_favor_click");
				$(this).addClass("btn_favor");
				$(this).attr("id","btn_favor");
				
			}//if
		}); */
		
		
	});

</script>

</head>
<body>
	<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>
	
	<div class = "content">
		<section class = "m_menu">
			<nav>
			<img src = "http://localhost:9000/br31/images/mybr.PNG">
			<h4>회원님을 위한 배스킨라빈스의 다양한 정보</h4>
				<ul>
					<a href = "mypage.jsp"><img src = "http://localhost:9000/br31/images/1st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/1st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/1st_mypage.PNG'"></a>
					<a href = "mypage_f_shop.jsp"><img src = "http://localhost:9000/br31/images/2st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/2st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/2st_mypage.PNG'"></a>
					<a href = "mypage_f_flavor.jsp"><img src = "http://localhost:9000/br31/images/3st_mypage_onclick.PNG"></a>
					<a href = "mypage_update.jsp"><img src = "http://localhost:9000/br31/images/4st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/4st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/4st_mypage.PNG'"></a>
					<a href = "mypage_unregister.jsp"><img src = "http://localhost:9000/br31/images/5st_mypage.PNG"
					onmouseover="this.src='http://localhost:9000/br31/images/5st_mypage_onclick.PNG'" 
					onmouseout="this.src='http://localhost:9000/br31/images/5st_mypage.PNG'"></a>
				</ul>
			</nav>
		</section>
		<section class = "m3_page">
			<div>
				<span class = "m_title">추천플레이버</span>
				<div class = "r_flavor">
					<ul>
					<%for(MenuVO recvo : reclist){ %>
						<%if(recvo.getRec_flavor() != null){ %>
							<% for(String rec : recvo.getRec_flavor()){ %>
							<% System.out.println(rec); %>
								<% if(namelist.indexOf(rec) == -1){%>
									<li>
										<a href = "http://localhost:9000/br31/menu/menu_icecream_select.jsp?pname=<%=rec%>">
											<span><%=rec %></span>
											<% MenuVO rvo = dao.getRecomandMenu(rec); %>
											<img src = "http://localhost:9000/br31/menu/images/<%=rvo.getPsfile()%>">
										</a>
										<% int result = dao.getStarCount(svo.getId(), rec); %>
										<% System.out.println(result); %>
										<% if(result ==0){ %>
											<button type = "button" class = "btn_favor" id = "btn_favor" name = "btn_f" value ="<%=rec %>"></button>
										<%}else{ %>
											<button type = "button" class = "btn_favor_click" id = "btn_favor_onclick" name = "btn_f" value = "<%=rec%>"></button>
										<% } %>
									</li>
									<% namelist.add(rec); %>
								<% } %>
							<%} %>
						<% } %>	
					<%} %>		
				</ul>	
				</div>
			</div>
		</section>
		<section class = "m3_page" >
			<div>
				<span class = "m_title">내가 좋아하는 플레이버</span>
					<div class = "r_flavor">
						<ul>
							<%for(MenuVO vo : list){ %>
							<li>
								<a href = "http://localhost:9000/br31/menu/menu_icecream_select.jsp?pname=<%=vo.getPname()%>">
									<span><%= vo.getPname() %></span>
									<img src = "http://localhost:9000/br31/menu/images/<%=vo.getPsfile() %>">
								</a>
								<button type = "button" class = "btn_favor_click" id = "btn_favor_onclick" name = "btn_f" value = "<%=vo.getPname()%>"></button>
							</li>
							<%} %>	
						</ul>	
				</div>
			</div>	
		</section>
		<section class = "m3_image">	
			<div class = "m_f_image">	
				<a href = "#"><img src = "http://localhost:9000/br31/images/btn_favor.jpg"></a>
			</div>	
		</section>
	</div>
	<!-- content -->
	
	<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
</body>
</html>
<% }else{%>
	<script>
		window.alert("로그인후 사용이 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %>