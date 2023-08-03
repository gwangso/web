<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">강좌정보</h1>
		<form name="frm_update" method="post" action="/cou/update">
			<div class="input-group mb-3">
				<span class="input-group-text">강좌번호</span>
				<input name="lcode" class="form-control" value="${lvo.lcode}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강좌이름</span>
				<input name="lname" class="form-control" value="${lvo.lname}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">담당교수</span>
				<select name="instructor" class="form-select">
					<c:forEach items="${parray}" var="parray">
						<option value="${parray.pcode}" <c:out value="${parray.pcode==lvo.instructor?'selected':''}"/> >
							교수번호: ${parray.pcode} / 교수이름: ${parray.pname} / 교수학과: ${parray.dept}
						</option>
					</c:forEach>		
				</select>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강의실</span>
				<input name="room" class="form-control" value="${lvo.room}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강의시간</span>
				<input name="hours" class="form-control" value="${lvo.hours}" oninput="isNumber(this)">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">최대수강인원</span>
				<input name="capacity" class="form-control" value="${lvo.capacity}" oninput="isNumber(this)">
			</div>
			<div class="input-group mb-5">
				<span class="input-group-text">수강인원</span>
				<input name="persons" class="form-control" value="${lvo.persons}" oninput="isNumber(this)">
			</div>
			<div class="text-center">
				<input type="submit" value="강좌등록" class="btn btn-primary">
				<input type="reset" value="등록취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>

<script>

	function isNumber(item){
		item.value=item.value.replace(/[^0-9]/g,'');
	}

	$(frm_update).on("submit", function(e){
		e.preventDefault();
		if(confirm("수정하시겠습니까?")){
			frm_update.submit();
		}
	});
	
	$(frm_update).on("reset", function(){
		location.href="/cou/list";
	});
	
</script>