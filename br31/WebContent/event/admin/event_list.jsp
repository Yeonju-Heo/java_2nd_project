<%@page import="java.util.ArrayList"%> 
<%@page import="com.br31.dao.EventDAO"%>
<%@page import="com.br31.vo.EventVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String rpage = request.getParameter("page");
	EventDAO dao = new EventDAO();	
	
	//페이징 처리 - startCount, endCount 구하기
	int startCount = 0;
	int endCount = 0;
	int pageSize = 5;	//한페이지당 게시물 수
	int reqPage = 1;	//요청페이지	
	int pageCount = 1;	//전체 페이지 수
	int dbCount = dao.execTotalCount();	//DB에서 가져온 전체 행수
	
	//총 페이지 수 계산
	if(dbCount % pageSize == 0){
		pageCount = dbCount/pageSize;
	}else{
		pageCount = dbCount/pageSize+1;
	}
	
	//요청 페이지 계산
	if(rpage != null){
		reqPage = Integer.parseInt(rpage);
		startCount = (reqPage-1) * pageSize+1;
		endCount = reqPage *pageSize;
	}else{
		startCount = 1;
		endCount = 5;
	}
	
	ArrayList<EventVO> list = dao.getList(startCount, endCount);
	
	//EventDAO dao = new EventDAO();
	//ArrayList<BoardVO> list = dao.getList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/admin_br31_m.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
	$(document).ready(function(){
		
		var pager = jQuery('#ampaginationsm').pagination({
		
		    maxSize: 7,	    		// max page size
		    totals: <%=dbCount%>,	// total pages	
		    page: <%=rpage%>,		// initial page		
		    pageSize: 5,			// max number items per page
		
		    // custom labels		
		    lastText: '&raquo;&raquo;', 		
		    firstText: '&laquo;&laquo;',		
		    prevText: '&laquo;',		
		    nextText: '&raquo;',
				     
		    btnSize:'sm'	// 'sm'  or 'lg'		
		});
		
		jQuery('#ampaginationsm').on('am.pagination.change',function(e){
			   jQuery('.showlabelsm').text('The selected page no: '+e.page);
	           $(location).attr('href', "http://localhost:9000/br31/event/admin/event_list.jsp?page="+e.page);         
	    });
		
 	});
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>

	<!-- content -->
	<div class="content">
		<section class="board_list">
			<h3 class="line_title">
				<span> <img src="../../images/eventtitle.png" alt="event">
				</span> [관리자] 이벤트
			</h3>
			<table class="content_layout">
				<tr>
					<td colspan="3">
						<a href="event_write.jsp">
							<button type="button">글쓰기</button>
						</a>
					</td>
				</tr>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
				</tr>
				<%
					// 이벤트 목록 생성
				StringBuffer tbody = new StringBuffer("");
				for (EventVO vo : list) {
					tbody.append("<tr>");
					tbody.append("<td>" + vo.getRno() + "</td>");
					tbody.append("<td>");
					tbody.append("	<a href='event_content.jsp?articleno="+vo.getArticleno()+"&rno=" + vo.getRno() + "'>" + vo.getTitle() + "</a>");
					tbody.append("</td>");
					tbody.append("<td>" + vo.getMdate() + "</td>");
					tbody.append("</tr>");
				}
				out.write(tbody.toString());
				%>
				<tr>
					<td colspan=3><div id="ampaginationsm"></div></td>
				</tr>
			</table>
		</section>
	</div>

	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>
</body>
</html>