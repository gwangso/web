<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="insert.jsp"></jsp:include>

<div class="row">
	<div class="col">
		<!-- 제목 -->
		<h1 class="text-center">상품목록</h1>
		<!-- 검색창 -->
		<div class="row justify-content-end mb-2">
			<div class="col align-self-center">
				<span>검색수</span>
				<span id="search_total">100</span>
			</div>
			<form name="frm_list" class="col-6 col-md-4 ">
				<div class="input-group my-3">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<!-- 상품목록칸 -->
		<div id="div_list"></div>
		<!-- 페이지 -->
		<div id="pagination" class="pagination justify-content-center"></div>
		
	</div>
</div>


<script id="temp_list" type="text/x-handlebars-template">
	<table class="table align-middle">
		<tr class="table-dark">
			<td>상품코드</td>
			<td>상품이름</td>
			<td class="text-end">상품가격</td>
			<td>상품등록일</td>	
			<td>삭제</td>
			<td>수정</td>
		</tr>
		{{#each .}}
		<tr> 
			<td class="code">{{pcode}}</td>
			<td><input class="name" value="{{pname}}"></td>
			<td class="text-end">
				<input class="price text-end" value = "{{pprice}}">
				<br>
				<span class="fprice">{{fprice}}</spna>
			</td>
			<td>{{fdate}}</td>
			<td><button class="btn btn-danger btn-sm" code="{{pcode}}">삭제</button></td>
			<td><button class="btn btn-warning btn-sm"}">수정</button></td>		
		</tr>
		{{/each}}
	</table>	
</script>

<script>
	let query="";

	getTotal();

	$(frm_list).on("submit",function(e){
		e.preventDefault();
		query=$(frm_list.query).val();
		getTotal();
	});

	function getList(page){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				const com_temp_list = Handlebars.compile($("#temp_list").html());
				const html_list = com_temp_list(data);
				$("#div_list").html(html_list);
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query},
			success:function(data){
				const totalPages = Math.ceil(data/5);
				$("#search_total").html(data);
				if(data==0){
					$("#div_list").html(`<h3 class="text-center"><b>상품없음</b></h3>`)
					$("#pagination").hide();
				}else {
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);					
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
			getList(page);
		}
	});
	
	//삭제버튼 클릭
	$("#div_list").on("click", ".btn-danger", function(){
		const code=$(this).attr("code");
		const name=$(this).parent().parent().find(".name").text();
		if(confirm(name + " 상품을 삭제하시겠습니까??")){
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{code:code},
				success:function(){
					alert("삭제완료")
					getTotal();
				}
			});
		}else {
			alert("삭제가 취소되었습니다.")
		}
	});
	
	//수정버튼 클릭
	$("#div_list").on("click", ".btn-warning",function(){
		const row =$(this).parent().parent();
		const code = row.find(".code").html();
		const name = row.find(".name").val();
		const price = row.find(".price").val();
		if(confirm('상품정보를 수정하실래요?')){
			$.ajax({
				type:"post",
				url:"/pro/update",
				data:{pcode:code, pname:name, pprice:price},
				success:function(){
					alert("수정완료!");
				}
			});
		}else {
			alert("수정을 취소합니다.");
		}
	});
</script>