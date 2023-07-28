<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1>상품등록</h1>
		<form class="card p-3" name="frm_insert">
			<input name="name" class="form-control my-2" placeholder="상품이름">
			<input name="price" class="form-control my-2" placeholder="상품가격">
			<div>
				<input type="submit" value="상품등록" class="btn btn-success"> <input
					type="reset" value="등록취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>

<script>
	$(frm_insert).on("submit",function(e){
		e.preventDefault();
		const name=$(frm_insert.name).val();
		const price=$(frm_insert.price).val();
		if(name==""){
			alert("상품이름을 입력하세요!")
			$(frm_insert.name).focus();
		}else if(price==""){
			alert("상품이름을 입력하세요!")
			$(frm_insert.price).focus();			
		}else if(price.replace(/[0-9]/g, '')){
			alert("상품가격은 숫자를 입력하는거에요. 아셧죠?")
			$(frm_insert.price).val("");
			$(frm_insert.price).focus();
		}else{
			if(confirm("새로운 상품을 등록하실래요?"))
				$.ajax({
					url:"/pro/insert",
					type:"post",
					data:{pname:name, pprice:price},
					success:function(){
						alert("등록이 완료되었습니다.");	
						$(frm_insert.name).val("");
						$(frm_insert.price).val("");
						getList();
					}
				})
			else {
				alert("상품등록이 취소되었습니다.")
			}
		}
	})
</script>