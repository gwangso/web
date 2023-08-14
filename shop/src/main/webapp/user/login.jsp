<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5 justify-content-center">
	<div class="col-xl-6 col-md-8 my-5">
		<h1 class="my-3 text-center">Login</h1>
		<form name="frm" class="card p-5">
			<input name="uid" class="form-control mb-3" placeholder="아이디">
			<input name="upass" type="password" class="form-control mb-3" placeholder="비밀번호" value="pass">
			<button class="btn btn-primary w-100">로그인</button>
			<div class="row mt-3">
				<div class="col text-start">
					<input type="checkbox" name="isLogin">로그인 상태유지
				</div>
				<div class="col text-end">
					<a href="/user/insert">회원가입</a>
				</div>
			</div>
		</form>
	</div>
</div>

<script>

	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		const isLogin = $(frm.isLogin).is(":checked");
		if(uid==""){
			alert("아이디를 입력해주세요")
		}else if (upass==""){
			alert("비밀번호를 입력해주세요")
		}else {
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid:uid, upass:upass, isLogin:isLogin},
				success:function(data){
					if(data==0){
						alert("아이디가 존재하지 않습니다.")
					}else if(data==2){
						alert("비밀번호가 일치하지 않습니다.")
					}else {
						const target="${target}";
						if (target==""){
							location.href="/";
						}else{
							location.href=target;
						}
					}
				}
			});
		}
	});

</script>