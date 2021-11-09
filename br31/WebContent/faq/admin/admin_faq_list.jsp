<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.FaqDAO, com.br31.vo.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO) session.getAttribute("svo");
	if(svo != null && svo.getId().equals("admin")) {
	
		String ftype = request.getParameter("ftype");
		String rpage = request.getParameter("page");
	
		if(ftype == null) { ftype = "all"; }
		
		FaqDAO dao = new FaqDAO();
	
		int startCount = 0;
		int endCount = 0;
		int pageSize = 10;	
		int reqPage = 1;	
		int pageCount = 1;	
		int dbCount = dao.execTotalCount(ftype);
		
		if(dbCount % pageSize == 0){
			pageCount = dbCount/pageSize;
		}else{
			pageCount = dbCount/pageSize + 1;
		}
		
		if(rpage != null){
			reqPage = Integer.parseInt(rpage);
			startCount = (reqPage - 1) * pageSize + 1;
			endCount = reqPage *pageSize;
		}else{
			startCount = 1;
			endCount = 10;
		}
		
		ArrayList<FaqVO> list = dao.getList(ftype, startCount, endCount);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
$(document).ready(function() {
	
	$(".faq_type li").each(function() {
		if( $(this).attr("class") == getUrlFtype() ) {
			$(this).children("a").css({	"background-color":"#92867f", "color":"white"});
		}
	})
	
	function getUrlFtype() {
		var search = window.location.search;
		var params = search.substring(1).split("&");
		var result = {};
		
		for(var i=0; i<params.length; i++) {
			result[i] = params[i].split("=");
		}
		
		if(search!="") {
			return result[0][1];
		} else {
			return "all";
		}
	}
	
	$(".faq_title").click(function() {
		
		var $parent = $(this).parent("li");
		
		$(".faq_title").next(".answer").slideUp();
		$parent.siblings().removeClass("on"); 
		$parent.siblings().removeClass("on_last"); 


		if($parent.is(':last-child')) {
			$parent.toggleClass("on_last"); 
		} else {
			$parent.toggleClass("on"); 
		}
		
		if($parent.hasClass("on") || $parent.hasClass("on_last")) {
			$(this).next(".answer").slideDown();
		} else {
			$(this).next(".answer").slideUp();
		}
	});
	
	$(".btnFaqDelete").click(function(){
		var con = confirm("삭제하시겠습니까?");
 		if(con) {
			$(location).attr("href", "adminFaqDeleteProcess.jsp?fid="+$(".btnFaqDelete").val());
		}
	});
	
	var pager = jQuery("#ampaginationsm").pagination({
		
	    maxSize: 10,	    		// max page size
	    totals: <%=dbCount%>,	// total pages	
	    page: <%=rpage%>,		// initial page		
	    pageSize: 10,			// max number items per page
	
	    // custom labels		
	    lastText: "&raquo;&raquo;", 		
	    firstText: "&laquo;&laquo;",		
	    prevText: "&lt;",		
	    nextText: "&gt;",
			     
	    btnSize:"sm"	
	});
	
	jQuery("#ampaginationsm").on("am.pagination.change",function(e){
		   jQuery(".showlabelsm").text("The selected page no: "+e.page);
           $(location).attr("href", "http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=<%=ftype%>&page="+e.page);         
    });

});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>
	<jsp:include page="admin_cs_header.jsp"></jsp:include>
		
	<!-- content -->
	<div class="cs_content">
		<section class="faq">
			<div class="faq_board">
				<h3>[관리자] 고객센터 FAQ</h3>
				<a href="admin_faq_write.jsp" class="btnFaqWrite"><button type="button" id="btnFaqWrite">등록</button></a>
				<div class="faq_type" id="faq_type">
					<ul>
						<li class="all">
							<a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=all">전체</a>
						</li>
						<li class="ftype1">
							<a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=ftype1">제품</a>
						</li>
						<li class="ftype2">
							<a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=ftype2">포인트</a>
						</li>
						<li class="ftype3">
							<a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=ftype3">회원</a>
						</li>
						<li class="ftype4">
							<a href="http://localhost:9000/br31/faq/admin/admin_faq_list.jsp?ftype=ftype4">기타</a>
						</li>
					</ul>
				</div>
				<div class="faq_list">
					<ul>
					<% for(FaqVO vo : list) { %>
						<li>
							<a class="faq_title"><%= vo.getTitle() %></a>
							<div class="answer">
								<div>
									<%= vo.getContent().replace("\r\n", "<br>") %>
									<% if(vo.getFsfile()!=null) { %>
										<img src="http://localhost:9000/br31/upload/<%=vo.getFsfile()%>">
									<% } %>
								</div>
								<a href="admin_faq_update.jsp?fid=<%= vo.getFid() %>" class="btnFaqUpdate"><button type="button">수정</button></a>
								<button type="button" class="btnFaqDelete" id="btnFaqDelete" value="<%=vo.getFid()%>">삭제</button>
							</div>
						</li>
					<% } %>
					</ul>
				</div>
				<div id="ampaginationsm"></div>
			</div>
		</section>	
	</div>
	
	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>

</body>
</html>
<%	} else { %>
	<script>
		alert("접근 권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<%	}%>