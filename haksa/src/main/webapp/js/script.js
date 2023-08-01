/**
 * 
 */

 	let query="";
	let key=$(frm.key).val();
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/"+url+"/total",
			data:{query:query, key:key},
			success:function(data){
				if(data==0){
					$(`#pagination`).hide();
					$("#div_"+url+"_list").html(`<h3 class="text-center my-5"><b>검색결과없음</b><h3>`);
					$(frm.query).val("");
				}else {
					$("#pagination").show();
					const totalPages = Math.ceil(data/5);
					$(`#pagination`).twbsPagination("changeTotalPages", totalPages, 1)
				}
			}
		})
	}
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/"+url+"/list.json",
			data:{query:query, page:page, key:key},
			dataType:"json",
			success:function(data){
				const com_temp_list = Handlebars.compile($("#temp_"+url+"_list").html());
				const html_list = com_temp_list(data);
				$(`#div_${url}_list`).html(html_list);
			}
		});
	}
	
	$("#pagination").twbsPagination({
		totalPages:5,	// 총 페이지 번호 수
		visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-caret-left-square-fill"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : `<i class="bi bi-caret-left"></i>`,	// 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-caret-right-square-fill"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function (event, page) {
			getList(page);
		}
	});

	$(frm).on("submit",function(e){
		e.preventDefault();
		query=$(frm.query).val();
		key=$(frm.key).val();
		getTotal();
	});
	