<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center my-3">주문목록</h1>
		<div class="row my-4">
			<form name="frm" class="col-8 col-md-6 col-xl-4">
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
			<div class="col"></div>
			<div class="text-end col-4">
				<select class="form-select" id="sel_status">
					<option value="0">결제대기중</option>
					<option value="1">결제완료</option>
					<option value="2">상품준비중</option>
					<option value="3">배송준비중</option>
					<option value="4">배송중</option>		
					<option value="5">배성완료</option>		
					<option value="6">구매확정</option>		
				</select>
			</div>
		</div>
		<div id="div_purchase"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
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
				<th colspan="2">상품상태</th>
			</tr>
		{{#each .}}
			<tr>
				<td class="pid"><a href="/purchase/read?pid={{pid}}">{{pid}}</a></td>
				<td>{{uname}}({{uid}})</td>
				<td>{{address1}} {{address2}}</td>
				<td>{{phone}}</td>
				<td>{{purSum}}</td>
				<td>{{purDate}}</td>
				<td>
					<select class="form-select status">
						<option value="0" {{select status 0}}>결제대기중</option>
						<option value="1" {{select status 1}}>결제완료</option>
						<option value="2" {{select status 2}}>상품준비중</option>
						<option value="3" {{select status 3}}>배송준비중</option>
						<option value="4" {{select status 4}}>배송중</option>		
						<option value="5" {{select status 5}}>배성완료</option>		
						<option value="6" {{select status 6}}>구매확정</option>		
					</select>
				</td>
				<td>
					<button class = "btn btn-update btn-primary btn-sm">상태변경</button>
				</td>
			</tr>			
		{{/each}}
	</table>
</script>

<script>
	
	Handlebars.registerHelper("select", function(status, value){
		if (status==value) return "selected";
	});
</script>
	
<script>
	let page=1;
	let query=$(frm.query).val();
	let key = $(frm.key).val();
	
	getTotal();
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
	
	//검색수
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/purchase/total",
			data:{key:key, query:query},
			success:function(data){
				if(data==0){
					$("#div_purchase").html("<h3 class='text-center my-5'>검색결과가 없습니다.</h3>");
				}else {
					const totalPages = Math.ceil(data/5);
					$("#pagination").twbsPagination("changeTotalPages", totalPages, 1)
				}
				if(data>5){
					$("#pagination").show();
				}else {
					$("#pagination").hide();
				}
			}
		});
	}
	
	$(frm).on("submit",function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key = $(frm.key).val();
		getTotal();
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
	
	$("#div_purchase").on("click", ".btn-update", function(){
		const row = $(this).parent().parent();
		const pid = row.find(".pid").text();
		const status = row.find(".status").val();
		if(confirm("상태를 변경하시겠습니까?")){
			//상태변경
			$.ajax({
				type:"post",
				url:"/purchase/update",
				data:{pid:pid, status:status},
				success:function(){
					alert("상태가 변경되었습니다.");
					getList();
				}
			});
		}
	});
	
	$("#sel_status").on("change", function(){
		key="status";
		query=$(this).val();
		getTotal();
	});
</script>