<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">수강신청</h1>
		<div class="card p-3 mb-3">
			<div class="row">
				<div class="col-6 col-xxl-2 col-md-4">학생번호 : ${svo.scode}</div>
				<div class="col-6 col-xxl-2 col-md-4">학생이름 : ${svo.sname}</div>
				<div class="col-6 col-xxl-2 col-md-4">학년 : ${svo.year}</div>			
				<div class="col-6 col-xxl-2 col-md-4">학과 : ${svo.dept}</div>
				<div class="col-6 col-xxl-2 col-md-4">생년월일 : ${svo.birthday}</div>
				<div class="col-6 col-xxl-2 col-md-4">지도교수 : ${svo.pname}(${svo.advisor})</div>
			</div>
		</div>
		<div class="card p-3 mb-5">
			<div class="row">
				<div class="col" id="div_cou">
				</div>
				<div class="col-4 col-sm-3 coL-md-1">
					<button class="btn btn-primary" id="btn_enroll">수강신청</button>
				</div>
			</div>
		</div>
		<div id="div_enroll"></div>
	</div>
</div>

<script id="temp_cou" type="text/x-handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
		<option value="{{lcode}}" {{dis persons capacity}}>
			{{lcode}}:{{lname}}  |  교수:{{pname}}  |  수강인원/총원 : {{persons}}/{{capacity}}
		</option>
		{{/each}}
	</select>
</script>

<script>
	Handlebars.registerHelper("dis", function(persons, capacity){
		if(persons>=capacity) return "disabled";
	});
</script>


<script id="temp_enroll" type= "text/x-handlebars-template">
	<table class="table">
		<tr class="table-warning">
			<th>강좌번호</th>
			<th>강좌이름</th>
			<th>교수</th>
			<th>성적</th>
			<th>강의실</th>
			<th>강의시간</th>
			<th>수강인원/총원</th>
			<th>수강신청일</th>
			<th>수강취소</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td>{{pname}}</td>
			<td>{{grade}}</td>
			<td>{{room}}</td>
			<td>{{hours}}</td>
			<td>{{persons}}/{{capacity}}</td>
			<td>{{edate}}</td>
			<td><button class="btn btn-danger btn-sm" lcode={{lcode}} lname={{lname}}>취소</button></td>
		</tr>
		{{/each}}
	</table>	
</script>

<script>
	const scode="${svo.scode}";
	getEnrollList();
	function getEnrollList(){
		$.ajax({
			type:"get",
			url:"/stu/enroll.json",
			data:{scode:scode},
			dataType : "json",
			success:function(data){
				const com_temp_enroll = Handlebars.compile($("#temp_enroll").html());
				const html_temp_enroll = com_temp_enroll(data);
				$("#div_enroll").html(html_temp_enroll);
				getCouList()
			}
		});
	}

	$("#btn_enroll").on("click", function(){
		const lcode= $("#lcode").val();
		if(confirm(lcode + "강좌를 수강신청하실레요?")){
			$.ajax({
				type:"get",
				url:"/enroll/insert",
				data:{scode:scode, lcode:lcode},
				success:function(data){
					if(data==0){
						alert("수강신청이 완료되었습니다.");
						getEnrollList();
					}else{
						alert("이미 신청한 과목입니다.");
					}
				}
			});
		}
	});
	
	function getCouList(){
		$.ajax({
			type:"get",
			url:"/cou/all.json",
			dataType:"json",
			success:function(data){
				console.log(data);
				const com_temp_cou = Handlebars.compile($("#temp_cou").html());
				const html_temp_cou = com_temp_cou(data);
				$("#div_cou").html(html_temp_cou);
			}
		});
	}
	
	$("#div_enroll").on("click", ".btn-danger", function(){
		const lcode = $(this).attr("lcode");
		const lname = $(this).attr("lname");
		if(confirm(lcode + ":" + lname +"강좌를 수강취소하실레요?")){
			$.ajax({
				type:"post",
				url:"/enroll/delete",
				data:{scode:scode, lcode:lcode},
				success:function(){
					alert("수강신청이 취소되었습니다.")
					getEnrollList();
				}
			});
		}
	});
</script>