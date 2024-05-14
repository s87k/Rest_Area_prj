<%@page import="highway.HighwayDAO"%>
<%@page import="highway.HighwayVO"%>
<%@page import="searchRestArea.SearchRestAreaDAO"%>
<%@page import="searchRestArea.RestAreaNameVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="휴게소 검색 페이지"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon"
	href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
/* 네비게이션 바 스타일 */
.nav-item {
	margin-top: 15px;
}

#login {
	cursor: pointer;
}
/* 검색창 스타일 */
.search-container form {
	width: 100%;
}
/* 검색창 select 스타일 */
.form-select {
	width: 185px;
}
/* 검색 버튼 크기 조절 */
.btn-primary {
	flex-shrink: 0;
	width: 100px;
	height: 65px;
}

.main {
	margin-top: 15px;
	width: 100%;
	float: left;
	width: 100%;
}

#main_1 {
	float: left;
	overflow: auto;
	width: 50%;
	height: 750px;
}

.main_2 {
	float: right;
	width: 50%;
	height: 750px;
}

.col-md-6 {
	margin-top: 20px;
}

a {
	text-decoration: none;
	color: black;
}

footer {
	margin-top: 150px;
}
</style>
<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js">
	
</script>
<script type="text/javascript">
	// DOM이 완전히 로드되면 실행
	document.addEventListener("DOMContentLoaded", function() {
		// select 요소를 가져옴
		var selectElement = document
				.querySelector('select[name="search-type"]');

		// 현재 페이지의 URL에서 search-type의 값을 가져옴
		var urlParams = new URLSearchParams(window.location.search);
		var selectedSearchType = urlParams.get('search-type');

		// select 요소의 변경 사항을 감지하고 실행
		selectElement.addEventListener('change', function() {
			// 선택된 옵션의 값을 가져옴
			var selectedValue = selectElement.value;

			// 모든 옵션 요소를 가져옴
			var optionElements = selectElement.querySelectorAll('option');

			// 각 옵션 요소를 반복하면서
			optionElements.forEach(function(optionElement) {
				// 옵션의 값이 선택된 값과 일치하면
				if (optionElement.value === selectedValue) {
					// 해당 옵션을 선택 상태로 변경
					optionElement.setAttribute('selected', 'selected');
				} else {
					// 선택된 값과 일치하지 않으면 선택 상태 제거
					optionElement.removeAttribute('selected');
				}
			});

			// 선택된 옵션 값으로 URL을 변경하여 페이지를 새로고침합니다.
			window.location.href = window.location.pathname + '?search-type='
					+ selectedValue;
		});

		// 페이지 로드 시 기존에 선택된 검색 유형에 대한 처리
		if (selectedSearchType) {
			// 모든 옵션 요소를 가져옴
			var optionElements = selectElement.querySelectorAll('option');

			// 각 옵션 요소를 반복하면서
			optionElements.forEach(function(optionElement) {
				// 옵션의 값이 선택된 검색 유형과 일치하면
				if (optionElement.value === selectedSearchType) {
					// 해당 옵션을 선택 상태로 변경
					optionElement.setAttribute('selected', 'selected');
				} else {
					// 선택된 검색 유형과 일치하지 않으면 선택 상태 제거
					optionElement.removeAttribute('selected');
				}
			});
		}
	});

	$(document).ready(function() {
		// 휴게소 링크를 클릭했을 때
		$(".rest_area_detail a").click(function(event) {
			// 이동 기본 동작을 수행합니다.
			return true;
		});

		// 상세 페이지로 이동하는 링크를 제외한 요소에 클릭 이벤트를 추가합니다.
		$(".col-md-12").click(function(event) {
			// 클릭된 요소가 .rest_area_detail 클래스에 속한 요소인지 확인합니다.
			if (!$(event.target).closest('.rest_area_detail').length) {
				// .rest_area_detail 클래스에 속하지 않은 경우에만 동작합니다.
				event.preventDefault(); // 클릭 이벤트의 기본 동작을 막습니다.
			}
		});
	});

	function showRestArea(latitude, longitude) {
		// 여기에 지도 표시 코드를 추가합니다.
		// var container = document.getElementById('map');
		// var options = {
		//     center: new kakao.maps.LatLng(latitude, longitude),
		//     level : 3
		// };
		// var map = new kakao.maps.Map(container, options);
	}
