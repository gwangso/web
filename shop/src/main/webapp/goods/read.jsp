<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row my-5">
	<div class="col">
		<h1 class="mb-5 ms-5">상품정보</h1>
		<div class="row">
			<div class="col-4 col-sm-5 col-xl-6">
				<img src="${vo.image}" width="90%">
			</div>
			<div class="col">			
				<h5>상품코드 : ${vo.gid}</h5>
				<br>
				<h5>상품명 : ${vo.title}</h5>
				<br>
				<div class="my-1">상품가격 : <fmt:formatNumber value="${vo.price}" pattern="#,###원"/></div>
				<div class="my-1">제조사 : ${vo.maker}</div>
				<div class="my-1">상품등록일 : ${vo.regDate}</div>
				<hr>
				<div>
					<button class="btn btn-outline-dark mx-1" id="btn_cart" gid="${vo.gid}">장바구니</button>
					<button class="btn btn-dark mx-1">바로구매</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$("#btn_cart").on("click",function(){
		const gid = $(this).attr("gid");
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{gid:gid},
			success:function(){
				if(confirm("계속 쇼핑하시겠습니까?")){
					location.href="/";
				}else {
					location.href="/cart/list"
				}
			}
		});
	});
</script>