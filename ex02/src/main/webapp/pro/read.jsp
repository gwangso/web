<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row my-5">
	<div class="col">
		<h1>상품정보</h1>
		<div class="card p-3">
			<h5>상품코드: ${vo.pcode}</h5>
			<h5>상품명: ${vo.pname}</h5>
			<h5>상품가격: <fmt:formatNumber value="${vo.pprice}" pattern="#,###원"/></h5>
			<h5>상품등록일: <fmt:formatDate value="${vo.pdate}" pattern="yyyy-MM-dd"/></h5>
		</div>
		<div class="text-center">
			<button class="btn btn-primary" id="product_update">수정</button>
			<button class="btn btn-danger" id="product_delete">삭제</button>
		</div>
	</div>
</div>

<script>
	const code= "${vo.pcode}";

	$("#product_update").on("click", function(){
		location.href="/pro/update?pcode="+code;
	})

	$("#product_delete").on("click", function(){
		if(confirm(code + "번 상품을 삭제하실레요?")){
			location.href="/pro/delete?pcode="+code;
		}
	})
</script>