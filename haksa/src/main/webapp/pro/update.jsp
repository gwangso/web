<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="row">
		<h1>교수정보수정</h1>
		<form name="frm_update" method="post" action="/pro/update">
			<div class="input-group mb-2">
				<span class="input-group-text">교수번호</span>
				<input name="pcode" class="form-control" value="${up.pcode}" >
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수이름</span>
				<input name="pname" class="form-control" value="${up.pname}">
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수학과</span>
				<select name="dept" class="form-select">
					<option value="컴정" <c:out value="${up.dept=='컴정' ? 'selected':''}"/>>컴퓨터정보공학</option>
					<option value="전자" <c:out value="${up.dept=='전자' ? 'selected':''}"/>>전자공학</option>
					<option value="생명" <c:out value="${up.dept=='생명' ? 'selected':''}"/>>생명공학</option>
					<option value="전산" <c:out value="${up.dept=='전산' ? 'selected':''}"/>>전산공학</option>	
					<option value="화학" <c:out value="${up.dept=='화학' ? 'selected':''}"/>>화학공학</option>	
					<option value="건축" <c:out value="${up.dept=='건축' ? 'selected':''}"/>>건축공학</option>	
				</select>
			</div>
			<div class="input-group-text mb-2">
				<span class="pe-3">교수직급</span>
				<div class="form-check form-check-inline">
					<input name="title" type="radio" value="정교수" class="form-check-input" <c:out value="${up.title=='정교수' ? 'checked':''}"/>>
					<label class="from-check-label">정교수</label>
				</div>
				<div class="form-check form-check-inline">
					<input name="title" type="radio" value="부교수" class="form-check-input" <c:out value="${up.title=='부교수' ? 'checked':''}"/>>
					<label class="from-check-label">부교수</label>
				</div>
				<div class="form-check form-check-inline">
					<input name="title" type="radio" value="조교수" class="form-check-input" <c:out value="${up.title=='조교수' ? 'checked':''}"/>>
					<label class="from-check-label">조교수</label>
				</div>
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수급여</span>
				<input name="salary" class="form-control" value="${up.salary}">
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">임용일</span>
				<input name="hiredate" class="form-control" type="date" value="${up.hiredate}">
			</div>
			<div class="text-center mb-2">
				<input type="submit" class="btn btn-primary" value="정보수정">
				<button type="reset" class="btn btn-secondary">수정취소</button>
			</div>
		</form>
	</div>
</div>

<script>
	$(frm_update).on("submit", function(e){
		e.preventDefault();
		if(confirm("교수 정보를 수정하시겠습니까?")){
			frm_update.submit();
		}
	});
	
	$(frm_update).on("reset",function(){
		location.href = "/pro/list";
	})
</script>