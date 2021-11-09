<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "com.br31.dao.*,com.br31.vo.*,java.util.*,java.net.URLEncoder" %>
 <%
 	String category = request.getParameter("category");
 	MenuDAO dao = new MenuDAO();
	//MenuVO vo = dao.getAdminContent(pname);
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
var flavor_list = [];
var hash_list = [];

	function form_empty(){						//리셋버튼 누를때 함수
		$("#intro").val("");	//설명
		$("#selected_rec_flavor").empty();
		$("#hashtag").val("");	//해쉬태그
		$("#selected_hashtag").empty();
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

	function ajax_content(pname){						//ajax
		$.ajax({
			url:"admin_menu_update_ajax.jsp?pname="+pname,
			success:function(result){
				//실행결과에 따른 처리.
				var jdata = JSON.parse(result);
				$("#eng_pname").val(jdata.eng_pname);	//설명
				$("#intro").val(jdata.intro);	//설명
				$("#selected_rec_flavor").empty();	//추천플레이버
				var output = "";
				if(jdata.rec_flavor!=""){
					var list_r = jdata.rec_flavor.split(",");
					for(var i=0;i<list_r.length;i++){
						if(i==0){
							output += "<span><button type='button' class='delete' id='delete_rec' name='delete_rec'>&times;</button>" + list_r[i] + "</span>";
						}else{
							output += "<span>" + list_r[i] + "</span>";
						}
						flavor_list.push(list_r[i]);
						output += "<input type='hidden' name='rec_flavor' id='rec_flavor' value="+list_r[i]+">";
					}
				}
				$("#selected_rec_flavor").append(output);
				
				$("#hashtag").val("");	//해쉬태그
				$("#selected_hashtag").empty();
				output = "";
				if(jdata.hashtag!=null){
					var list_h = jdata.hashtag.split(",");
					for(var i=0;i<list_h.length;i++){
						if(i==0){
							output += "<span><label class='hashtag' name='hashtag'><button type='button' class='delete' id='delete_hash' name='delete_hash'>&times;</button>" + list_h[i] + "<label></span>";
						}else{
							output += "<span><label class='hashtag' name='hashtag'>" + list_h[i] + "<label></span>";
						}
						output += "<input type='hidden' name='hashtag_data' id='hashtag_data' value="+hashtag+">";
						hash_list.push(list_h[i]);
					}
				}
				$("#selected_hashtag").append(output);
				
				$("#frame").remove();
				output="";	//메뉴 사진
				if(jdata.pfile!=null){
					output += "<span id='frame'>"+jdata.pfile+"</span>";
				}else{
					output += "<span id='frame'>선택된 파일 없음</span>";
				}
				$("#p_image").after(output);
				
				$("#psfile_old").val(jdata.psfile)
				$("#n_amount").val(jdata.one_amount);
				$("#n_kcal").val(jdata.kcal);
				$("#n_natrium").val(jdata.natrium);
				$("#n_sugar").val(jdata.sugar);
				$("#n_fat").val(jdata.fat);
				$("#n_protein").val(jdata.protein);
				$("#n_caffeine").val(jdata.caffeine);
				
				$("input[type=checkbox]").removeAttr("checked");
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
		$("#pname").change(function(){
			var pname = $("#pname").val();
			flavor_list = [];
			hash_list = [];
			if(pname!="선택"){		//원래 데이터로 돌려놓음
				ajax_content(pname);
			}else{		//'선택'일 경우 다 지움
				form_empty(num);
			}
		});
		
		$("#rec_flavor_list").change(function(){		//추천 플레이버 선택시
			var flavor = $("#rec_flavor_list").val();
			flavor_list.push(flavor);
			if(flavor!="선택"){
				if(flavor==$("#pname").val()){
					alert("추천 플레이버는 다른 맛만 선택할 수 있습니다.")
				}else{
					var output = "";
					if(flavor_list.length==1){
						output += "<button type='button' class='delete' id='delete_rec' name='delete_rec'>&times;</button>";
					}
					output += "<span>"+flavor+"</span>";
					output += "<input type='hidden' name='rec_flavor' id='rec_flavor' value="+flavor+">";
					$("#selected_rec_flavor").append(output);
					
					/*
					$("button[name=delete_rec]").click(function(){
						$("#selected_rec_flavor").empty();
						flavor_list = [];
					});
					*/
					
				}
			}
		});
		
		window.onclick = function(){	//추천맛, 해쉬태그 삭제버튼 누를때
			var btns_rec_delete = document.getElementsByName("delete_rec");
			var btns_hash_delete = document.getElementsByName("delete_hash");
			
			for(var i=0;i<btns_rec_delete.length;i++){
				btns_rec_delete[i].onclick = function(){
					$("#selected_rec_flavor").empty();
					flavor_list = [];
				}
			}
			for(var i=0;i<btns_hash_delete.length;i++){
				btns_hash_delete[i].onclick = function(){
					$("#selected_hashtag").empty();
					hash_list = [];
				}
			}
			
		
		}
		
		$("#btn_hash_add").click(function(){		//해쉬태그 등록시
			var hashtag = "#"+$("#hashtag").val();
			if(hashtag.trim() == "#"){
				alert("해쉬태그를 입력해 주세요.");
				$("#hashtag").focus();
			}else{
				hash_list.push(hashtag);
				$("#hashtag").val("");
				var output = "";
				if(hash_list.length==1){
					output += "<button type='button' class='delete' id='delete_hash' name='delete_hash'>&times;</button>";
				}
				output += "<span>"+hashtag+"</span>";
				output += "<input type='hidden' name='hashtag_data' id='hashtag_data' value="+hashtag+">";
				$("#selected_hashtag").append(output);
				
				/*
				$("button[name=delete_hash]").click(function(){
					$("#selected_hashtag").empty();
					hash_list = [];
				});
				
				*/
			}
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
	<form name="menu_update" action="admin_menu_update_process.jsp" method="post" class="menu_update" enctype="multipart/form-data">
	<input type="hidden" name="psfile_old" id="psfile_old">
		<table class="menu_update_table">
			<tr>
				<th>이름</th>
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
				<th>설명</th>
				<td><input type="text" name="intro" id="intro" value=""></td>
			</tr>
			<tr>
				<th>추천 플레이버</th>
				<td>
					<select id="rec_flavor_list" name="rec_flavor_list">
						<option value="선택">선택</option>
						<%for(MenuVO a_vo : list){ %>
						<option value="<%=a_vo.getPname()%>"><%=a_vo.getPname() %></option>
						<%} %>
					</select>
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<div class="selected_div" id="selected_rec_flavor">
					</div>
				</td>
			</tr>
			<tr>
				<th>해쉬태그</th>
				<td><input type="text" name="hashtag" id="hashtag" value="">
				<input type="button" name = "btn_hash_add" id="btn_hash_add" value="등록">
				</td>
			</tr>
			<tr>
				<th></th>
				<td>
					<div class="selected_div" id="selected_hashtag">
					</div>
				</td>
			</tr>
			<tr>
				<th>메뉴 사진</th>
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