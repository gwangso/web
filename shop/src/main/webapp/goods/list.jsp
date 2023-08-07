<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-3">
	<div class="col">
		<h1 class="text-center">**쇼핑몰</h1>
		<div class="row mb-3">
			<form name="frm" class="col-10 col-sm-6 col-xl-4">
				<div class="input-group">
					<input name=query class="form-control" value="">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_list" class="row"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_list" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<th>상품번호</tH>
			<th>썸네일</tH>
			<th>상품명</th>
			<th>상품가격</th>
			<th>제작자</th>
			<th>저장버튼</th>
		</tr>
		{{#each .}}
		<tr>
			<td class="gid">{{gid}}</td>
			<td><img class="image" src="{{image}}" width="50px"></td>	
			<td>{{title}}</td>	
			<td>{{fmtPrice price}}</td>
			<td>{{maker}}</td>
			<td><button class="btn btn-danger btn-sm" gid="{{gid}}" image="{{image}}">삭제</button></td>	
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
</script>

<script>
	let page=1;
	let query="";
	
	getTotal();
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_list").html());
				$("#div_list").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
				if(data==0){
					query="";
					$("#div_list").html(`<h3 class="text-center"><b>상품이 없습니다.</b></h3>`);
				}else {
					const totalPages=Math.ceil(data/6);
					$("#pagination").twbsPagination("changeTotalPages", totalPages,1);					
				}
			}
		});
	}
	
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	page=curPage;
	    	getList();
	    }
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		if(query==""){
			alert("검색어를 입려하세요!");
			$(frm.query).focus();
		}else {
			page=1;
			getTotal();
		}
	});
	
	//삭제버튼 클릭
	$("#div_list").on("click", ".btn-danger", function(){
		const row = $(this).parent().parent();
		const gid = row.find(".gid").text();
		const image=$(this).attr("image");
		if(confirm("해당 파일을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid:gid, image:image},
				success:function(){
					alert("상품이 삭제되었습니다.");
					getTotal();
				}
			});
		}
	});
</script>