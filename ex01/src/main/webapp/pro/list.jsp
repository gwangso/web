<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="row my-3">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<table class="table table-warning table-striped ">
			<c:forEach items="${array}" var="vo">
			<!-- array에 있는 값을 하나씪 받아서 vo에 넣음 -->
				<tr>
					<td>${vo.pcode}</td>
					<td>${vo.pname}</td>
					<td>
						<fmt:formatNumber value="${vo.pprice}" pattern="#,###"/>원
					</td>
					<td>
						<fmt:formatDate value="${vo.pdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
				</tr>
			</c:forEach>
		</table>		
	</div>
</div>