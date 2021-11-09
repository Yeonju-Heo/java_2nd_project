<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){

		VocDAO dao = new VocDAO();
		String id = svo.getId();
		String rpage = request.getParameter("page");
		
		int startCount = 0;
		int endCount = 0;
		int pageSize = 10;	
		int reqPage = 1;	
		int pageCount = 1;	
		int dbCount = dao.execTotalCount(id);
		
		if(dbCount % pageSize == 0){
			pageCount = dbCount/pageSize;
		}else{
			pageCount = dbCount/pageSize + 1;
		}
		
		if(rpage != null){
			reqPage = Integer.parseInt(rpage);
			startCount = dbCount - (reqPage - 1) * pageSize;
			if(startCount > pageSize) {
				endCount = startCount - pageSize + 1;
			} else {
				endCount = 1;
			}
			
		}else{
			startCount = dbCount;
			endCount = dbCount - pageSize + 1;
		}
		
		ArrayList<VocVO> list = dao.getList(id, startCount, endCount);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 문의함</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
	$(document).ready(function(){
		
		var pager = jQuery("#ampaginationsm").pagination({
			
		    maxSize: 10,	    		// max page size
		    totals: <%=dbCount%>,	// total pages	
		    page: <%=rpage%>,		// initial page		
		    pageSize: 10,			// max number items per page
		
		    // custom labels		
		    prevText: "&lt;",		
		    nextText: "&gt;",
				     
		    btnSize:"sm"	
		});
		
		jQuery("#ampaginationsm").on("am.pagination.change",function(e){
			   jQuery(".showlabelsm").text("The selected page no: "+e.page);
	           $(location).attr("href", "http://localhost:9000/br31/voc/voc_list.jsp?page="+e.page);         
	    });
		
 	});
</script> 
</head>
<body>
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
	<jsp:include page="cs_header.jsp"></jsp:include>
	
	<!-- content -->
	<div class="cs_content">
		<section class="voc_list">
			<h3>내 문의함</h3>
			<div class="voc_list_content">
				<table>
					<tr>
						<th>번호</th>
						<th>상담유형</th>
						<th>내용유형</th>
						<th>제목</th>
						<th>접수일</th>
						<th>상태</th>
					</tr>
					<% if(list.size()!=0) { %>
						<% for(VocVO vo : list) { %>
						<tr>
							<td><%= vo.getRno() %></td>
							<td><%= vo.getQtype() %></td>
							<td><%= vo.getCtype() %></td>
							<td><a href="http://localhost:9000/br31/voc/voc_content.jsp?vid=<%=vo.getVid()%>"><%= vo.getTitle() %></a></td>
							<td><%= vo.getVdate() %></td>
							<% if(vo.getStatus()=="답변완료") { %>
							<td style="color:#ff7c97"><%= vo.getStatus() %></td>
							<% } else { %>
							<td style="color:darkgray"><%= vo.getStatus() %></td>
							<% } %>
						</tr>
						<% } %>
					<% } else { %>
						<tr><td colspan=6>문의 내역이 없습니다.</td></tr>
					<% } %>
				</table>
				<div id="ampaginationsm"></div>
			</div>
		</section>	
	</div>
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>
<% }else{%>
	<script>
		window.alert("로그인 후 사용 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %>