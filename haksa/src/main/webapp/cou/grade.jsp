<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">점수입력</h1>
		<div class="card p-3 mb-3">
			<div class="row">
				<div class="col-6 col-xxl-2 col-md-4">강좌번호: ${cvo.lcode}</div>
				<div class="col-6 col-xxl-2 col-md-4">강좌이름: ${cvo.lname}</div>
				<div class="col-6 col-xxl-2 col-md-4">담당교수: ${cvo.pname}</div>
				<div class="col-6 col-xxl-2 col-md-4">강좌시간: ${cvo.hours}</div>
				<div class="col-6 col-xxl-2 col-md-4">강의실: ${cvo.room}</div>
				<div class="col-6 col-xxl-2 col-md-4">수강인원/최대수강인원: ${cvo.persons}/${cvo.capacity}</div>
			</div>
		</div>
		<div id="div_grade"></div>
	</div>
</div>

<script id="temp_grade" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-warning">
			<th>학생번호</th>
			<th>학생이름</th>
			<th>학과</th>
			<th>수업등록일</th>
			<th>성적</th>
		</tr>
		{{#each .}}
		<tr>
			<td class="scode">{{scode}}</td>
			<td class="name">{{sname}}</td>
			<td>{{dept}}</td>
			<td>{{edate}}</td>
			<td>
				<input class="grade" value="{{grade}}" oninput="isNumber(this)">
				<button class="btn btn-primary btn-sm">수정</button>
			</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	const lcode="${cvo.lcode}"
		getStuList();
	function getStuList(){
		$.ajax({
			type:"get",
			url:"/cou/grade.json",
			data:{lcode:lcode},
			dataType:"json",
			success:function(data){
				const com_temp_grade = Handlebars.compile($("#temp_grade").html());
				const html_temp_grade = com_temp_grade(data);
				$("#div_grade").html(html_temp_grade);
			}
		});
	}
	
	$("#div_grade").on("click", ".btn-primary", function(){
		const row = $(this).parent().parent();
		const scode = row.find(".scode").text();
		const sname = row.find(".sname").text();		
		const grade = row.find(".grade").val();
		if(confirm(scode+"학생의 점수를 '" + grade+"'점으로 수정하실레요?")){
			$.ajax({
				type:"post",
				url:"/grade/update",
				data:{lcode:lcode, scode:scode, grade:grade},
				success:function(){
					alert("수정 완료")
				}
			});
		}
	});
	
	//숫자인 경우에만 입력
	function isNumber(item){
	    item.value=item.value.replace(/[^0-9]/g,'');
	}
</script>