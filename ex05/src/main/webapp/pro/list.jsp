<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row my-3">
	<div class="col">
		<h1 class="mb-5">상품목록</h1>
		<div id="div_list"></div>
		<div class="text-center">
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
		</tr>
		{{#each items}}
		<tr>
			<td>{{pcode}}</td>
			<td>{{pname}}</td>
			<td>{{fpprice}}</td>
			<td>{{fpdate}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<!-- 핸들바함수 -->
<script>
	Handlebars.registerHelper("fmtPrice", function(){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
</script>

<!-- 함수 -->
<script>
	let nowPage = 1;
	
	$("#next").on("click",function(){
		nowPage++;
		getList();
	});
	
	$("#prev").on("click",function(){
		nowPage--;
		getList();
	});
	
	getList();
	function getList(){
		$.ajax({
			url:"/pro/list.json", //같은서버라 http://를 생략가능
			type:"get",
			data:{page : nowPage},
			dataType:"json",
			success:function(data){
				console.log(data);
				const com_temp_list = Handlebars.compile($("#temp_list").html());
				const html_list = com_temp_list(data);
				$("#div_list").html(html_list);
				
				let lastPage = Math.ceil(data.total/5);
				
				$("#now_page").html(nowPage + "/" + lastPage);
				
				if(nowPage==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false)
				
				if(nowPage==lastPage) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false)
			}
		});
	}
</script>