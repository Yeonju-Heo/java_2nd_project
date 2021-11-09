<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "com.br31.dao.*,com.br31.vo.*,java.util.*,java.net.URLEncoder" %>
 <%
 SessionVO svo = (SessionVO)session.getAttribute("svo");
	if(svo != null){
	if(svo.getId().equals("admin")){
		
 	String category = request.getParameter("category");
 	String status = request.getParameter("status");
 	if(status.equals("before")){
 		
 	MenuDAO dao = new MenuDAO();
	ArrayList<MenuVO> list = dao.getAdminList(category);
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/menu/css/admin_menu.css">
<script src="http://localhost:9000/br31/js/jquery-3.6.0.min.js"></script>
<script>

	function form_empty(){						//'선택'에 둔 상태로 리셋버튼 누를때 함수
		$("#intro").val("");	//설명
		$("#frame").remove();
		var output = "<span id='frame'>선택된 파일 없음</span>";
		$("#p_image").after(output);
		$("#n_amount").val("");
		$("#n_kcal").val("");
		$("#n_natrium").val("");
		$("#n_sugar").val("");
		$("#n_fat").val("");
		$("#n_protein").val("");
		$("#n_caffeine").val("");
		$("input[type=checkbox]").removeAttr("checked");
	}

	function ajax_content(pname){						//ajax. 맛 고를때마다 실행
		$.ajax({
			url:"admin_menu_update_ajax.jsp?pname="+pname,
			success:function(result){
				//실행결과에 따른 처리.
				var jdata = JSON.parse(result);
				$("#eng_pname").val(jdata.eng_pname);	//영문명
				$("#intro").val(jdata.intro);	//설명
				$("input[type=radio]").removeAttr("checked");	//정렬방식
				$("input[value="+jdata.order_type+"]").attr("checked","checked");
				
				$("#selected_rec_flavor").empty();	//추천플레이버
				var output = "";
				if(jdata.rec_flavor!=""){
					var list_r = jdata.rec_flavor.split(",");
					for(var i=0;i<list_r.length;i++){
						output += "<span>" + list_r[i] + "</span>";
						output += "<input type='hidden' name='rec_flavor' id='rec_flavor' value="+list_r[i]+">";
					}
				}
				$("#selected_rec_flavor").append(output);
				
				$("#p_hashtag").val("");	//해쉬태그
				output = "";
				if(jdata.hashtag!=null){
					var list_h = jdata.hashtag.split(",");
					for(var i=0;i<list_h.length;i++){
						if(i==list_h.length-1) {
							output += list_h[i];
						}else {
							output += list_h[i]+",";
						}
					}
					$("#p_hashtag").val(output);
				}
				
				$("#frame").remove();	//메뉴 사진
				output="";
				if(jdata.pfile!=null){
					output += "<span id='frame'>"+jdata.pfile+"</span>";
				}else{
					output += "<span id='frame'>선택된 파일 없음</span>";
				}
				$("#p_image").after(output);
				
				$("#psfile_old").val(jdata.psfile)	//기존사진
				$("#n_amount").val(jdata.one_amount);	//영양성분
				$("#n_kcal").val(jdata.kcal);
				$("#n_natrium").val(jdata.natrium);
				$("#n_sugar").val(jdata.sugar);
				$("#n_fat").val(jdata.fat);
				$("#n_protein").val(jdata.protein);
				$("#n_caffeine").val(jdata.caffeine);
				
				$("input[type=checkbox]").removeAttr("checked");	//알러지
				if(jdata.allergy!=null){
					var list_a = jdata.allergy.split(",");
					for(var i=0;i<list_a.length;i++){
						$("input[value="+list_a[i]+"]").attr("checked","checked");
					}
				}
				
			}//success
		});//ajax
	}//ajax_list function
	
	
	
	$(document).ready(function(){							//document ready
		$("#pname").change(function(){		//이름 select 할 때마다
			var pname = $("#pname").val();
			if(pname!="선택"){		//원래 데이터로 돌려놓음
				ajax_content(pname);
			}else{		//'선택'일 경우 다 지움
				form_empty(num);
			}
		});
		
	
		$("#rec_flavor_list").change(function(){		//추천 플레이버 선택시
			var flavor = $("#rec_flavor_list").val();
			if(flavor.search(/(\s)/)!=-1){
				var re_flavor = flavor.replace(/(\s)/g,'^')
			}
			if(flavor!="선택"){
				if(flavor==$("#pname").val()){
					alert("추천 플레이버는 다른 맛만 선택할 수 있습니다.")
				}else{
					var output = "";
					output += "<span>"+flavor+"</span>";
					output += "<input type='hidden' name='rec_flavor' id='rec_flavor' value="+re_flavor+">";
					$("#selected_rec_flavor").append(output);
					
				}
			}
		});
		$("#btn_flavor").click(function(){
			$("#selected_rec_flavor").empty();
		});
	
	
		$("#n_amount").blur(function(){
			if($("#n_amount").val()==""){
				$("#n_amount").val(0);
			}
		});
		$("#n_kcal").blur(function(){
			if($("#n_kcal").val()==""){
				$("#n_kcal").val(0);
			}
		});
		$("#n_natrium").blur(function(){
			if($("#n_natrium").val()==""){
				$("#n_natrium").val(0);
			}
		});
		$("#n_sugar").blur(function(){
			if($("#n_sugar").val()==""){
				$("#n_sugar").val(0);
			}
		});
		$("#n_fat").blur(function(){
			if($("#n_fat").val()==""){
				$("#n_fat").val(0);
			}
		});
		$("#n_protein").blur(function(){
			if($("#n_protein").val()==""){
				$("#n_protein").val(0);
			}
		});
		$("#n_caffeine").blur(function(){
			if($("#n_caffeine").val()==""){
				$("#n_caffeine").val(0);
			}
		});
		
		$("input[type=file]").on('change',function(){				//파일 선택시
			if(window.FileReader){
				var filename = $(this)[0].files[0].name;
				$("#frame").text("").text(filename);
			}
		});
		
		$("#btn_reset").click(function(){						//리셋버튼누를때
			var pname = $("#pname option:selected").val();
			if(pname!="선택"){
				ajax_content(pname);
			}else{
				form_empty();
			}
		});
		
		$("#btn_update").click(function(){						//수정버튼누를때
			if($("#pname option:selected").val()=="선택"){
				alert("수정할 메뉴를 선택해 주세요");
				$("#pname").focus();
				return false;
			}else if($("#intro").val()==""){
				alert("메뉴 설명을 입력해 주세요");
				$("#intro").focus();
				return false;
			}else if($("#frame").text()=="선택된 파일 없음"){
				alert("메뉴 사진을 등록해 주세요");
				return false;
			}else{
				var check = confirm("메뉴를 등록하시겠습니까?");
				if(check==true){
					menu_update.submit();
				}else{
					return false;
				}
			}
		});
	});//document.ready
	
</script>
</head>
<body>
<!-- content -->
<section class="page_update">
<h3 class="title">메뉴 수정</h3>
<div class="content_update">
	<form name="menu_update" action="admin_menu_update_process.jsp?category=<%=category %>&status=<%=status %>" method="post" class="menu_update" enctype="multipart/form-data">
		<table class="menu_update_table">
			<tr>
				<th>이름<label class="label_must"> *</label></th>
				<td>
					<select id="pname" name="pname">
						<option value="선택">선택</option>
						<%for(MenuVO a_vo : list){ %>
						<option value="<%=a_vo.getPname()%>"><%=a_vo.getPname() %></option>
						<%} %>
					</select>
				</td>
			</tr>
			<tr>
				<th>영어 표기</th>
				<td><input type="text" name="eng_pname" id="eng_pname" value=""></td>
			</tr>
			<tr>
				<th>설명<label class="label_must"> *</label></th>
				<td><input type="text" name="intro" id="intro" value=""></td>
			</tr>
			<tr>
				<th>배치 방식<label class="label_must"> *</label></th>
				<td>
				<input type="radio" id="promotion" name="order_type" value="promotion">
				<label for="promotion">프로모션(최상단)</label>
				<input type="radio" id="common" name="order_type" value="common">
				<label for="promotion">일반 메뉴</label>
				<input type="radio" id="pack" name="order_type" value="pack">
				<label for="promotion">팩 메뉴(하단 배치)</label>
				</td>
			</tr>
			<%if(category.equals("icecream")){ %>
			<tr>
				<th>추천 플레이버</th>
				<td>
					<select id="rec_flavor_list" name="rec_flavor_list">
						<option value="선택">선택</option>
						<%for(MenuVO a_vo : list){
							if(a_vo.getSet_check()==0){%>
								<option value="<%=a_vo.getPname()%>"><%=a_vo.getPname() %></option>
							<%}
						}%>
					</select>
					<input type="button" name = "btn_flavor" id="btn_flavor" value="지우기">
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<div class="selected_div" id="selected_rec_flavor">
					</div>
				</td>
			</tr>
			<%} %>
			<tr>
				<th>해쉬태그</th>
				<td><input type="text" name="hashtag" id="p_hashtag" value="" placeholder="각 해쉬태그는 첫머리에 '#'을 붙이고 공백 없이 쉼표(,)로 구분하여 넣어 주세요.">
				<!-- <input type="button" name = "btn_hash" id="btn_hash" value="등록">-->
				</td>
			</tr>
			<tr>
				<th>메뉴 사진<label class="label_must"> *</label></th>
				<td><input type="file" name="pfile" id="p_image"></td>
			</tr>
			<tr>
				<th class="th_nutrient">영양정보</th>
				<td>
					<table class="update_nutrient">
						<tr>
							<th>1회 제공량(g)</th>
							<td><input type="text" name="one_amount" id="n_amount"></td>
							<th>열량(kcal)</th>
							<td><input type="text" name="kcal" id="n_kcal"></td>
						</tr>
						<tr>
							<th>나트륨(mg)</th>
							<td><input type="number" name="natrium" id="n_natrium"></td>
							<th>당류(g)</th>
							<td><input type="number" name="sugar" id="n_sugar"></td>
						</tr>
						<tr>
							<th>포화지방(g)</th>
							<td><input type="number" name="fat" id="n_fat"></td>
							<th>단백질(g)</th>
							<td><input type="number" name="protein" id="n_protein"></td>
						</tr>
						<tr>
							<th>카페인(mg)</th>
							<td colspan=2><input type="number" name="caffeine" id="n_caffeine"></td>
						</tr>
						<tr>
							<th>알레르기 성분</th>
							<td class="td_allergy" colspan=3>
								<input type="checkbox" id="allergy" name="allergy" value="계란">
								<label for="allergy">계란</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="대두">
								<label for="allergy">대두</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="돼지고기">
								<label for="allergy">돼지고기</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="땅콩">
								<label for="allergy">땅콩</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="밀">
								<label for="allergy">밀</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="복숭아">
								<label for="allergy">복숭아</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="우유">
								<label for="allergy">우유</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="호두">
								<label for="allergy">호두</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="쇠고기">
								<label for="allergy">쇠고기</label>&nbsp;
								<input type="checkbox" id="allergy" name="allergy" value="오징어">
								<label for="allergy">오징어</label><br>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div class="update_buttons">
			<button type="button" id="btn_update" name="btn_submit">수정</button>
			<button type="button" id="btn_reset">초기화</button>
		</div>
		
	</form>
</div>
</section>
</body>
</html>
<% }else if(status.equals("after")){ %>
	<script>
		window.alert("수정 완료되었습니다.");
		window.close();
	</script>
<% } %>
<% }else{%>
	<script>
		window.alert("접근권한이 없습니다.");
		location.href = "http://localhost:9000/br31/index.jsp";
	</script>
<% } %>
<% }else{%>
	<script>
		window.alert("로그인후 사용이 가능합니다.");
		location.href = "http://localhost:9000/br31/login/login.jsp";
	</script>
<% } %>