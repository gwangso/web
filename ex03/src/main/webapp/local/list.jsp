<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row">
	<div class="col">
		<h1 class="mb-5">지역검색</h1>
		<div class="row mb-3 justify-content-end">
			<form name="frm_search" class="col-md-4">
				<div class="input-group">
					<select name="city" class="form-select me-2">
						<option>서울</option>
						<option selected>인천</option>
						<option>경기</option>
						<option>강원</option>
						<option>충북</option>
						<option>충남</option>
						<option>전북</option>
						<option>전남</option>
						<option>경북</option>
						<option>경남</option>
						<option>부산</option>
					</select>
					<input name="query" class="form-control" value="버거킹" />
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_local"></div>
		<div class="text-center">
			<button id="prev" class="btn btn-secondary px-3">이전</button>
			<span id="nowpage" class="mx-3">1/100</span>
			<button id="next" class="btn btn-secondary px-3">다음</button>

		</div>
	</div>
</div>

	<div id="map" style="width:100%;height:100%;"></div>


<!-- 지역검색목록 템플릿 -->
<script id="temp_local" type="text/x-handlebars-template">
	

	<table class="table table-striped table-dark">
		<tr>
			<td>
				<input type="checkbox" class="me-3" id="all">
			</td>
			<td>id</td>
			<td>이름</td>
			<td>주소</td>
			<td>전화번호</td>
			<td></td>
		</tr>			
		{{#each documents}}
		<tr class="local" local="{{toString @this}}">
			<td><input type="checkbox" class="chk"></td>
			<td>{{id}}</td>
			<td class="place">{{place_name}}</td>
			<td>{{address_name}}</td>
			<td class="phone">{{phone}}</td>
			<td><button class="btn btn-success" idx={{@index}} x="{{x}}" y="{{y}}">위치</button></td>
		</tr>
		{{/each}}
	</table>
	<td><button id="btn_save" class="btn btn-primary btn-sm">선택저장</button></td>
</script>

<!-- handlebars 함수 -->
<script>
	Handlebars.registerHelper("toString", function(local){
		return JSON.stringify(local); //Handlebar에서 local을 받아 string으로 바꿔준다
	});
</script>


<!-- ajax -->
<script>
	let now_page = 1;

	$("#prev").on("click", function() {
		now_page--;
		getList();
	})

	$("#next").on("click", function() {
		now_page++;
		getList();
	})

	$(frm_search).on("submit", function(event) {
		event.preventDefault();
		now_page = 1;
		getList();
	})
	
	//전체 체크박스를 클릭했을때
	$("#div_local").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_local .local .chk").prop("checked", true)
		}else {
			$("#div_local .local .chk").prop("checked", false)
		}
	})
	
	//각 행에 체크박스를 클릭했을때
	$("#div_local").on("click", ".chk", function(){
		//전체체크박스 개수
		let total=$("#div_local .chk").length;
		let chk=$("#div_local .chk:checked").length;
		if(total==chk){
			$("#div_local #all").prop("checked",true);
		}else{
			$("#div_local #all").prop("checked",false);
		}
	});
	
	//선택 저장버튼을 클릭했을때
	$("#div_local").on("click", "#btn_save", function(){
		let chk=$("#div_local .chk:checked").length;
		if(chk==0){
			alert("저장할 항목을 선택하세요!")
		}else {
			if(!confirm(chk+"개 항목을 저장하실레요?")) return;
			$("#div_local .chk:checked").each(function(){
				let row =$(this).parent().parent();
				let data = JSON.parse(row.attr("local"));
				console.log(data);
				$.ajax({
					type:"post",
					url:"/local/insert",
					data: data,
					success:function(){
					}
				})
			});
			alert("저장되었습니다.");
			$("#div_local .chk").prop("checked",false);
			$("#div_local #all").prop("checked",false)
		}
		
	})

	//위치버튼을 클릭
	$("#div_local").on("click", ".btn-success", function() {
		$("#map").show();
		let x = $(this).attr("x"); //경도
		let y = $(this).attr("y"); //위도
		var container = document.getElementById('map');
		var options = {
			center : new kakao.maps.LatLng(y, x),
			level : 3
		};
		var map = new kakao.maps.Map(container, options);
		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(y, x);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		let row = $(this).parent().parent();
		let place = row.find(".place").text();
		let phone = row.find(".phone").text();
		
		var str ="<div style='padding:5px;font-size:12px;'>";
        str += place + "<br>" + phone;
        str +="</div>";
        var info=new kakao.maps.InfoWindow({ content:str });

        kakao.maps.event.addListener(marker, "mouseover", function(){ 
        	info.open(map, marker); 
        });
        kakao.maps.event.addListener(marker, "mouseout", function(){
        	info.close(map, marker); 
        });
		
	})

	getList();
	function getList() {
		let query = $(frm_search.city).val() + " " + $(frm_search.query).val();
		$.ajax({
			type : "get",
			url : "https://dapi.kakao.com/v2/local/search/keyword.json",
			dataType : "json",
			data : {
				query : query,
				size : 5,
				page : now_page
			},
			headers : {
				"Authorization" : "KakaoAK 19f87e364dd00588802f6312b3bffecb"
			},
			success : function(data) {
				const com_temp_local = Handlebars.compile($("#temp_local")
						.html());
				const html_local = com_temp_local(data);
				$("#div_local").html(html_local);

				let last_page = Math.ceil(data.meta.pageable_count / 5);
				$("#nowpage").html(now_page + "/" + last_page);

				if (now_page == 1)
					$("#prev").attr("disabled", true);
				else
					$("#prev").attr("disabled", false);

				if (now_page == last_page)
					$("#next").attr("disabled", true);
				else
					$("#next").attr("disabled", false);
			}
		});
	}
</script>