<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-4">
	<div class="col">
		<h1 class="text-center my-3">학생목록</h1>
		<div class="row my-4">
			<form name="frm" class="col-10 col-md-6 col-xl-4">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="scode">학생번호</option>
						<option value="sname" selected>학생이름</option>
						<option value="dept">학과</option>
						<option value="year">학년</option>
						<option value="pname">지도교수</option>						
					</select>&nbsp; <!-- 한칸 띄라는 의미 -->
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			<div class="col text-end">
				<button id="btn_insert" class="btn btn-primary">학생등록</button>
			</div>
		</div>
		<div id="div_stu_list"></div>
		<div id="pagination" class="pagination justify-content-center my-3"></div>
	</div>
</div>

<div class="modal fade" id="modal_insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  	<div class="modal-dialog  modal-lg">
    	<div class="modal-content">
      		<div class="modal-header">
        		<h1 class="modal-title fs-5" id="staticBackdropLabel">학생등록</h1>
        		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      		</div>
		    <div class="modal-body">
		    <jsp:include page="insert.jsp"/>
		    </div>
    	</div>
  	</div>
</div>


<script id="temp_stu_list" type="text/x-handlebars-template">
	<table class="table table-hover">
		<tr class="table-warning">
			<th>학생번호</th>
			<th>학생이름</th>
			<th>소속학과</th>
			<th>학년</th>
			<th>생년월일</th>
			<th>지도교수</th>
			<th>수강신청</th>
		</tr>
		{{#each .}}
		<tr class="stu" scode={{scode}}>
			<td>{{scode}}</td>
			<td><a href="/stu/update?scode={{scode}}">{{sname}}</a></td>
			<td>{{dept}}</td>
			<td>{{year}}</td>
			<td>{{birthday}}</td>
			<td>{{pname}}({{advisor}})</td>
			<td>
				<a href="/stu/enroll?scode={{scode}}">
					<button class="btn btn-primary btn-sm">수강신청</button>
				</a>
			</td>
		</tr>
		{{/each}}
	</table>
</script>


<script src="/js/script.js"></script>
<script>
	let url="stu";
	getTotal();

	$("#btn_insert").on("click",function(){
		$("#modal_insert").modal("show");
	})
	
	/*
	let query="";
	let key=$(frm_stu.key).val();
	
	getStuTotal();
	
	function getStuList(page){
		$.ajax({
			type:"get",
			url:"/stu/list.json",
			data:{query:query, page:page, key:key},
			dataType:"json",
			success:function(data){
				const com_temp_stu_list = Handlebars.compile($("#temp_stu_list").html());
				const html_stu_list = com_temp_stu_list(data);
				$("#div_stu_list").html(html_stu_list);
			}
		});
	}
	
	$('#stu_pagination').twbsPagination({
		totalPages:5,	// 총 페이지 번호 수
		visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-caret-left-square-fill"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : `<i class="bi bi-caret-left"></i>`,	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-caret-right-square-fill"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function (event, page) {
			getStuList(page);
		}
	});
	
	function getStuTotal(){
		$.ajax({
			type:"get",
			url:"/stu/total",
			data:{query:query, key:key},
			success:function(data){
				if(data==0){
					$("#stu_pagination").hide();
					$("#div_stu_list").html(`<h3 class="text-center my-5"><b>검색결과없음</b><h3>`);
					$(frm_stu.query).val("");
				}else {
					$("#stu_pagination").show();
					const stuTotalPages = Math.ceil(data/5);
					$("#stu_pagination").twbsPagination("changeTotalPages", stuTotalPages, 1)
				}
			}
		})
	}
	
	$(frm_stu).on("submit",function(e){
		e.preventDefault();
		query=$(frm_stu.query).val();
		key=$(frm_stu.key).val();
		getStuTotal();
	});
	*/
</script>