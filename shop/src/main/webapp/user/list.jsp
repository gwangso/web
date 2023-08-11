<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center my-3">회원목록</h1>
		<div class="row my-4">
			<form name="frm" class="col-10 col-md-6 col-xl-4">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="uid">아이디</option>
						<option value="uname" selected>회원명</option>
						<option value="address1">주소</option>
						<option value="phone">전화번호</option>						
					</select>&nbsp; <!-- 한칸 띄라는 의미 -->
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_user"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_user" type="text/x-handlebars-template">
	{{#each .}}
		<div class="card mb-3">
			<div class="row">
				<div class="col-6 col-md-3">
					<img src="{{photo}}" width="90%">
				</div>
				<div class="col">
					<div>{{uname}} ({{uid}})</div>
					<div>{{address1}} {{address2}}</div>
					<div>{{phone}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>

<script>
	let page=1;
	let query="";
	let key=$(frm.key).val();
	
	getTotal();
	function getList(){
		$.ajax({
			type:"get",
			url:"/user/list.json",
			data:{key:key, query:query, page:page},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_user").html());
				$("#div_user").html(temp(data));
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/user/total",
			success:function(data){
				if(data==0){
					$("#div_user").html("<h3 class='text-center'>등록한 회원이 없어요ㅠㅠ</h3>")
				}else {
					const totalPages = Math.ceil(data/5);
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1)
				}
			}
		});
	}
	
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		key=$(frm.key).val();
		query=$(frm.query).val();
		getList();
	});
	
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) { //curPage는 클릭한 페이지의 값이 들어간다.
	    	page=curPage;
	    	getList();
	    }
	});
</script>