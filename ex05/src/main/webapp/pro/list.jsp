<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="insert.jsp"></jsp:include>

<div class="row my-3">
	<div class="col">
		<h1 class="mb-2">상품목록</h1>
		<div class="row justify-content-end" >
			<div class="col-1 col-md-6 col-xl-8">
				<span id="total" class="p-3 align-bottom">20건</span>				
			</div>
			<form name="frm_list" class="col-11 col-md-6 col-xl-4">
				<div class="input-group mb-3">
					<input name="query" class="form-control" placeholder="검색어">
					<button class="btn btn-success">검색</button>
				</div>
			</form>
		</div>
		<div id="div_list"></div>
		<div id="btn_group" class="text-center">
			<button id="prev" class="btn btn-secondary">이전</button>
			<span id="now_page">1</span>
			<button id="next" class="btn btn-secondary">다음</button>
		</div>
	</div>
</div>

<!-- 템플릿 -->
<script id="temp_list" type="text/x-handelbars-template">
	<table class="table">
		<tr class="table-dark">
			<td>상품코드</td>
			<td>상품이름</td>
			<td>상품가격</td>
			<td>상품등록일</td>
			<td>삭제</td>
			<td>수정</td>
		</tr>
		{{#each items}}
		<tr>
			<td class="code">{{pcode}}</td>
			<td><input class="name" value="{{pname}}"></td>
			<td><input class="price" value="{{pprice}}"><span class="fprice">{{fpprice}}</span></td>
			<td>{{fpdate}}</td>
			<td><button class="btn btn-danger btn-sm" dcode="{{pcode}}">삭제</button></td>
			<td><button class="btn btn-warning btn-sm" ucode="{{pcode}}">수정</button></td>
		</tr>
		{{/each}}
	</table>
</script>



<script>
	$("#div_list").on("click",".btn-danger", function(){
		let dcode=$(this).attr("dcode");
		if(confirm(dcode + "번 상품을 삭제하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode:dcode},
				success:function(){
					alert("삭제가 완료되었습니다.")
					getList();
				}
			})
		}else {
			alert("삭제가 취소되었습니다.")
		}
	})
	
	$("#div_list").on("click",".btn-warning", function(){
		let urow =$(this).parent().parent();
		let ucode=urow.find(".code").text();
		let uname=urow.find(".name").val();
		let uprice=urow.find(".price").val();
		if(confirm("상품코드:" + ucode + " 상품이름:" +uname + " 상품가격:" +uprice + "수정하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/update",
				data:{pcode:ucode, pname:uname, pprice:uprice},
				success:function(){
					alert("수정이 완료되었습니다.");
					getList();
				}
			})
		}else{
			alert("수정이 취소되었습니다.");
			getList();
		}
	})
	
	$("#div_list").on("keydown",".price", function(){
		const price=$(this).val();
		const td=$(this).parent();
		if(price.replace(/^[0-9]/g, '')){
			td.find(".fprice").html(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원")
		}else {
			td.find(".fprice").html('<span style="color: red;">숫자로입력해주세요</span>');
		}
	})
</script>

<!-- 함수 -->
<script>
	let query = "";
	let nowPage = 1;
	
	getList();
	function getList(){
		$.ajax({
			url:"/pro/list.json", //같은서버라 http://를 생략가능
			type:"get",
			data:{page : nowPage, query:query},
			dataType:"json",
			success:function(data){
				if(data.total==0) {
					$("#div_list").html('<h1 class="text-center my-5">상품이없습니다.</h1>');
					$("#btn_group").hide();
				}else {
					const com_temp_list = Handlebars.compile($("#temp_list").html());
					const html_list = com_temp_list(data);
					$("#div_list").html(html_list);
					
					$("#btn_group").show();
					
					let lastPage = Math.ceil(data.total/5);
					
					$("#now_page").html(nowPage + "/" + lastPage);
					
					if(nowPage==1) $("#prev").attr("disabled", true);
					else $("#prev").attr("disabled", false)
					
					if(nowPage==lastPage) $("#next").attr("disabled", true);
					else $("#next").attr("disabled", false)
					
					$("#total").html(data.total+"건");					
				}
			}
		});
	}
	
	$("#next").on("click",function(){
		nowPage++;
		getList();
	});
	
	$("#prev").on("click",function(){
		nowPage--;
		getList();
	});
	
	$(frm_list).on("submit", function(e){
		e.preventDefault();
		page = 1;
		query = $(frm_list.query).val();
		getList();
	})
</script>