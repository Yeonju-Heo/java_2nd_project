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

	function ajax_nameCheck(pname){						//ajax. 등록할때마다 실행
		$.ajax({
			url:"admin_menu_insert_ajax.jsp?pname="+pname,
			success:function(result){
				//실행결과에 따른 처리.
				var jdata = JSON.parse(result);
				if(jdata.p_check==true){
					if($("#n_natrium").val()==""){
						$("#n_natrium").val(0);
					}
					if($("#n_sugar").val()==""){
						$("#n_sugar").val(0);
					}
					if($("#n_fat").val()==""){
						$("#n_fat").val(0);
					}
					if($("#n_protein").val()==""){
						$("#n_protein").val(0);
					}
					if($("#n_caffeine").val()==""){
						$("#n_caffeine").val(0);
					}
					/*
					if($("input[name='rec_flavor']").length==0){
						var list = [];
						for(var j=0;j<$("input[name='rec_flavor']").length;j++){
							var one = encodeURIComponent($("input[name='rec_flavor']").get(j).val());
							alert(one);
							list[j] = one;
						}
					}
					*/
					menu_update.submit();
				}else{
					alert("이미 있는 제품 이름입니다. 이름을 변경해 주세요.");
					$("#pname").focus();
				}
			}//success
		});//ajax
	}//ajax_list function
	$(document).ready(function(){
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
		$("#btn_insert").click(function(){						//수정버튼누를때
			if($("#pname").val()==""){
				alert("메뉴 이름을 입력해 주세요.");
				$("#pname").focus();
				return false;
			}else if($("#intro").val()==""){
				alert("메뉴 설명을 입력해 주세요");
				$("#intro").focus();
				return false;
			}else if($("#frame").text()=="선택된 파일 없음"){
				alert("메뉴 사진을 등록해 주세요");
				return false;
			}else if(!$("input[type=radio]").is(':checked')){
				alert("배치 위치를 선택해 주세요.");
				return false;
			}else if($("#p_image").val()==""){
				alert("사진 파일을 업로드해 주세요.");	
				return false;
			}else{
				var check = confirm("메뉴를 등록하시겠습니까?");
				if(check==true){
					//이름체크
					ajax_nameCheck($("#pname").val());
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
<h3 class="title">메뉴 등록</h3>
<div class="content_update">
	<form name="menu_update" action="admin_menu_insert_process.jsp?category=<%=category %>&status=<%=status %>" method="post" class="menu_update" enctype="multipart/form-data">
		<table class="menu_update_table">
			<tr>
				<th>이름<label class="label_must"> *</label></th>
				<td><input type="text" name="pname" id="pname"></td>
			</tr>
			<tr>
				<th>영어 표기</th>
				<td><input type="text" name="eng_pname" id="eng_pname"></td>
			</tr>
			<tr>
				<th>설명<label class="label_must"> *</label></th>
				<td><input type="text" name="intro" id="intro"></td>
			</tr>
			<tr>
				<th>배치 위치<label class="label_must"> *</label></th>
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
							<td><input type="text" name="natrium" id="n_natrium"></td>
							<th>당류(g)</th>
							<td><input type="text" name="sugar" id="n_sugar"></td>
						</tr>
						<tr>
							<th>포화지방(g)</th>
							<td><input type="text" name="fat" id="n_fat"></td>
							<th>단백질(g)</th>
							<td><input type="text" name="protein" id="n_protein"></td>
						</tr>
						<tr>
							<th>카페인(mg)</th>
							<td colspan=2><input type="text" name="caffeine" id="n_caffeine"></td>
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
			<button type="button" id="btn_insert" name="btn_submit">등록</button>
			<button type="reset" id="btn_reset">초기화</button>
		</div>
		
	</form>
</div>
</section>
</body>
</html>
<% }else if(status.equals("after")){ %>
	<script>
		window.alert("등록 완료되었습니다.");
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