<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center my-3">주문목록</h1>
		<div class="row my-4">
			<form name="frm" class="col-10 col-md-6 col-xl-4">
				<div class="input-group">
					<select class="form-select" name="key">
						<option value="uid">회원아이디</option>
						<option value="uname" selected>회원이름</option>
						<option value="raddress1">배송지주소</option>
						<option value="rphone">전화번호</option>						
					</select>&nbsp; <!-- 한칸 띄라는 의미 -->
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_purchase"></div>
	</div>
</div>

<script id="temp_purchase" type="x-handlebars-template">
	<table class="table">
			<tr class="table-dark">
				<th>주문번호</th>
				<th>주문자</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>금액</th>
				<th>주문일자</th>
			</tr>
		{{#each .}}
			<tr>
				<td>{{pid}}</td>
				<td>{{uname}}({{uid}})</td>
				<td>{{address1}} {{address2}}</td>
				<td>{{phone}}</td>
				<td>{{purSum}}</td>
				<td>{{purDate}}</td>
				<td>
					<select class="form-select">
						<option value="0">결재완료</option>
						<option value="0">상품준비중</option>
						<option value="0">배송시작</option>
						<option value="0">배송중</option>
						<option value="0">배송완료</option>		
					</select>
				</td>
			</tr>			
		{{/each}}
	</table>
</script>

	
<script>
	let page=1;
	let query=$(frm.query).val();
	let key = $(frm.key).val();
	
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/purchase/list.json",
			data:{page:page, key:key, query:query},
			dataType:"json",
			success:function(data){
				const temp=Handlebars.compile($("#temp_purchase").html());
				$("#div_purchase").html(temp(data));
			}
		});
	}
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key = $(frm.key).val();
		page=1;
		getList();
	});
</script>