<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.VocDAO, com.br31.vo.VocVO, java.util.*" %>
<%
	VocDAO dao = new VocDAO();
	
	String status = request.getParameter("status");
	String rpage = request.getParameter("page");
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
$(document).ready(function() {
	
	var pageCount = 0;
	get_list("상담유형", "내용유형", "<%=status%>", "<%=rpage%>");
	
	//유형 선택
 	$("#sqtype, #sctype").one("change", function() {
		get_list($("#sqtype").val(), $("#sctype").val(), "<%=status%>", "<%=rpage%>");
	});
	
	//리스트  가져오기
	function get_list(qtype, ctype, status, rpage) {
		$.ajax({
			url: "get_list수정중.jsp?qtype="+ qtype + "&ctype=" + ctype + "&status=" + status + "&rpage=" + rpage,
			success: function(result) {
				var jdata = JSON.parse(result);
				var data = "";
				
				for(var i in jdata.jlist) {
					data += "<tr>";
					data += "<td>" + jdata.jlist[i].rno + "</td>";
					data += "<td>" + jdata.jlist[i].qtype + "</td>";
					data += "<td>" + jdata.jlist[i].ctype + "</td>";
					data += "<td><a href='" + jdata.jlist[i].link + "'>" + jdata.jlist[i].title + "</a></td>";
					data += "<td>" + jdata.jlist[i].vdate + "</td>";
					data += "<td>" + jdata.jlist[i].status + "</td>";
					data += "</tr>";
				}
				var dbCount = jdata.dbCount;
				var rpage = jdata.rpage;
				var pageSize = jdata.pageSize;
				
				$("#column_name").siblings("tr").remove();
				$("#column_name").after(data);

				paging(dbCount, rpage, pageSize, qtype, ctype, status);
			}
		});
	}
	
	function paging(count, rpage, pSize, qtype, ctype, status) {
		var pager = jQuery("#ampaginationsm").pagination({
	
		    maxSize: 10,	    		// max page size
		    totals: count,	// total pages	
		    page: rpage,		/* // initial page	 */	
		    pageSize: pSize,			// max number items per page
		
		    // custom labels		
		    lastText: "&raquo;&raquo;", 		
		    firstText: "&laquo;&laquo;",		
		    prevText: "&lt;",		
		    nextText: "&gt;",
				     
		    btnSize:"sm"	
		});
		
		jQuery("#ampaginationsm").one("am.pagination.change",function(e){
			jQuery(".showlabelsm").text("The selected page no: "+e.page);
				get_list(qtype, ctype, status, +e.page); //페이지 이동 잘 되나 유형 선택 시 무한 새로고침.. 
				get_list(qtype, ctype, status, rpage); //유형 출력 잘 되나 페이지 이동 안 됨
	    });
	}
	
/* 	$("#btnVocSearch").click(function() {
		var link = "http://localhost:9000/br31/voc/admin/admin_voc_list.jsp?qtype="+ $("#sqtype").val()
				+ "&ctype=" + $("#sctype").val() + "&status=" + status + "&keyworld=" + $("#voc_search").val();
        $(location).attr("href", link);         
	}); */
	
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
						<tr id="column_name">
							<th>번호</th>
							<th>상담유형</th>
							<th>내용유형</th>
							<th>제목</th>
							<th>접수일</th>
							<th>상태</th>
						</tr>
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