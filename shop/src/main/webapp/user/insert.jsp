<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
	span{
		width: 150px;
		justify-content: center;
	}
	#image {
		border-radius:50%;
		cursor:pointer;
		border:2px solid gray;
	}
</style>

<div class="row my-5">
	<div class="col">
		<h1 class="ms-5">회원가입</h1>
		<form name="frm" class="card p-3" method="post" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-3 mb-3 text-center">
					<img src="http://via.placeholder.com/100x100" width="80%" id="image">
					<input type="file" name="photo" style="display:none;">
				</div>
				<div class="col">
					<div class="input-group mb-3">
						<span class="input-group-text">아이디</span>
						<input name="uid" class="form-control">
						<a class="btn btn-primary" id="btn_check">중복체크</a>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">비밀번호</span>
						<input name="upass" type="password" class="form-control">
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">회원이름</span>
						<input name="uname" class="form-control">
					</div>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">전화번호</span>
					<input name="phone" class="form-control">
				</div>
				<div class="input-group mb-1">
					<span class="input-group-text">주소</span>
					<input name="address1" class="form-control" readonly>
					<a id="btn_search" class="btn btn-primary">주소검색</a>
				</div>
				<div class="input-group mb-3">
					<span class="input-group-text">세부주소</span>
					<input name="address2" class="form-control">
				</div>
				<div class="text-end my-3">
					<button class="btn btn-primary me-3">회원가입</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>

	let check = false;
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		const uname = $(frm.uname).val();
		if(uid==""){
			alert("아이디를 입력해주세요.");
			$(frm.uid).focus();
		}else if (check==false){
			alert("아이디 중복체크가 필요합니다.")
		}else if(upass==""){
			alert("비밀번호르 입력해주세요.")
			$(frm.upass).focus();
		}else if(uname==""){
			alert("이름을 입력해주세요.")
			$(frm.uname).focus();
		}else {
			if(confirm("회원가입을 하시겠습니까?")){
				frm.submit();
			}
		}
	});

	$("#btn_check").on("click", function(){
		const uid = $(frm.uid).val();
		if(uid==""){
			alert("아이디를 입력해주세요.");
			$(frm.uid).focus();
		}else {
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid:$(frm.uid).val(), pass:""},
				success:function(data){
					if(data==0){
						alert("사용가능한 아이디입니다.")
						check=true;
					}else {
						alert("이미 사용중인 아이디입니다.다시입력해주세요")
						$(frm.uid).val("");
						$(frm.uid).focus();
					}
				}
			});			
		}
	});
	
	$(frm.uid).on("change", function(){
		check=false;
	})
	
	$("#image").on("click", function(){
		$(frm.photo).click();
	})
	
	$(frm.photo).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));
	})
	
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
</script>