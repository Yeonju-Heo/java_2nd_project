<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://localhost:9000/br31/css/br31.css">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e8cac00c1ae66570ccea4298241d3ae9"></script>
</head>
<body id="br_store">
	<!-- header -->
	<jsp:include page="../header.jsp"></jsp:include>
		
	<!-- content -->
	<article id="wrap" class="br_store_map">

	<div id="content">
		<div class="map_wrap">

			<div id="map" class="store_map" style="position: relative; overflow: hidden;"></div>
	<script>
		var container = document.getElementById('map');
		
		var options = {
			center: new kakao.maps.LatLng(37.499401, 127.033339),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		 // 마커가 표시될 위치입니다 
        var markerPosition  = new kakao.maps.LatLng(37.499401,127.033339); 
        var markerPosition2  = new kakao.maps.LatLng(37.401420,127.012345); 
        var markerPosition3  = new kakao.maps.LatLng(37.314528,127.894264); 
        var markerPosition4  = new kakao.maps.LatLng(36.499412,128.033825); 
        var markerPosition5  = new kakao.maps.LatLng(37.234501,127.523339); 
        var markerPosition6  = new kakao.maps.LatLng(35.625401,129.082339); 
        var markerPosition7  = new kakao.maps.LatLng(37.499401,127.825639); 
        var markerPosition8  = new kakao.maps.LatLng(37.491901,127.030839); 

        // 마커를 생성합니다
        var marker = new kakao.maps.Marker({position:markerPosition});
        var marker2 = new kakao.maps.Marker({position:markerPosition2});
        var marker3 = new kakao.maps.Marker({position:markerPosition3});
        var marker4 = new kakao.maps.Marker({position:markerPosition4});
        var marker5 = new kakao.maps.Marker({position:markerPosition5});
        var marker6 = new kakao.maps.Marker({position:markerPosition6});
        var marker7 = new kakao.maps.Marker({position:markerPosition7});
        var marker8 = new kakao.maps.Marker({position:markerPosition8});
        
        //지도 표시
        marker.setMap(map);
        marker2.setMap(map);
        marker3.setMap(map);
        marker4.setMap(map);
        marker5.setMap(map);
        marker6.setMap(map);
        marker7.setMap(map);
        marker8.setMap(map);
	</script>
			

	</div>
	</div>


</article>

	<!-- footer -->
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>