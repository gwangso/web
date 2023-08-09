<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<h1 class="ms-5">회원정보</h1>
		<form name="frm" class="card p-3" method="post" action="/user/update" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-3 mb-3 text-center">
					<c:if test="${vo.photo==null || vo.photo==''}">
						<img src="http://via.placeholder.com/100x100" width="80%" id="image">
					</c:if>
					<c:if test="${vo.photo!=null && vo.photo!=''}">
						<img src="${vo.photo}" width="80%" id="image">
					</c:if>
					<input type="file" name="photo" style="display:none;">
					<input type="hidden" name="oldPhoto" value="${vo.photo}"/>
				</div>
				<div class="col">
					<div class="input-group mb-3">
						<span class="input-group-text">아이디</span>
						<input name="uid" class="form-control" value="${vo.uid}" readonly>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">비밀번호</span>
						<input name="upass" type="password" class="form-control" readonly>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">회원이름</span>
						<input name="uname" class="form-control" value="${vo.uname}">
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">전화번호</span>
				<input name="phone" class="form-control" value="${vo.phone}">
			</div>
			<div class="input-group mb-1">
				<span class="input-group-text">주소</span>
				<input name="address1" class="form-control" value="${vo.address1}" readonly>
				<a id="btn_search" class="btn btn-primary">주소검색</a>
			</div>
			<div class="input-group mb-1">
				<span class="input-group-text">상세주소</span>
				<input name="address2" class="form-control" value="${vo.address2}">
			</div>
			<div class="text-center my-3">
				<button class="btn btn-primary px-5">정보수정</button>
			</div>
		</form>
	</div>
</div>

<script>


	$(frm).on("submit", function(e){
		e.preventDefault();
		const uname = $(frm.uname).val();
		if(uname==""){
			alert("이름을 입력해주세요.")
			$(frm.uname).focus();
		}else {
			if(confirm("정보수정을 하시겠습니까?")){
				frm.submit();
			}
		}
	});
	
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