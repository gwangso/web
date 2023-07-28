<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row mb-5 justify-content-center">
	<div class="col-md-6">
		<h1>상품수정</h1>
		<form name="frm" class="card p-3" method="post">
			<div class="input-group my-3">
				<span class="input-group-text">상품코드</span>
				<input name="pcode" class="form-control" placeholder="상품이름" value="${vo.pcode}" readonly>
			</div>
			<div class="input-group my-3">
				<span class="input-group-text">상품이름</span>
				<input name="pname" class="form-control" placeholder="상품이름" value="${vo.pname}">
			</div>
			<div class="input-group my-3">
				<span class="input-group-text">상품가격</span>
				<input name="pprice" class="form-control" placeholder="상품가격" value="${vo.pprice}">
			</div>
			<div>
				<input type="submit" value="상품등록" class="btn btn-outline-success">
				<input type="reset" value="상품취소" class="btn btn-outline-danger">
			</div>
		</form>
	</div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		let name=$(frm.pname).val();
		let price=$(frm.pprice).val();
		if(name==""){
			alert("상품이름을 입력해주세요");
			$(frm.pname).focus();
		}else if(price==""){
			alert("가격을 입력하세요");
			$(frm.pprice).focus();
		}else if(price.replace(/[0-9]/g,'')){ // 숫자가 아니면이라는 의미의 정규식
			alert("가격은 숫자랍니다. 재대로 해주세요^^");
			$(frm.pprice).val("");
			$(frm.pprice).focus();
		}else {
			if(confirm("변경하시겠습니까?"))
				frm.submit();
		}
	})
	

</script>
