<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
	<div class="col">
		<h1>상품목록</h1>
		<table class="table table-warning">
			<c:forEach items="${array}" var="vo">
				<tr >
					<td>${vo.pcode}</td>
					<td><a href="/pro/read?pcode=${vo.pcode}">${vo.pname}</a></td>
					<td><fmt:formatNumber value="${vo.pprice}" pattern="#,###"/></td>
					<td><fmt:formatDate value="${vo.pdate}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
		</table>
		<div class="text-center">
			<button id="prev" class="btn btn-primary">이전</button>
			<span id="nowpage" class="mx-2">1</span>
			<button id="next" class="btn btn-primary">다음</button>
		</div>
	</div>
</div>

<script>
	let page="${page}";
	let lastPage="${lastPage}";
	$("#nowpage").html(page + "/" + lastPage);
	
	
	if(page==1) $("#prev").attr("disabled",true);
	else $("prev").attr("disabled",false);

	if(page==lastPage) $("#next").attr("disabled",true);
	else $("next").attr("disabled",false);
	
	$("#prev").on("click", function(){
		page--;
		location.href="/pro/list?page="+page;
	})
	$("#next").on("click", function(){
		page++;
		location.href="/pro/list?page="+page;
	})
	
</script>