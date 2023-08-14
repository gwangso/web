<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	#heart{
		font-size:2rem;
		color:red;
	}
	#review{
		font-size:2rem;
	}
</style>

<div class="row my-5">
	<div class="col">
		<h1 class="mb-5 ms-5">상품정보</h1>
		<div class="row mb-5">
			<div class="col-4 col-sm-5 col-xl-6">
				<img src="${vo.image}" width="90%" border="1" >
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
				<div class="row">
					<div class="col">
						<button class="btn btn-outline-dark mx-1" id="btn_cart" gid="${vo.gid}">장바구니</button>
						<button class="btn btn-dark mx-1">바로구매</button>
					</div>
					<div class="col text-end" id="count">
						<i class="bi bi-suit-heart" id="heart" style="cursor:pointer;"></i>
						<span id="fcnt"></span> &nbsp;&nbsp;
						<i class="bi bi-chat-left-text" id="review" style="cursor:pointer;"></i>
						<span id="rcnt"></span>
					</div>
				</div>
			</div>
		</div>
		<hr>
		<div class="my-3">
			<jsp:include page="/goods/review.jsp"/>
		</div>
	</div>
</div>

<script>
	getFavorite();
	function getFavorite(){
		$.ajax({
			type:"get",
			url:"/favorite/read",
			data:{uid, gid},
			dataType:"json",
			success:function(data){
				if(data.ucnt==1){
					$("#heart").removeClass("bi-suit-heart").addClass("bi-suit-heart-fill")
				}else{
					$("#heart").removeClass("bi-suit-heart-fill").addClass("bi-suit-heart")
				}
				$("#fcnt").html(data.fcnt);
			}
		});
	}
	
	//좋아요 추가
	$("#count").on("click", ".bi-suit-heart", function(){
		if(uid==""){
			alert("로그인이 필요한 기능입니다.")
			location.href="/user/login?target=/goods/read?gid="+gid;
		}else {
			$.ajax({
				type:"get",
				url:"/favorite/insert",
				data:{gid,uid},
				success:function(){
					getFavorite();
				}
			});
		}
	});
	
	//좋아요 삭제
	$("#count").on("click", ".bi-suit-heart-fill", function(){
		$.ajax({
			type:"get",
			url:"/favorite/delete",
			data:{gid,uid},
			success:function(){
				getFavorite();
			}
		});
	});
	
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