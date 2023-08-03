<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form name="frm_pro_insert">
	<div class="input-group mb-2">
		<span class="input-group-text">교수이름</span>
		<input name="pname" class="form-control">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수학과</span>
		<select name="dept" class="form-select">
			<option value="컴정">컴퓨터정보공학</option>
			<option value="전자">전자공학</option>
			<option value="생명" selected>생명공학</option>
			<option value="전산">전산공학</option>	
			<option value="화학">화학공학</option>	
			<option value="건축">건축공학</option>	
		</select>
	</div>
	<div class="input-group-text mb-2">
		<span class="pe-3">교수직급</span>
		<div class="form-check form-check-inline">
			<input name="title" type="radio" value="정교수" class="form-check-input">
			<label class="from-check-label">정교수</label>
		</div>
		<div class="form-check form-check-inline">
			<input name="title" type="radio" value="부교수" class="form-check-input" checked>
			<label class="from-check-label">부교수</label>
		</div>
		<div class="form-check form-check-inline">
			<input name="title" type="radio" value="조교수" class="form-check-input">
			<label class="from-check-label">조교수</label>
		</div>
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">교수급여</span>
		<input name="salary" class="form-control" value="0">
	</div>
	<div class="input-group mb-2">
		<span class="input-group-text">임용일</span>
		<input name="hiredate" class="form-control" type="date">
	</div>
	<div class="text-center mb-2">
		<input type="submit" class="btn btn-primary" value="교수등록">
		<input type="reset" class="btn btn-secondary" value="등록취소">
	</div>
</form>


<script>
	$(frm_pro_insert).on("submit",function(e){
		e.preventDefault();
		const pname=$(frm_pro_insert.pname).val();
		const dept = $(frm_pro_insert.dept).val();
		const salary=$(frm_pro_insert.salary).val();		
		const title = $('input:radio[name="title"]:checked').val();
		const hiredate = $(frm_pro_insert.hiredate).val();
		if(pname==""){
			alert("교수이름을 입력하세요.")
			$(frm_pro_insert.pname).focus();
		}else if(salary.replace(/[0-9]/g, '')){
			alert("급여를 숫자로 입력해주세요");
			$(frm_pro_insert.salary).val("");
			$(frm_pro_insert.salary).focus();
		}else{
			if(confirm("새로운교수를 등록하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"/pro/insert",
					data:{"pname":pname,
						dept:dept,
						hiredate:hiredate,
						salary:salary,
						title:title
						},
					success:function(){
						alert("등록이 완료되었습니다.")
						$("#insert").modal(hide);
						getProTotal();
					}
				});
			}else{
				alert("등록을 취소했습니다.")
				$(frm_pro_insert.pname).val("");
				$(frm_pro_insert.dept).val("생명");
				$(frm_pro_insert.salary).val("0");
				$('input:radio[name="title"][value="부교수"]').prop("checked", true);
				$(frm_pro_insert.hiredate).val("");
			}			
		} 
	});
	
	$(frm_pro_insert).on("reset", function(){
		$("#insert").modal("hide")
	})
</script>