<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row">
	<div class="col">
		<h1>저장도서목록</h1>
		<div id="div_list"></div>
		<div class="text-center">
			<button id="prev" class="btn btn-secondary">이전</button>
			<span id="now_page" class="mx-3">1/10</span>
			<button id="next" class="btn btn-secondary">다음</button>
		</div>
	</div>
</div>

<!-- handlebars -->
<script id="temp_list" type="text/x-handlebars-template">
<table class="table align-middle">
	<tr class="table table-dark">
		<td><input type="checkbox" id="all"></td>
		<td>썸네일</td>
		<td>제목</td>
		<td>출판사</td>
		<td>가격</td>	
	</tr>
	{{#each .}}
	<tr>
		<td><input type="checkbox" class="chk" book="{{toString @this}}"></td>
		<td><img src="{{printImg thumbnail}}" width="50px" index={{@index}} style="cursor: pointer;"></td>			
		<td>{{title}}</td>
		<td>{{publisher}}</td>
		<td>{{fmtPrice price}}</td>
	</tr>
	{{/each}}	
</table>
</script>

<!-- 핸들바함수 -->
<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
	
	Handlebars.registerHelper("printImg",function(image){
		if(image){
			return image;
		}else {
			return "http://via.placeholder.com/120x174";
		}
	})
	
	Handlebars.registerHelper("toString",function(book){
		return JSON.stringify(book);
	})
</script>

<script>
	let nowPage = 1;
	getList();
	function getList(){
		$.ajax({
			type:"get",
			url:"/book/list.json",
			dataType:"json",
			data: {page:nowPage},
			success:function(data){
				const com_temp_list = Handlebars.compile($("#temp_list").html());
				const html_list = com_temp_list(data);
				$("#div_list").html(html_list);
				
				let total = 0;
				
				$.ajax({
					type:"get",
					url:"/book/total",
					dataType:"json",
					async: false,
					success:function(data){
						total = data;
						return total;
					}
				})
				
				let lastPage = Math.ceil(total/5);
				$("#now_page").html(nowPage);
				
				if(nowPage==1) $("#prev").attr("disabled",true);
				else $("#prev").attr("disabled",false);
				
				if(nowPage==lastPage) $("#next").attr("disabled",true);
				else $("#next").attr("disabled",false);
			}
		})		
	}
	
	$("#next").on("click",function(){
		nowPage++;
		getList();
	})
	
	$("#prev").on("click",function(){
		nowPage--;
		getList();
	})
	
	$("#div_list").on("click","#all", function(){
		
	})
	
	
	
	
	
</script>