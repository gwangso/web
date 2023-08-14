<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="col">
		<h1 class="ms-5 mb-5">구매목록</h1>
		<table class="table">
			<tr class="table-dark">
				<th>주문번호</th>
				<th>주문일자</th>
				<th>주문총액</th>
			</tr>	
			<c:forEach items="${array}" var="vo">
			<tr>
				<td><a href="/purchase/read?pid=${vo.pid}">${vo.pid}</a></td>
				<td>${vo.purDate}</td>
				<td>${vo.purSum}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>