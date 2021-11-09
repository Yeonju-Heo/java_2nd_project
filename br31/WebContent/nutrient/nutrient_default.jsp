<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.br31.dao.*, com.br31.vo.*, java.util.*"%>
<% 
	String category = request.getParameter("category");
	if(category==null){
		category = "all";
	}
	String rpage = request.getParameter("page");
	MenuDAO dao = new MenuDAO();
	
	int startCount = 0;
	int endCount = 0;
	int pageSize = 20;	//한 페이지당 게시물 수
	int reqPage = 1;	//요청페이지
	int pageCount = 1;	//전체페이지 수
	int dbCount = 0;
	
	if(rpage!=null){
		reqPage = Integer.parseInt(rpage);
		startCount = (reqPage-1)*pageSize+1;
		endCount = reqPage * pageSize;
	}else{
		startCount = 1;
		endCount = pageSize;
	}
	String pname="";
	String nutrient="";
	String sorting="";
	String[] allergies= null;
	String all_line ="";
	
	ArrayList<MenuVO> list;	
	boolean search = false;
	if(request.getParameter("pname")==null &&request.getParameter("nutrient")==null
		&&request.getParameter("sorting")==null && request.getParameter("allergy")==null){		//header에서 갓 넘어갔을때
		search=false;
		list = dao.getAllNutrientsList(category, startCount, endCount);	
		dbCount = dao.getDbCount(category);	//DB에서 가져온 전체 행수
	}else{
		/*
		String pname = request.getParameter("pname");
		String nutrient = request.getParameter("nutrient");
		String sorting = request.getParameter("sorting");
		String[] allergies = request.getParameterValues("allergy");
		*/
		pname = request.getParameter("pname");
		nutrient = request.getParameter("nutrient");
		sorting = request.getParameter("sorting");
		allergies = request.getParameterValues("allergy");
		all_line ="";
		if(allergies!=null){
			for(int i=0;i<allergies.length;i++){
				if(i==allergies.length-1){
					all_line += "allergy="+ allergies[i];
				}else{
					all_line += "allergy="+ allergies[i] + "&";
				}
			}
		}
		search=true;
		if(pname.equals("")&&nutrient.equals("전체")&&sorting.equals("전체")&&allergies==null){
			list = dao.getAllNutrientsList(category, startCount, endCount);
			dbCount = dao.getDbCount(category);	//DB에서 가져온 전체 행수
		}else{
			list = dao.getNutrientSearchResult(category,pname,nutrient,sorting,allergies, startCount, endCount);
			dbCount = dao.getNutrientSearchResultCount(category,pname,nutrient,sorting,allergies);
 		}
	}
	
	dao.close();
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
<link rel="stylesheet" href="http://localhost:9000/br31/nutrient/nutrient.css">
<link rel="stylesheet" href="http://localhost:9000/br31/css/am-pagination.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script src="http://localhost:9000/br31/js/am-pagination.js"></script>
<script>
	$(document).ready(function(){
		$("#btn_search").click(function(){
			if($("#nutrient").val()=="전체" && $("#sorting").val()!="전체"){
				alert("영양성분을 선택해주세요.");
				return false;
			}else{
				nutrient_search.submit();
			}
		});
		
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
			  <% if(search==false){ %>
	          		$(location).attr("href", "http://localhost:9000/br31/nutrient/nutrient_default.jsp?category=<%=category%>&page="+e.page);
	          	<%}else{%>
	          	 	$(location).attr("href", "http://localhost:9000/br31/nutrient/nutrient_default.jsp?category=<%=category%>&pname=<%=pname%>&nutrient=<%=nutrient%>&sorting=<%=sorting%>&<%=all_line%>&page="+e.page);
	           <%}%>
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
	<section class="text_info">
	<div class="title">
		<div class="title_left"></div>
			<img src="http://localhost:9000/br31/nutrient/images/h_title_nutrition.png">
		<div class="title_right"></div>
	</div>
	<label>배스킨라빈스 제품의 영양정보를 확인해보세요</label>
	</section>
	<section class="search_form">
	<form name="nutrient_search" action="nutrient_default.jsp" method="get" class="nutrient_search">
	<input type="hidden" name="category" value="<%=category%>">
		<ul>
			<li>
				<label class="title">제품명</label>
				<input type="text" name = "pname" class="p_name">
			</li>
			<li>
				<label class="title">영양성분</label>
				<select name="nutrient" id="nutrient">
					<option value="전체">전체</option>
					<option value="kcal">열량</option>
					<option value="natrium">나트륨</option>
					<option value="sugar">당류</option>
					<option value="fat">포화지방</option>
					<option value="protein">단백질</option>
					<option value="caffeine">카페인</option>
				</select>
				<select name="sorting" id="sorting">
					<option value="전체">전체</option>
					<option value="높은순">높은순</option>
					<option value="낮은순">낮은순</option>
				</select>
			</li>
			<li>
				<label class="title">알레르기</label>
				<input type="checkbox" id="allergy1" name="allergy" value="계란">
				<label for="allergy1">계란</label>&nbsp;
				<input type="checkbox" id="allergy2" name="allergy" value="대두">
				<label for="allergy2">대두</label>&nbsp;
				<input type="checkbox" id="allergy3" name="allergy" value="돼지고기">
				<label for="allergy3">돼지고기</label>&nbsp;
				<input type="checkbox" id="allergy4" name="allergy" value="땅콩">
				<label for="allergy4">땅콩</label>&nbsp;
				<input type="checkbox" id="allergy5" name="allergy" value="밀">
				<label for="allergy5">밀</label>&nbsp;
				<input type="checkbox" id="allergy6" name="allergy" value="복숭아">
				<label for="allergy6">복숭아</label>&nbsp;
				<input type="checkbox" id="allergy7" name="allergy" value="우유">
				<label for="allergy7">우유</label>&nbsp;
				<input type="checkbox" id="allergy8" name="allergy" value="호두">
				<label for="allergy8">호두</label>&nbsp;
				<input type="checkbox" id="allergy9" name="allergy" value="쇠고기">
				<label for="allergy9">쇠고기</label>&nbsp;
				<input type="checkbox" id="allergy10" name="allergy" value="오징어">
				<label for="allergy10">오징어</label><br>
				<input type="checkbox" id="allergy11" name="allergy" value="없음">
				<label for="allergy11">없음</label>&nbsp;
			</li>
			<li>
				<span class="notice_labels">
				<label class="notice">※ 모든 제품은 밀, 대두, 호두, 우유, 땅콩, 돼지고기, 복숭아, 계란, 쇠고기를 사용한 제품과 같은 제조 시설에서 제조되었습니다.</label>
				<label class="notice">※ 어린이, 임산부 및 카페인에 민감한 사람은 섭취에 주의해 주시기 바랍니다. (고카페인 함유)</label>
				<label class="notice">※ 카페인 함량 "-"은 해당없음을 의미합니다.</label>
				</span>
			</li>
			<li>
				<button type="button" class="btn_search" id="btn_search">검색</button>
			</li>
		</ul>
	</form>
	</section>
	<section class="search_result">
		<img src="http://localhost:9000/br31/nutrient/images/h_nutrition_result.png" class="title">
		<div><label class="search_result">검색 결과 총 </label><label class="search_count"><%=dbCount %></label><label class="search_result">건 검색되었습니다.</label></div>
		<table class="search_result">
			<tr>
				<th>제품명</th>
				<th>1회 제공량(g)</th>
				<th>열량(kcal)</th>
				<th>나트륨(mg)</th>
				<th>당류(g)</th>
				<th>포화지방(g)</th>
				<th>단백질(g)</th>
				<th>카페인(mg)</th>
				<th>알레르기 성분</th>
			</tr>
			
			<% 
			if(list.size()!=0){
				for(MenuVO vo:list){
					if(vo.getOne_amount()==null){
						vo.setOne_amount("-");
					}
					if(vo.getKcal()==null){
						vo.setKcal("-");
					}
				%>
					<tr>
						<td><%= vo.getPname() %></td>
						<td><%= vo.getOne_amount() %></td>
						<td><%= vo.getKcal() %></td>
						<td><%= vo.getNatrium() %></td>
						<td><%= vo.getSugar() %></td>
						<td><%= vo.getFat() %></td>
						<td><%= vo.getProtein() %></td>
						<td><%= vo.getCaffeine() %></td>
						
						<td>
						<%
						String allergy = "";
						if(vo.getAllergy()!=null){
							for(int i=0; i<vo.getAllergy().length; i++){ 
								if(i==vo.getAllergy().length-1){ 
								allergy += vo.getAllergy()[i];
								}else{
								allergy += vo.getAllergy()[i] + ", "; 
								}
							}
						}else{
							allergy = "없음";
						}%>
						<%=allergy %></td>
					</tr>			
				<% 
				}
			}
			%>
		</table>
	</section>
	<section class="pagination">
	<div class="pagination" id="pagination">
		<div id="ampaginationsm"></div>
	</div>
	</section>
	</section>
</div>

<!-- footer -->
	<jsp:include page = "../footer.jsp"></jsp:include>

</body>
</html>