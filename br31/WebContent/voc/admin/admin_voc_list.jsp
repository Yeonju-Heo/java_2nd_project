<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.*, java.util.*" %>
<%
	SessionVO svo = (SessionVO) session.getAttribute("svo");
	if(svo != null && svo.getId().equals("admin")) {
		VocDAO dao = new VocDAO();
		
		String status = request.getParameter("status");
		String rpage = request.getParameter("page");
		String qtype = request.getParameter("qtype");
		String ctype = request.getParameter("ctype");
		String keyword = request.getParameter("keyword");
		
		if(qtype==null) qtype = "상담유형";
		if(ctype==null) ctype = "내용유형";
		
		int startCount = 0;
		int endCount = 0;
		int pageSize = 10;	
		int reqPage = 1;	
		int pageCount = 1;	
		int dbCount = dao.execTotalCount(qtype, ctype, status, keyword);
		
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
		
		ArrayList<VocVO> list = dao.getList(qtype, ctype, startCount, endCount, status, keyword);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 문의함</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css"><link rel="stylesheet" href="http://localhost:9000/br31/css/cs.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
$(document).ready(function() {
 	
	if("<%=qtype%>" != "상담유형") $("#sqtype").val("<%=qtype%>").prop("selected",true);
	if("<%=ctype%>" != "내용유형") $("#sctype").val("<%=ctype%>").prop("selected",true);
	
 	$("#sqtype, #sctype").change(function() {
 		var params = "";
 		var $sqtype = $("#sqtype");
 		var $sctype = $("#sctype");
 		
		if($sqtype.val() != "상담유형") params += "&qtype="+$sqtype.val();
		if($sctype.val() != "내용유형") params += "&ctype="+$sctype.val();
		if("<%=keyword%>" != "null") params += "&keyword=<%=keyword%>";
		
		$(location).attr("href", "http://localhost:9000/br31/voc/admin/admin_voc_list.jsp?status=<%=status%>"+ params);         
	});

	var pager = jQuery("#ampaginationsm").pagination({
	    maxSize: 10,	  
	    totals: <%=dbCount%>,	
	    page: <%=rpage%>,	
	    pageSize: 10,
	
	    // custom labels		
	    lastText: "&raquo;&raquo;", 		
	    firstText: "&laquo;&laquo;",		
	    prevText: "&lt;",		
	    nextText: "&gt;",
			     
	    btnSize:"sm"	
	});
	
	jQuery("#ampaginationsm").on("am.pagination.change",function(e){
		jQuery(".showlabelsm").text("The selected page no: "+e.page);
		var params = "";
		
		if("<%=qtype%>" != "상담유형") params += "&qtype=<%=qtype%>";
		if("<%=ctype%>" != "내용유형") params += "&ctype=<%=ctype%>";
		if("<%=keyword%>" != "null") params += "&keyword=<%=keyword%>";
		
		$(location).attr("href", "http://localhost:9000/br31/voc/admin/admin_voc_list.jsp?status=<%=status%>"+ params +"&page="+e.page);         
    });

	$("#btnVocSearch").click(function() {
		if($("#voc_search").val() == "") {
			alert("검색어를 입력해주세요.");
			$("#voc_search").focus();
			return false;
		} else {
			var params = "";
			
			if("<%=qtype%>" != "상담유형") params += "&qtype=<%=qtype%>";
			if("<%=ctype%>" != "내용유형") params += "&ctype=<%=ctype%>";
			params += "&keyword=" + $("#voc_search").val();
			
			console.log(params);
			$(location).attr("href", "http://localhost:9000/br31/voc/admin/admin_voc_list.jsp?status=<%=status%>"+ params);
		}
		
	});

});//ready
</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../../admin_header.jsp"></jsp:include>
	<jsp:include page="admin_cs_header.jsp"></jsp:include>
	
	<!-- content -->
	<div class="cs_content">
		<section class="voc_list">
			<h3>[관리자] 고객센터 문의 목록</h3>
			<div class="voc_list_content">
				<div class="voc_search_bar">
					<select id="sqtype">
						<option value="상담유형">상담유형</option>
						<option value="칭찬">칭찬</option>
						<option value="불만">불만</option>
						<option value="문의">문의</option>
						<option value="제안">제안</option>
						<option value="제보">제보</option>
					</select>
					<select id="sctype">
						<option value="내용유형">내용유형</option>
						<option value="제품">제품</option>
						<option value="인적서비스">인적서비스</option>
						<option value="점포서비스">점포서비스</option>
						<option value="이벤트">이벤트</option>
						<option value="HP카드">HP카드</option>
						<option value="모바일쿠폰">모바일쿠폰</option>
						<option value="기타">기타</option>
					</select>
					<input type="text" id="voc_search">
					<button type="button" id="btnVocSearch">검색</button>
				</div>
				<div class="list">
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
								<% if(vo.getStatus().equals("답변대기")) { %>
									<td><a href="http://localhost:9000/br31/voc/admin/admin_voc_write.jsp?vid=<%=vo.getVid()%>"><%= vo.getTitle() %></a></td>
								<% } else { %>
									<td><a href="http://localhost:9000/br31/voc/admin/admin_voc_content.jsp?vid=<%=vo.getVid()%>"><%= vo.getTitle() %></a></td>
								<% } %>
								<td><%= vo.getVdate() %></td>
								<td><%= vo.getStatus() %></td>
							</tr>
							<% } %>
						<% } else { %>
							<tr><td colspan=6>일치하는 글이 없습니다.</td></tr>
						<% } %>
					</table>
				</div>
				<div id="ampaginationsm"></div>
			</div>
		</section>	
	</div>
	<!-- footer -->
	<jsp:include page="../../footer.jsp"></jsp:include>

</body>
</html>
<%	} else {%>
	<script>
		alert("접근 권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<%	} %>