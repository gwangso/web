<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<form name="frm_insert" method="post" action="/stu/insert">
	<div class="input-group mb-3">
		<span class="input-group-text">학생이름</span>
		<input name="sname" class="form-control">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">학생학과</span>
		<select name="dept" class="form-select">
			<option value="컴정">컴퓨터정보공학</option>
			<option value="전자">전자공학</option>
			<option value="생명" selected>생명공학</option>
			<option value="전산">전산공학</option>	
			<option value="화학">화학공학</option>	
			<option value="건축">건축공학</option>	
		</select>
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">생년월일</span>
		<input name="birthday" type="date" class="form-control" value="2023-03-02">
	</div>
	<div class="input-group mb-3">
		<div class="input-group-text px-2 me-2">학년</div>
		<div class="form-check form-check-inline align-self-center">
  			<input class="form-check-input" type="radio" name="year" value="1" checked>
  			<label class="form-check-label" for="inlineCheckbox1">1학년</label>
		</div>
		<div class="form-check form-check-inline align-self-center">
 			<input class="form-check-input" type="radio" name="year" value="2">
  			<label class="form-check-label" for="inlineCheckbox2">2학년</label>
		</div>
		<div class="form-check form-check-inline align-self-center">
 			<input class="form-check-input" type="radio" name="year" value="3">
			<label class="form-check-label" for="inlineCheckbox3">3학년</label>
		</div>
		<div class="form-check form-check-inline align-self-center">
 			<input class="form-check-input" type="radio" name="year" value="4">
			<label class="form-check-label" for="inlineCheckbox3">4학년</label>
		</div>
	</div>
	<div class="input-group mb-3">
		<span class="input-group-text">지도교수</span>
		<select class="form-select" name="advisor">
			<c:forEach items="${parray}" var="vo">
				<option value="${vo.pcode}">${vo.pname} : ${vo.dept}</option>
			</c:forEach>
		</select>
	</div>
	<div>
		<input type="submit" value="학생등록" class="btn btn-primary">
		<input type="reset" value="등록취소" class="btn btn-secondary">
	</div>
</form>


<script>
	$(frm_insert).on("submit", function(e){
		e.preventDefault();
		const sname=$(frm_insert.sname).val();
		if(sname==""){
			alert("학생이름을 입력해주세요.")
			$(frm_insert.sname).focus();
		}else {			
			if(confirm("학생정보를 등록하시겠습니까?")){
				frm_insert.submit();
			}
		}
	});
	
	$(frm_insert).on("reset", function(){
		$("#modal_insert").modal("hide")
	})
</script>