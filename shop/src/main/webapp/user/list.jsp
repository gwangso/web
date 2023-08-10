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
	
	getList();
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
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		key=$(frm.key).val();
		query=$(frm.query).val();
		getList();
	});
	
</script>