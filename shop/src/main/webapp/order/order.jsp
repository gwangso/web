<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="page_order" class="row my-5" style="display: none ;">
	<div class="col">
		<h1 class="ms-5 mb-3">주문</h1>
		<div id="div_order"></div>
		<div id="div_userinfo" class="my-3">
			<form name="frm" class="card p-3">
				<div class="input-group mb-3">
					<span class="input-group-text">주문자</span>
					<input name="uname" class="form-control" value="${user.uname}">
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">전화번호</span>
					<input name="rphone" class="form-control" value="${user.phone}">
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">주소</span>
					<input name="raddress1" class="form-control" value="${user.address1}">
					<a id="btn_search" class="btn btn-primary">주소검색</a>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">상세주소</span>
					<input name="raddress2" class="form-control" value="${user.address2}">
				</div>
				<input name="sum" type="hidden">
				<div class="my-3 text-center">
					<button class="btn btn-primary px-5">주문하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 주문상품목록 템플릿 -->
<script id="temp_order" type="x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<th>상품코드</th>
			<th>상품이미지</th>
			<th>상품명</th>
			<th>상품가격</th>
			<th>상품수량</th>
			<th class="text-center">상품총액</th>
		</tr>
		{{#each .}}
		<tr class="tr" price={{price}} gid="{{gid}}" qnt="{{qnt}}">
			<td>{{gid}}</td>
			<td><img src="{{image}}" width="50px"></td>
			<td class="text-truncate" style="max-width:200px;">{{title}}</td>
			<td>{{sum price 1}}</td>		
			<td class="qnt">{{qnt}}</td>	
			<td class="text-center">{{sum price qnt}}	
		</tr>
		{{/each}}
		<tr>
			<td colspan="5">
			</td>
			<td class="text-center">
				총합계 : <span id="order_sum">0원</span>
			</td>
		</tr>
	</table>
</script>

<script>
	function getOrder(data){
		const temp = Handlebars.compile($("#temp_order").html())
		$("#div_order").html(temp(data));
		getOrderSum();
	}
	
	//총액
	function getOrderSum(){
		let sum = 0;
		$("#div_cart .tr").each(function(){
			const price=$(this).attr("price");
			const qnt=$(this).find(".qnt").val();
			sum += price*qnt;				
		});
		$("#order_sum").html(sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
		$(frm.sum).val(sum);
	}
	
	//주소검색창
	$("#btn_search").on("click", function(){
		new daum.Postcode({
			oncomplete: function(data){
				if(data.buildingName!=""){
					$(frm.address1).val(data.address + " " + data.buildingName);					
				}else {
					$(frm.address1).val(data.address);
				}
			}
		}).open();
	});
	
	//주문하기버튼
	$(frm).on("submit",function(e){
		e.preventDefault();
		if(confirm("위 상품을 주문하실레요?")){
			$.ajax({
				type:"post",
				url:"/purchase/insert",
				data:{uid:"${user.uid}", 
					raddress1:$(frm.raddress1).val(),
					raddress2:$(frm.raddress2).val(),
					rphone:$(frm.rphone).val(),
					sum:$(frm.sum).val()},
				success:function(data){
					//주문상품 등록
					const pid = data;
					$("#div_order .tr").each(function(){
						const gid = $(this).attr("gid");
						const qnt = $(this).attr("qnt");
						const price = $(this).attr("price");
						$.ajax({
							type:"post",
							url:"/order/insert",
							data:{pid:pid, gid:gid, price:price, qnt:qnt},
							success:function(){
								//장바구니 상품 삭제
								$.ajax({
									type:"get",
									url:"/cart/delete",
									data:{gid:gid},
									success:function(){
										
									}
								});
							}
						});
					});
					alert("주문이 완료되었습니다.");
					location.href="/";
				}
			});
		}
	});
</script>