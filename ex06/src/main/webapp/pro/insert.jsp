<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row justify-content-center my-5">
	<div class="col">
		<h1 class="text-center">상품등록</h1>
		<form name="frm_insert" class="card p-3">
			<div class="input-group my-2">
				<span class="input-group-text">상품이름</span>
				<input name="name" class="form-control">
			</div>
			<div class="input-group my-2">
				<span class="input-group-text">상품이름</span>				
				<input name="price" class="form-control">
			</div>
			<div class="text-center my-2">
				<input type="submit" value="상품등록" class="btn btn-success">
				<input type="reset" value="등록취소" class="btn btn-danger">
			</div>
		</form>
	</div>
</div>
<hr>

<script>
	$(frm_insert).on("submit", function(e){
		e.preventDefault();
		const name = $(frm_insert.name).val();
		const price = $(frm_insert.price).val();
		if(name==""){
			alert("이름을 입력해주세요.")
			$(frm_insert.name).focus();
		}else if (price==""){
			alert("가격을 입력해주세요.")
			$(frm_insert.price).focus();
		}else if(price.replace(/[0-9]/g, '')){
			alert("가격을 숫자료 입력해주세요.")
			$(frm_insert.price).val("");
			$(frm_insert.price).focus();
		}else {
			if(confirm("새로 등록하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"/pro/insert",
					data:{pname:name, pprice:price},
					success:function(){
						alert("등록을 완료했습니다.")
						$(frm_insert.name).val("");
						$(frm_insert.name).focus();
						$(frm_insert.price).val("");
						getTotal();
					}
				});
			}else {
				alert("등록을 취소했습니다.")
			}
		}
	});
</script>