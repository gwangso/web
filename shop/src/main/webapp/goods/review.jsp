<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="row my-5">
	<div class="col">
		<h2 class="text-center mb-5">고객리뷰</h2>
		<c:if test="${user==null}">
			<div class="text-center my-5">
				<button class="btn btn-primary w-50" id="btn_review">리뷰작성</button>
			</div>
		</c:if>
		<c:if test="${user!=null}">
			<form name="frm">
				<textarea name="content" class="form-control mb-3" rows="5"></textarea>
				<div class="text-end">
					<button class="btn btn-primary">리뷰작성</button>
				</div>
			</form>
		</c:if>
		<div id="div_review"></div>
	</div>
</div>
<script id="temp_review" type="text/x-handlebars-template">
	{{#each .}}
		<div class="row">
			<div class="col-md-1">
				<img src="{{photo}}" width="50px">
				<div class="text-center">{{uid}}</div>
			</div>
			<div class="col">
				<div>{{revDate}}</div>
				<div>{{content}}</div>
			</div>
		</div>
		<hr>
	{{/each}}
</script>

<script>
	const gid ="${vo.gid}";
	const uid ="${user.uid}";
	
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			data:{gid:gid},
			dataType:"json",
			success:function(data){
				console.log(data);
				const temp= Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
			}
		});
	}
	
	$("#btn_review").on("click", function(){
		location.href="/user/login?target=/goods/read?gid="+gid;
	})
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const content = $(frm.content).val();
		if(content == ""){
			alert("리뷰 내용을 입력하세요!");
			$(frm.content).focus();
		}else {
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{gid, uid, content},
				success:function(){
					alert("리뷰가 저장되었습니다.");
					$(frm.content).val("");
					getList();
				}
			});
		}
	});
</script>