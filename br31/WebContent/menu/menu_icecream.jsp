<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.*, com.br31.vo.*, java.util.*, com.br31.comms.*" %>
<% 
	String rpage = request.getParameter("page");
	MenuDAO dao = new MenuDAO();
	
	int startCount = 0;
	int endCount = 0;
	int pageSize = 20;	//한 페이지당 게시물 수
	int reqPage = 1;	//요청페이지
	int pageCount = 1;	//전체페이지 수
	
	if(rpage!=null){
		reqPage = Integer.parseInt(rpage);
		startCount = (reqPage-1)*pageSize+1;
		endCount = reqPage * pageSize;
	}else{
		startCount = 1;
		endCount = pageSize;
	}
	
	String category="icecream";
	ArrayList<MenuVO> list = dao.getMenuIcecreamList(category, startCount, endCount);
	
	int dbCount = dao.getDbCount(category);	//DB에서 가져온 전체 행수

	if(dbCount % pageSize ==0){
		pageCount = dbCount/pageSize;
	}else{
		pageCount = dbCount/pageSize+1;
	}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/menu_list.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
	$(document).ready(function(){
	
		var pager = jQuery("#ampaginationsm").pagination({
			
		    maxSize: 10,	    		// max page size
		    totals: <%=dbCount%>,	// total pages	
		    page: <%=rpage%>,		// initial page		
		    pageSize: <%=pageSize %>,			// max number items per page
		
		    // custom labels		
		    prevText: "&lt;",		
		    nextText: "&gt;",
				     
		    btnSize:"sm"	
		});
		
		jQuery("#ampaginationsm").on("am.pagination.change",function(e){
			   jQuery(".showlabelsm").text("The selected page no: "+e.page);
	           $(location).attr("href", "http://localhost:9000/br31/menu/menu_icecream.jsp?page="+e.page);         
	    });
		<%if(dbCount<pageSize){%>
			$("#pagination").hide();
		<%}%>
	});
</script>
</head>
<body>

<!-- header -->
	<jsp:include page = "../header.jsp"></jsp:include>

<!-- content -->
<div class="content">
	<section class="page">
	<section class="logo_icecream">
	</section>
<!-- common part -->
	<jsp:include page = "menu_monthly_icecream.jsp"></jsp:include>
	
	
<!-- ************icecream menu **********-->
<!-- ************icecream menu **********-->
<!-- ************icecream menu **********-->
<!-- ************icecream menu **********-->
<!-- ************icecream menu **********-->


	<section class="icecream_menu">
		<div class="icecream_menu">
		<table class="icecream_menu">
			<% 
				int i=1;
				for(MenuVO vo : list){ 
					if(i%4==1){%>
					<tr>
					<% }%>
					<td>
						<a href="menu_icecream_select.jsp?pname=<%=vo.getPname()%>&category=<%=category %>" class="outer">
							<span class="depth1">
							<%if(vo.getSet_check()==0){ %>
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
							<%}else{ 
								%>
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
					</td>
				<% 
				if(i%4==0 || vo.getPname().equals(list.get(list.size()-1).getPname())){ %>
					</tr>
			  <%}
				i++;
				}%>


			</table>
		</div>
	</section>
	
	
	<!-- **************page********* -->
	<!-- **************page********* -->
	<!-- **************page********* -->
	
	<div class="pagination" id="pagination">
		<div id="ampaginationsm"></div>
	</div>
	</section>	
</div>

<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>
</body>
</html>