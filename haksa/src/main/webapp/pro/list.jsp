<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center">교수목록</h1>
		<div class="row my-4">
			<form name="frm_pro" class="col-10 col-md-6 col-xl-4">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="pcode">교수번호</option>
						<option value="pname" selected>교수이름</option>
						<option value="dept">교수학과</option>
						<option value="title">교수직급</option>						
					</select>&nbsp; <!-- 한칸 띄라는 의미 -->
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			<div class="col text-end">
				<button id="btn_pro_insert" class="btn btn-primary">교수등록</button>
			</div>
		</div>
		<div id="div_pro_list"></div>
		<div id="pro_pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<!-- 교수등록Modal -->
<div class="modal fade modal-lg" id="insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">Modal title</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
			<jsp:include page="/pro/insert.jsp"/>
			</div>
		</div>
	</div>
</div>

<script id="temp_pro_list" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-warning">
			<th>교수번호</th>
			<th>교수이름</th>
			<th>소속 학과</th>
			<th>임용일</th>
			<th>직급</th>
			<th>급여</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{pcode}}</td>
			<td><a href="/pro/update?pcode={{pcode}}">{{pname}}</a></td>
			<td>{{dept}}</td>
			<td>{{hiredate}}</td>
			<td>{{title}}</td>
			<td>{{salary}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	let query="";
	let key = $(frm_pro.key).val();
	
	getProTotal();
	
	function getProList(page){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data: {page:page, query:query, key:key},
			dataType:"json",
			success:function(data){
				const com_temp_pro_list = Handlebars.compile($("#temp_pro_list").html());
				const html_pro_list = com_temp_pro_list(data);
				$("#div_pro_list").html(html_pro_list);
			}
		});
	}
	
	$("#btn_pro_insert").on("click", function(){
		$("#insert").modal("show");
	})
	
	$('#pro_pagination').twbsPagination({
		totalPages:5,	// 총 페이지 번호 수
		visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-caret-left-square-fill"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : `<i class="bi bi-caret-left"></i>`,	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-caret-right-square-fill"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function (event, page) {
			getProList(page);
		}
	});
	
	function getProTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query, key:key},
			success:function(data){
				if(data==0){
					$("#pro_pagination").hide();
					$("#div_pro_list").html(`<h3 class="text-center my-5"><b>검색결과없음</b><h3>`);
					$(frm_pro.query).val("");
				}else {
					$("#pro_pagination").show();
					const proTotalPages = Math.ceil(data/5);
					$("#pro_pagination").twbsPagination("changeTotalPages", proTotalPages, 1)
				}
			}
		});
	}
	
	$(frm_pro).on("submit", function(e){
		e.preventDefault();
		key=$(frm_pro.key).val();
		query=$(frm_pro.query).val();
		getProTotal();
	})
	
</script>