<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품수정</h1>
		<form name="frm" class="card p-3" method="post" enctype="multipart/form-data"> <!-- 파일까지 넘겨줄때 enctype해줘야함 -->
			<div class="input-group mb-3">
				<span class="input-group-text">상품코드</span>
				<input name="gid" class="form-control" value="${vo.gid}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상품이름</span>
				<input name="title" class="form-control" value="${vo.title}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상품가격</span>
				<input name="price" class="form-control" value="${vo.price}" oninput="isNumber(this)">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">제&nbsp;조&nbsp;사&nbsp;</span>
				<input name="maker" class="form-control" value="${vo.maker}">
			</div>
			<div class="input-group mb-3">
				<input name="image" class="form-control" type="file" accept="image/*"> <!-- 이미지는 파일로 타입을 받을예정 -->
				<input name="old_image" value="${vo.image}" type="hidden">
			</div>
			<div class="text-center mb-3"> <!-- 더미이미지 -->
				<img src="${vo.image}" width="50%" id="image">
			</div>
			<div>
				<input type="submit" value="상품수정" class="btn btn-primary">
				<input type="reset" value="수정취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>

<script>
	//숫자만 입력
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const title = $(frm.title).val();
		const price = $(frm.price).val();
		if(title=="" || price==""){
			alert("상품이름, 가격을 입력하세요!")
			$(frm.title).focus();
		}else{
			if(confirm("상품을 저장하실레요?")){
				//수정하기
				frm.submit();
			}
		}
	});
	
	//이전이미지
	const oldImage="${vo.image}";
	
	//이미지 미리보기
	$(frm.image).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));
	});
	//frm.image는 input으로 파일선택부분이고 #image는 미리보기창이다.
	
	//리셋버튼 누를경우
	$(frm).on("reset", function(){
		$("#image").attr("src", oldImage);
	});
</script>