</script>

</head>
<body>
	<div class="container">
		<!-- 메뉴바 시작-->
		<header
			class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
			<a href="mainPage.jsp"
				class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
				<img src="https://data.ex.co.kr/images/common/logo.png"> <span
				class="fs-4">고속도로 휴게소</span>
			</a>

			<ul class="nav justify-content-end">
				<li class="nav-item"><a class="nav-link" id="login">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="join.jsp">회원가입</a>
				</li>
			</ul>
		</header>
		<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<!-- 메뉴바 끝-->
		<!-- 검색창 시작-->
		<div class="search-container">
			<form class="d-flex" role="search">
				<select class="form-select" aria-label="고속도로 검색 유형"
					name="search-type">
					<option value="1">지역별</option>
					<option value="2">휴게소별</option>
					<option value="3">고속도로별</option>
				</select> <input class="form-control me-2" type="search" name="search-query"
					placeholder="찾으시는 휴게소를 검색해주세요" aria-label="Search">
				<button class="btn btn-primary" type="submit">검색</button>
			</form>
		</div>
		<!-- 검색창 끝-->
		<!-- 지도 & 이달의 맛집 시작 -->
		<div class="main">

				<%
				String searchValue = request.getParameter("search-query");
				String searchType = request.getParameter("search-type");
				List<RestAreaNameVO> searchNameList = null;
				SearchRestAreaDAO sraDAO = SearchRestAreaDAO.getInstance();
				searchNameList = sraDAO.searchByRaName(searchValue);
				RestAreaNameVO ranVO = null;
				%>
				<%
				if (searchType.equals("1")) {
				%>
			<div id="main_1" style="overflow-y: auto; overflow-x: hidden;">
				<div>
					<!-- Image Map Generated by http://www.image-map.net/ -->
					<img src="../images/koreamap.png" usemap="#image-map" width="80%">
					<map name="image-map">
						<area target="_blank" alt="" title="서울" href="#void"
							coords="53,56,59,54,60,59,57,65,50,65" shape="poly">
						<area target="" alt="" title="경기" href="#void"
							coords="44,73,44,80,50,87,57,87,67,88,74,82,80,76,82,62,76,54"
							shape="poly">
						<area target="" alt="" title="강원도" href="#void"
							coords="62,22,81,21,99,21,107,10,114,17,118,31,125,39,122,52,129,47,138,54,143,62,147,71,147,77,130,80,111,79,101,74,94,73,87,75"
							shape="poly">
						<area target="" alt="" title="충청북도" href=""
							coords="36,86,22,93,28,110,35,118,41,132,57,122,72,124,62,101,61,91"
							shape="poly">
						<area target="" alt="" title="충청남도" href=""
							coords="70,88,81,83,90,78,101,77,109,83,109,91,97,93,88,100,85,109,86,117,89,124,77,117,81,124,71,109"
							shape="poly">
						<area target="" alt="" title="전라북도" href=""
							coords="39,138,52,130,61,130,68,130,77,136,90,136,84,143,79,158,79,165,70,167,59,167,52,163,44,161,36,166,33,153"
							shape="poly">
						<area target="" alt="" title="전라남도" href=""
							coords="32,180,29,173,37,169,47,163,56,169,64,170,77,169,84,184,65,196,40,213,24,206,27,190,29,191,27,190"
							shape="poly">
						<area target="" alt="" title="경상북도" href=""
							coords="113,97,125,88,143,84,151,92,151,102,149,116,151,132,155,145,150,160,133,149,102,138,94,136,96,122,94,109,103,99"
							shape="poly">
						<area target="" alt="" title="경상남도" href=""
							coords="79,170,82,159,88,143,101,144,108,151,123,154,136,153,141,159,136,170,126,177,114,185,91,186,94,193"
							shape="poly">
					</map>
				</div>
				<%
				}
				%>
				<%
				if (searchType.equals("2")) {
				%>
				<div id="main_1" style="overflow-y: auto; overflow-x: hidden;">
				<%
				for (int i = 0; i < searchNameList.size(); i++) {
				%>
				<%
				ranVO = searchNameList.get(i);
				%>
				<div class="col-md-12">
					<!-- 휴게소 정보 -->
					<!-- 이달의 맛집1 시작 -->
					<div class="row">
						<div class="col-md-12">
							<div
								class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm position-relative">
								<div id="rest_area_name"
									class="col p-4 d-flex flex-column position-static">
									<div class="mb-0 rest_area_link">
										<a href="#"><span data-lat="<%=ranVO.getLatitude()%>"
											data-lng="<%=ranVO.getLongitude()%>"></span><%=ranVO.getRaName()%></a>
									</div>
									<div class="mb-1 text-body-secondary"><%=ranVO.getRaAddr()%></div>
									<p class="mb-auto">
										전화번호 <br>
										<%=ranVO.getRaTel()%>
									</p>
									<div class="rest_area_detail">
										<a
											href="http://localhost/Rest_Area_prj/rest_area_detail_page/rest_area_detail_page.jsp?raNum=<%=ranVO.getRaNum()%>&raName=<%=ranVO.getRaName()%>&addr=<%=ranVO.getRaAddr()%>"
											class="icon-link gap-1 icon-link-hover stretched-link"> <%=ranVO.getRaName()%>
											상세페이지 <svg class="bi"> 
                                <use xlink:href="#chevron-right"></use>
                            </svg>
										</a>
									</div>
								</div>
								<div class="col-auto d-none d-lg-block">
									<svg class="bd-placeholder-img" width="200" height="250"
										xmlns="http://www.w3.org/2000/svg" role="img"
										aria-label="Placeholder: Thumbnail"
										preserveAspectRatio="xMidYMid slice" focusable="false"> 
                            <image href="images/bugger.png" width="200"
											height="250" /> 
                        </svg>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
				</div>
				<%
				}
				%>
				<%
				if (searchType.equals("3")) {
				%>
				<div id="main_1" style="overflow-y: auto; overflow-x: hidden;">
				<%
				List<HighwayVO> hwList = null;
				HighwayDAO hwDAO = HighwayDAO.getInstance();
				hwList = hwDAO.selectAllHighway();
				HighwayVO hwVO = null;
				%>
				<div class="col-md-12">
					<div class="row">
						<div class="col-md-6">
							<table>
								<%
								for (int i = 0; i < hwList.size(); i++) {
									hwVO = hwList.get(i);
								%>
								<tr>
									<th><input type="button"
										value="<%=hwVO.getHighwayName()%>" class="btn btn-success">
										<%
										}
										%></th>
								</tr>
							</table>
						</div>
					</div>
				</div>
				</div>
				</div>
			<div class="main_2" style="margin-bottom: auto;">
				<div class="row">
					<!-- 지도 시작 -->
					<div id="map"
						style="margin-left: auto; width: 600px; height: 500px;"
						class="col-md-6">
						<!-- 여기에 지도를 표시할 준비를 합니다. -->
						<script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16ee3555fcc7fa1f7c8e630d95b34e4f"></script>
						<script type="text/javascript">
							var container = document.getElementById('map');//지도를 담을 영역의 DOM 레퍼런스

							var spanElement = document
									.querySelector('.rest_area_link span');

							// span 요소가 존재하는 경우에만 값을 가져옵니다.
							if (spanElement) {
								// data-lat와 data-lng 속성 값을 가져옵니다.
								var latitude = spanElement.dataset.lat;
								var longitude = spanElement.dataset.lng;

								// 가져온 값이 유효한지 확인합니다.
								if (latitude && longitude) {
									// 가져온 위도와 경도 값을 이용하여 원하는 작업을 수행합니다.
									console.log("Latitude:", latitude,
											"Longitude:", longitude);

									// 이제 위도와 경도 값을 사용하여 지도에 마커를 표시하거나 다른 작업을 수행할 수 있습니다.
								} else {
									console
											.error("Failed to retrieve latitude and longitude values.");
								}
							} else {
								console
										.error("Could not find span element with class 'rest_area_link'");
							}

							var options = { //지도를 생성할 때 필요한 기본 옵션
								center : new kakao.maps.LatLng(latitude,
										longitude),//지도의 중심좌표.
								level : 3
							//지도의 레벨(확대, 축소 정도)
							};

							var map = new kakao.maps.Map(container, options);//지도 생성 및 객체 리턴

							// 마커가 표시될 위치입니다 
							var markerPosition = new kakao.maps.LatLng(
									latitude, longitude);

							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position : markerPosition
							});

							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);
						</script>
					</div>
				</div>
			</div>
				<%
				}
				%>
			<!-- 지도 & 이달의 맛집 끝-->
			<!-- 	사이트 광고 배너 시작 -->
			<!-- <div id="myCarousel" class="carousel slide mb-6"
				data-bs-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active">
						<a href="https://www.kpetro.or.kr/index.dos" target="_blank">
							<svg width="1297" height="300" xmlns="http://www.w3.org/2000/svg"
								aria-hidden="true" preserveAspectRatio="xMidYMid slice"
								focusable="false">
        				<image xlink:href="../images/Kpetro.jpg" width="100%"
									height="100%" />
    				</svg>
						</a>
					</div>
					<div class="carousel-item">
						<a href="https://www.oilbankcard.com/card2012/main.do"
							target="_blank"> <svg width="1297" height="300"
								xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
								preserveAspectRatio="xMidYMid slice" focusable="false">
        				<image xlink:href="../images/oilbankcard.jpg" width="100%"
									height="100%" />
    				</svg>
						</a>
					</div>
					<div class="carousel-item">
						<a href="https://www.s-oilbonus.com/main" target="_blank"> <svg
								width="1297" height="300" xmlns="http://www.w3.org/2000/svg"
								aria-hidden="true" preserveAspectRatio="xMidYMid slice"
								focusable="false">
        				<image xlink:href="../images/s-oilbonus.jpg" width="100%"
									height="100%" />
    				</svg>
						</a>
					</div>
				</div>
			</div> -->
			<!--  사이트 광고 배너 끝 -->
			<div class="row">
				<!-- FAQ 시작 -->
				<div class="col-md-6">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col" class="text-start">FAQ <span id="plus_FAQ"
									class="float-end">더보기+</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">1</th>
								<td colspan="3">휴게소 상세정보가 알고 싶어요</td>
							</tr>
							<tr>
								<th scope="row">2</th>
								<td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
							</tr>
							<tr>
								<th scope="row">3</th>
								<td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
							</tr>
							<tr>
								<th scope="row">4</th>
								<td colspan="3">휴게소 상세정보가 알고 싶어요</td>
							</tr>
							<tr>
								<th scope="row">5</th>
								<td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
							</tr>
							<tr>
								<th scope="row">6</th>
								<td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- FAQ 끝 -->
				<!-- 공지사항 시작 -->
				<div class="col-md-6">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col" colspan="2">공지사항</th>
								<th scope="col">입력일 <span id="plus_announce"
									class="float-end">더보기+</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">1</th>
								<td colspan="2">댕 큰 공지사항이 있어요</td>
								<td>2024-12-32</td>
							</tr>
							<tr>
								<th scope="row">2</th>
								<td colspan="2">조금 작은 공지사항이 있어요</td>
								<td>2024-13-01</td>
							</tr>
							<tr>
								<th scope="row">3</th>
								<td colspan="2">암튼 공지사항이 있어요</td>
								<td>2024-01-33</td>
							</tr>
							<tr>
								<th scope="row">4</th>
								<td colspan="2">댕 큰 공지사항이 있어요</td>
								<td>2024-12-32</td>
							</tr>
							<tr>
								<th scope="row">5</th>
								<td colspan="2">조금 작은 공지사항이 있어요</td>
								<td>2024-13-01</td>
							</tr>
							<tr>
								<th scope="row">6</th>
								<td colspan="2">암튼 공지사항이 있어요</td>
								<td>2024-01-33</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 공지사항 끝 -->
			</div>
			<!-- 공지사항&FAQ 끝 -->
		</div>
		<!-- 제작&저작권 시작 -->
		<footer class="py-5 text-center text-body-secondary bg-white">
			<p>&copy;고속도로 휴게소 제작 by 4조.</p>
			<p class="mb-0">
				<a href="#">상단으로 올라가기</a>
			</p>
		</footer>
		<!-- 제작&저작권 끝 -->
		<!-- 메인 페이지 끝 -->
	</div>
</body>

</html>