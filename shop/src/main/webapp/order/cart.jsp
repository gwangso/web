<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div id="page_cart" class="row my-5">
	<div class="col">
		<h1 class="ms-5 mb-5">장바구니</h1>
		<div id="div_cart"></div>
		
	</div>
</div>

<jsp:include page="order.jsp"/>

<!-- 카트 목록 템플릿 -->
<script id="temp_cart" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<th><input type="checkbox" id="all"></th>
			<th>상품이미지</th>
			<th>상품번호</th>
			<th>상품이름</th>
			<th>가격</th>
			<th>수량</th>
			<th>총 가격</th>
			<th>삭제</th>
		</tr>
		{{#each .}}
		<tr class="tr" price="{{price}}">
			<td><input type="checkbox" class="chk" goods="{{toString @this}}"></td>
			<td class="gid">{{gid}}</td>
			<td><img src="{{image}}" width="50px"></td>
			<td class="text-truncate" style="max-width:200px;">{{title}}</td>
			<td>{{sum price 1}}</td>
			<td>
				<input class="qnt" value="{{qnt}}" size=5 onInput="isNumber(this)">&nbsp;
				<button class="btn btn-primary btn-sm btn-update">수정</button>
			</td>
			<td>{{sum price qnt}}</td>
			<td><button class="btn btn-danger btn-sm" gid="{{gid}}">삭제</button></td>			
		</tr>
		{{/each}}
		<tr>
			<td colspan="7" class="text-end pe-2">
				총합계 : <span id="sum">0원</span>
			</td>
			<td></td>
		</tr>
	</table>
	<div class="text-end mt-3 me-5">
			<button id="btn_order" class="btn btn-primary">주문하기</button>
	</div>
</script>

<script>
	Handlebars.registerHelper("sum", function(price, qnt){
		const sum =  price*qnt;
		return sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
	
	Handlebars.registerHelper("toString", function(goods){
		return JSON.stringify(goods);
	})
</script>

<script>

	const uid="${user.uid}";

	getList();
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			success:function(data){
				if(data.length==0){
					$("#div_cart").html(`<h3 class="text-center">장바구니에 담은 상품이 없습니다.</h3>`);
				}else{
					const temp=Handlebars.compile($("#temp_cart").html());
					$("#div_cart").html(temp(data));
					getSum();					
				}
			}
		});
	}
	
	$("#div_cart").on("click", ".btn-danger", function(){
		const gid = $(this).attr("gid");
		if(confirm(gid+"번 상품을 삭제하실레요?")){
			$.ajax({
				type:"get",
				url:"/cart/delete",
				data:{gid:gid},
				success:function(){
					getList();
				}
			});
		}
	});
	
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
	
	//각행의 수정버튼을 누른 경우
	$("#div_cart").on("click", ".btn-update", function(){
		const row = $(this).parent().parent();
		const gid = row.find(".gid").text();
		const qnt = row.find(".qnt").val();
		if(confirm(gid + "상품의 수량을 " + qnt + "로 변경하실레요?")){
			$.ajax({
				type:"get",
				url:"/cart/update",
				data:{gid:gid, qnt:qnt},
				success:function(){
					getList();
				}
			});
		}
	});
		
	function getSum(){
		let sum = 0;
		$("#div_cart .tr").each(function(){
			if($(this).find(".chk").is(":checked")){
				const price=$(this).attr("price");
				const qnt=$(this).find(".qnt").val();
				sum += price*qnt;				
			}
		});
		$("#sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	}
	
	//all을 체크하면
	$("#div_cart").on("click", "#all",function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
		getSum();
	});
	
	//chk를 모두 체크하면
	$("#div_cart").on("click", ".chk", function(){
		const all=$("#div_cart .chk").length; //length는 속성값
		const chk = $("#div_cart .chk:checked").length;
		if(all==chk){
			$("#div_cart #all").prop("checked", true);
		}else{
			$("#div_cart #all").prop("checked", false);
		}
		getSum();
	});
	
	//주문하기 버튼 클릭
	$("#div_cart").on("click", "#btn_order", function(){
		const chk = $("#div_cart .chk:checked").length;
		if(uid==""){
			alert("로그인이 필요합니다.")
			location.href="/user/login?target=/cart/list"; //user/login으로 가는데 target을 cart/list를 줌
		}else {
			if(chk==0){
				alert("주문할 상품을 선택해주세요.")
			}else{
				let data=[];
				$("#div_cart .chk:checked").each(function(){
					const goods=$(this).attr("goods");
					data.push(JSON.parse(goods))
				});
				getOrder(data);
				$("#page_order").show();
				$("#page_cart").hide();
			}
		}
	});
</script>