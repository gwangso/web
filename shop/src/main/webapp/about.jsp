<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.title , .price{
		font-size:12;
	}
</style>

<div class="row my-3">
	<div class="col">
		<h1 id="about_title">**쇼핑몰</h1>
		<div class="row mb-3">
			<form name="frm" class="col-10 col-sm-6 col-xl-4">
				<div class="input-group">
					<input name=query class="form-control" value="">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_goods" class="row"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<!-- 상품목록 템플릿 -->
<script id="temp_goods" type="text/x-handlebars-template">
	{{#each .}}
		<div class="col-6 col-md-4 col-xl-2 mb-3">
			<div class="card p-3">
				<div class="card-body">
					<img src="{{image}}" gid="{{gid}}" width=100% style="cursor: pointer;">
					<div class="ellipsis title">{{title}}</div>
					<div class="price">{{fmtPrice price}}</div>
				</div>
				<div class="card-footer">
					<i class="bi {{heart ucnt}}" style="color:red;"></i>
					<span style="font-size:0.8rem;">{{fcnt}}</span> &nbsp;&nbsp;
					<i class="bi bi-chat-left-text"></i>
					<span style="font-size:0.8rem;">{{rcnt}}</span>
				</div>
			</div>
		</div>
	{{/each}}
</script>

<script>
	Handlebars.registerHelper("fmtPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});
	
	Handlebars.registerHelper("heart", function(ucnt){
		if(ucnt==0) return "bi-suit-heart";
		else return "bi-suit-heart-fill";
	});
</script>

<script>
	let page=1;
	let query="";
	const uid="${user.uid}";
	
	getTotal();
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page:page, query:query, uid:uid},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_goods").html());
				$("#div_goods").html(temp(data));
				
			}
		});
	}
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
				if(data==0){
					query="";
					$("#div_goods").html(`<h3 class="text-center my-5"><b>검색상품 없음</b></h3>`);
				}else {
					const totalPages=Math.ceil(data/6);
					$("#pagination").twbsPagination("changeTotalPages", totalPages,1);					
				}
			}
		});
	}
	
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	page=curPage;
	    	getList();
	    }
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		if(query==""){
			alert("검색어를 입려하세요!");
			$(frm.query).focus();
		}else {
			page=1;
			getTotal();
		}
	});
	
	$("#div_goods").on("click", "img", function(){
		const gid = $(this).attr("gid");
		location.href="/goods/read?gid="+gid;
	})
	
	
</script>