<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.br31.vo.EventVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.br31.dao.EventDAO"%>
<%@page import="com.br31.comms.Commons"%>
<%
	//
String rpage = request.getParameter("page");
EventDAO dao = new EventDAO();
Commons commons = new Commons();
HashMap<String, Integer> map = commons.getPage(rpage, dao);
//System.out.println(map.get("start"));
//System.out.println(map.get("end"));
ArrayList<EventVO> list = dao.getList(1, 20);

//페이징 처리 - startCount, endCount 구하기
/* int startCount = 0;
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
*/

//EventDAO dao = new EventDAO();
//ArrayList<BoardVO> list = dao.getList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/br31.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
	$(document).ready(
			function() {

				var pager = jQuery('#ampaginationsm').pagination({

					maxSize : 7, // max page size
					totals :<%=map.get("dbCount")%>, // total pages	
					page :<%=map.get("rpage")%>, // initial page		
					pageSize : <%=map.get("pageSize")%>, // max number items per page

					// custom labels		
					lastText : '&raquo;&raquo;',
					firstText : '&laquo;&laquo;',
					prevText : '&laquo;',
					nextText : '&raquo;',

					btnSize : 'sm' // 'sm'  or 'lg'		
				});

				jQuery('#ampaginationsm').on(
						'am.pagination.change',
						function(e) {
							jQuery('.showlabelsm').text(
									'The selected page no: ' + e.page);
							$(location).attr(
									'href',
									"http://localhost:9000/br31/event/event_list.jsp?page="
											+ e.page);
						});

			});
</script>
</head>
<body id="br_event">
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
		
	<!-- content -->
	<article class="br_event_list">
	<div id="content">
        <div class="inner_content">
            <div class="event_wrap">
                <h3 class="line_title">
					<span>
						<img src="../images/eventtitle.png" alt="event">
					</span>
                    배스킨라빈스와 함께 하는 다양한 혜택과 이벤트
                </h3>
                <div class="tabmenu">
                    <ul>
                        <li class="all">
                            <a href="event_list.jsp" class="on">ALL</a>
                        </li>
                        <li class="store">
                            <a href="event_list.jsp">STORE EVENT</a>
                        </li>
                        <li class="online">
                            <a href="event_list.jsp">ONLINE EVENT</a>
                        </li>
                        <!-- li class="mobile">
							<a href="/event/list.php?flag=D">MOBILE EVENT</a>
						</li -->
                        <li class="happypoint">
                            <a href="event_list.jsp">HAPPYPOINT EVENT </a>
                        </li>
                    </ul>
                </div>
                <div class="event_list">
                    <ul>

                        <!-- <li>
                            <a href="/menu/fom.php#area4">
                                <figure><img src="../images/banner_flavor_month_insta_1907.png" alt="HASHTAG EVENT"></figure>
                                <span class="type"><img src="../images/stit_online.gif" alt="ONLINE EVENT"></span>
                                <span class="title">핑크 스타 사진을 인스타그램에 올려주세요!</span>
                                <span class="period">2019-07-01~2019-07-26</span>
                            </a>
                        </li> 
						
						<li>
                            <a href="/menu/fom.php#area4">
                                <figure><img src="../images/banner_flavor_month_insta_2010.png" alt="HASHTAG EVENT"></figure>
                                <span class="type"><img src="../images/stit_online.gif" alt="ONLINE EVENT"></span>
                                <span class="title">미찐 감자 사진을 인스타그램에 올려주세요!</span>
                                <span class="period">2020-10-01~2020-10-26</span>
                            </a>
                        </li>-->
						<%
					// 공지사항 목록 생성
				StringBuffer tbody = new StringBuffer("");
				for (EventVO vo : list) {
					tbody.append("<li>");
					tbody.append("<a href='event_content.jsp?articleno=" + vo.getArticleno() + "&rno=" + vo.getRno() + "'>");					
					tbody.append("<figure><img src='http://localhost:9000/br31/upload/" + vo.getNfile() + "' alt=''></figure>");
					tbody.append("<span class='title'>"+vo.getTitle()+"</span>");
					tbody.append("<span class=\"period\">" + vo.getMdate() + "</span>");
					tbody.append("</a>");
					tbody.append("</li>");
				}
				out.write(tbody.toString());
				%>

                    </ul>
                </div>
            </div>

        </div>

    </div>
	</article>
	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>