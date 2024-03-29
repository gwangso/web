<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row">
	<div class="col">
		<h1>도서검색</h1>
		<!-- 도서검색창 -->
		<div class="row mb-3">
			<select id="target" class="form-select" style="width:100px;">
				<option value="title" selected>제목</option>
				<option value="person">저자</option>
				<option value="publisher">출판사</option>
			</select>
			<form name="frm" class="col-8 col-md-6 col-xl-4">
				<div class="input-group">
					<input name="query" class="form-control" value="깜냥">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			<select id="size" class="form-select " style="width:70px;  position: absolute; right: 2rem;">
				<option value="5" selected>5</option>
				<option value="10">10</option>
				<option value="20">20</option>
			</select>
		</div>
		<!-- 책목록 -->
		<div id="div_book"></div>
		<!-- 이전/다음페이지 -->
		<div class="text-center">
			<button id="prev" class="btn btn-secondary">이전</button>
			<span id="now_page" class="mx-3">1/10</span>
			<button id="next" class="btn btn-secondary">다음</button>
		</div>
	</div>
</div>

<!-- 도서목록 템플릿 -->
<script id="temp_book" type="text/x-handlebars-template">
<table class="table align-middle">
	<tr class="table table-dark">
		<td><input type="checkbox" id="all"></td>
		<td>썸네일</td>
		<td>제목</td>
		<td>저자</td>
		<td>출판사</td>
		<td>가격</td>
	</tr>
	{{#each documents}}
	<tr>
		<td><input type="checkbox" class="chk" book="{{toString @this}}"></td>
		<td><img src="{{printImg thumbnail}}" width="50px" index={{@index}} style="cursor: pointer;"></td>			
		<td>{{title}}</td>
		<td>{{authors}}</td>
		<td>{{publisher}}</td>
		<td>{{fmtPrice price}}</td>
	</tr>
	<!-- Modal -->
	<div class="modal fade" id="modal_image{{@index}}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"	aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="staticBackdropLabel">도서정보</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-2">
							<img src="{{printImg thumbnail}} width="100%">
						</div>
						<div class="col">
							<h5>제목: <a href="{{url}}">{{title}}</a></h5>
							<h5>저자: {{authors}}</h5>
							<h5>출판사: {{publisher}}</h5>
							<h5>가격: <del>{{fmtPrice price}}</del> -> {{fmtPrice sale_price}}</h5>
							<h5>판매상태: {{status}}</h5>		
						</div>
					</div>
					<hr>
					<div>
						<p>{{contents}}</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	{{/each}}	
</table>
<button id="btn_save" class="btn btn-primary btn-sm">저장</button>
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


<!-- 함수 -->
<script>
	let nowPage = 1;
	let siz = $("#size").val();
	let query = $(frm.query).val();
	let target = $("#target").val();
	
	getList();
	//ajax 책리스트 가져오기
	function getList(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v3/search/book",
			headers:{"Authorization" : "KakaoAK 19f87e364dd00588802f6312b3bffecb"},
			data:{query:query, page:nowPage, target:target, size:siz},
			dataType:"json",
			success:function(data){
				console.log(data);
				const com_temp_book = Handlebars.compile($("#temp_book").html());
				const html_book = com_temp_book(data);
				$("#div_book").html(html_book);
				
				let lastPage = Math.ceil(data.meta.pageable_count/siz);
				$("#now_page").html(nowPage + "/" + lastPage);
				
				if(nowPage==1) $("#prev").attr("disabled",true);
				else $("#prev").attr("disabled",false);
				
				if(data.meta.is_end) $("#next").attr("disabled",true);
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
	
	//검색
	$(frm).on("submit",function(e){
		e.preventDefault();
		target = $("#target").val();
		siz = $("#size").val();
		query = $(frm.query).val();
		nowPage=1;
		getList();
	})
	
	//각행의 이미지를 클릭
	$("#div_book").on("click", "img", function(){
		const index=$(this).attr("index");
		$("#modal_image"+index).modal("show");
	})
	
	//전체 체크박스를 클릭한경우
	$("#div_book").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_book .chk").prop("checked", true);
		}else {
			$("#div_book .chk").prop("checked", false);
		}
	});
	
	//체크박스가 전부 선택될 경우
	$("#div_book").on("click", ".chk", function(){
		const all = $("#div_book .chk").length;
		const chk = $("#div_book .chk:checked").length;
		if(all==chk){
			$("#div_book #all").prop("checked", true);
		}else {
			$("#div_book #all").prop("checked", false);
		}
	});
	
	//저장버튼 클릭
	$("#div_book").on("click", "#btn_save", function(){
		const chk=$("#div_book .chk:checked").length;
		if(chk==0) {
			alert("저장할 항목을 선택하세요!");
		}else {
			if(confirm("선택할 항목을 저장하실레요?")){
				$("#div_book .chk:checked").each(function(){
					const book = JSON.parse($(this).attr("book"));
					$.ajax({
						type:"post",
						url:"/book/insert",
						data:book,
						success:function(){}
					});
				});
				alert("저장되었습니다.")
			}else {
				alert("저장이 취소되었습니다.")
			}
		}
	});
</script>