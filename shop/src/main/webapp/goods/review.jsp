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
			<div class="col-lg-1">
				<img src="{{photo}}" width="50px">
				<div class="text-center">{{uid}}</div>
			</div>
			<div class="col-lg-11">
				<div>{{revDate}}</div>
				<div class="div_display{{rid}}" rid="{{rid}}">
					<div class="ellipsis content mb-2" style="cursor: pointer;">{{content}}</div>
					<div class="text-end" style="{{show uid}}">
						<button class="btn btn-primary btn-sm btn_update">수정</button>
						<button class="btn btn-danger btn-sm btn_delete">삭제</button>
					</div>
				</div>
				<div class="div_update{{rid}}" style="display:none;" rid="{{rid}}">
					<textarea class="form-control content" rows="3">{{content}}</textarea>
					<div class="text-end">
						<button class="btn btn-primary btn-sm btn_save">저장</button>
						<button class="btn btn-secondary btn-sm btn_cancle">취소</button>
					</div>
				</div>
			</div>
		</div>
		<hr>
	{{/each}}
</script>

<script>
	Handlebars.registerHelper("show", function(writer){
		if(writer!=uid) return "display:none;"
	});
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
				const temp= Handlebars.compile($("#temp_review").html());
				$("#div_review").html(temp(data));
				$("#rcnt").html(data.length);
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
	
	//content내용을 클릭한 경우
	$("#div_review").on("click", ".content", function(){
		$(this).toggleClass("ellipsis"); //ellipsis라는 클레스를 클릭하면 껏다 켰다함
		// toggleClass는 클래스를 선택할 때 해당 클래스의 속성을(?) 껏다 켰다한다
	})
	
	//리뷰의 삭제버튼 클릭시
	$("#div_review").on("click", ".btn_delete", function(){
		const rid = $(this).parent().parent().attr("rid");
		if(confirm("리뷰를 삭제하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/review/delete",
				data:{rid},
				success:function(){
					getList();
				}
			})	
		}
	});
	
	//리뷰 수정버튼, 취소버튼을 눌렀을 때
	$("#div_review").on("click", ".btn_update, .btn_cancle", function(){
		const rid = $(this).parent().parent().attr("rid");
		$("#div_review .div_display"+rid).toggle();
		$("#div_review .div_update"+rid).toggle(); // toggle은 안보이면 보이게, 보이면 안보이게
	});
	
	//저장버튼 클릭한 경우 
	$("#div_review").on("click", ".btn_save", function(){
		const row = $(this).parent().parent();
		const rid = row.attr("rid");
		const content = row.find(".content").val();
		if(confirm("리뷰를 수정하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/review/update",
				data:{rid, content},
				success:function(){
					getList();
				}
			});
		}
	});
</script>