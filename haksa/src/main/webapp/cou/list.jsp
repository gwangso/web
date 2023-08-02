<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="row my-5">
	<div class="col">
		<h1 class="text-center my-3">강좌목록</h1>
		<div class="row">
			<form name="frm" class="col-10 col-md-6 col-xl-4">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="lcode">강좌번호</option>
						<option value="lname" selected>강좌이름</option>
						<option value="instructor">교수번호</option>
						<option value="pname">교수이름</option>
						<option value="room">강의실</option>						
					</select>&nbsp; <!-- 한칸 띄라는 의미 -->
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_cou_list"></div>
		<div id="pagination" class="pagination justify-content-center my-3"></div>
	</div>
</div>

<script id="temp_cou_list" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-warning">
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>교수번호</th>
			<th>교수이름</th>
			<th>강의시간</th>
			<th>강의실</th>
			<th>최대수강인원</th>
			<th>수강신청인원수</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{instructor}}</td>
			<td>{{pname}}</td>
			<td>{{hours}}</td>
			<td>{{room}}</td>
			<td>{{capacity}}</td>
			<td>{{persons}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script src="/js/script.js"></script>
<script>
	let url = "cou";
	getTotal();
	
	/*
	let query = $(frm.query).val();
	let key = $(frm.key).val();
	
	getCouTotal();
	
	function getCouList(page){
		$.ajax({
			type:"get",
			url:"/cou/list.json",
			data:{query:query, key:key, page:page},
			dataType:"json",
			success:function(data){
				const com_temp_cou_list = Handlebars.compile($("#temp_cou_list").html())
				const html_cou_list = com_temp_cou_list(data);
				$("#div_cou_list").html(html_cou_list));
			}
		});
	}
	
	$('#pagination').twbsPagination({
		totalPages:5,	// 총 페이지 번호 수
		visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-caret-left-square-fill"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : `<i class="bi bi-caret-left"></i>`,	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-caret-right-square-fill"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function (event, page) {
			getCouList(page);
		}
	});
	
	function getCouTotal(){
		$.ajax({
			type:"get",
			url:"/cou/total",
			data:{query:query, key:key},
			success:function(data){
				if(data==0){
					$("#pagination").hide();
					$("#div_cou_list").html(`<h3 class="my-3 text-center"><b>검색결과없음</b></h3>`)
					$(frm.query).val("");
				}else{
					$("#pagination").show();
					let totalCouPage = Math.ceil(data/5);
					$("#pagination").twbsPagination("changeTotalPages", totalCouPage, 1)
				}
			}
		});
	}
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key=$(frm.key).val();
		getCouTotal();
	});
	*/
</script>