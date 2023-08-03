<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="col">
		<h1 class="mb-3">학생정보수정</h1>
		<form name="frm_update" method="post" action="/stu/update">
			<div class="input-group mb-3">
				<span class="input-group-text">학생번호</span>
				<input name="scode" class="form-control" value="${svo.scode}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">학생이름</span>
				<input name="sname" class="form-control" value="${svo.sname}">
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">학생학과</span>
				<select name="dept" class="form-select">
					<option value="컴정" <c:out value="${svo.dept=='컴정'?'selected':''}"/>>컴퓨터정보공학</option>
					<option value="전자" <c:out value="${svo.dept=='전자'?'selected':''}"/>>전자공학</option>
					<option value="생명" <c:out value="${svo.dept=='생명'?'selected':''}"/>>생명공학</option>
					<option value="전산" <c:out value="${svo.dept=='전산'?'selected':''}"/>>전산공학</option>	
					<option value="화학" <c:out value="${svo.dept=='화학'?'selected':''}"/>>화학공학</option>	
					<option value="건축" <c:out value="${svo.dept=='건축'?'selected':''}"/>>건축공학</option>	
				</select>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">생년월일</span>
				<input name="birthday" type="date" class="form-control" value="${svo.birthday}">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-text px-2 me-2">학년</div>
				<div class="form-check form-check-inline align-self-center">
		  			<input class="form-check-input" type="radio" name="year" value="1" 
						<c:out value="${svo.year==1?'checked':''}"/>>
		  			<label class="form-check-label" for="inlineCheckbox1">1학년</label>
				</div>
				<div class="form-check form-check-inline align-self-center">
		 			<input class="form-check-input" type="radio" name="year" value="2"
		 				<c:out value="${svo.year==2?'checked':''}"/>>
		  			<label class="form-check-label" for="inlineCheckbox2">2학년</label>
				</div>
				<div class="form-check form-check-inline align-self-center">
		 			<input class="form-check-input" type="radio" name="year" value="3"
		 				<c:out value="${svo.year==3?'checked':''}"/>>
					<label class="form-check-label" for="inlineCheckbox3">3학년</label>
				</div>
				<div class="form-check form-check-inline align-self-center">
		 			<input class="form-check-input" type="radio" name="year" value="4"
		 				<c:out value="${svo.year==4?'checked':''}"/>>
					<label class="form-check-label" for="inlineCheckbox3">4학년</label>
				</div>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">지도교수</span>
				<select class="form-select" name="advisor">
					<c:forEach items="${parray}" var="pvo">
						<option value="${pvo.pcode}" ${svo.advisor==pvo.pcode?'selected':''}> 
						${pvo.pname} : ${pvo.dept}
						</option>
					</c:forEach>
				</select>
			</div>
			<div>
				<input type="submit" value="학생등록" class="btn btn-primary">
				<input type="reset" value="등록취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>


<script>
	$(frm_update).on("submit", function(e){
		e.preventDefault();
		if(confirm("학생정보를 수정하실레요?")){
			frm_update.submit();
		}else {
			alert("수정을 취소합니다.")
		}
	});

</script>