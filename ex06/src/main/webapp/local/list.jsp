<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<div class="row">
	<div class="col">
		<!-- 제목 -->
		<h1 class="text-center">지역목록</h1>
		<!-- 검색창 -->
		<div class="row justify-content-end mb-2">
			<div class="col align-self-center">
				<span>검색수</span>
				<span id="search_total">100</span>
			</div>
			<form name="frm_local" class="col-6 col-md-4 ">
				<div class="input-group my-3">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<!-- 상품목록칸 -->
		<div id="div_local_list"></div>
		<!-- 페이지 -->
		<div id="pagination" class="pagination justify-content-center"></div>
		
	</div>
</div>


<script id="temp_local_list" type="text/x-handelbars-template">
	<table class="table">
		<tr class="table-dark">
			<td>등록번호</td>
			<td>지역번호</td>
			<td>이름</td>
			<td>주소</td>
			<td>전화번호</td>
		</tr>
		{{#each .}}
		<tr>
			<td>{{id}}</td>
			<td>{{lid}}</td>
			<td>{{lname}}</td>
			<td>{{laddress}}</td>
			<td>{{lphone}}</td>
		</tr>
		{{/each}}
	</table>	
</script>

<script>
	let query = $(frm_local.query).val();
	
	getLocalTotal();
	
	function getLocalList(page){
		$.ajax({
			type:"get",
			url:"/local/list.json",
			dataType : "json",
			data:{page:page, query:query},
			success:function(data){
				const com_temp_local_list = Handlebars.compile($("#temp_local_list").html());
				const html_local_list = com_temp_local_list(data);
				$("#div_local_list").html(html_local_list); 
			}
		});
	}
	
	function getLocalTotal(){
		$.ajax({
			type:"get",
			url:"/local/total",
			data:{query:query},
			success:function(data){
				$("#search_total").html(data);
				if(data==0){
					$("#div_local_list").html(`<h3 class="text-center"><b>검색결과없음</b></h3>`);
					$("#pagination").hide();
				}else {
					$("#pagination").show();
					let lastpage = Math.ceil(data/5)
					$('#pagination').twbsPagination("changeTotalPages", lastpage, 1);	
				}
			}
		});
	}
	
	$('#pagination').twbsPagination({
		totalPages:1,	// 총 페이지 번호 수
		visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-caret-left-square-fill"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : `<i class="bi bi-caret-left"></i>`,	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-caret-right-square-fill"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function (event, page) {
			getLocalList(page);
		}
	});
	
	
	$(frm_local).on("submit", function(e){
		e.preventDefault();
		query = $(frm_local.query).val();
		getLocalTotal();
	});
</script>