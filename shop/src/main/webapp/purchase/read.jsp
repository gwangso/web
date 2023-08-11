<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row my-5">
	<div class="col">
		<h1 class="ms-5 mb-3">구매정보</h1>
		
		<!-- 고객정보 -->
		<div class="card p-3 mb-4">
			<h4 class="my-3 ms-3">주문번호 : ${vo.pid}</h4>
			<div class="row my-3">
				<div class="col-6 col-lg-4 mb-3">주문자 : ${vo.uname} (${vo.uid})</div>
				<div class="col-6 col-lg-4">전화번호 : ${vo.phone}</div>
				<div class="col-lg-4 ">주문날짜 : ${vo.purDate}</div>
			</div>
			<div class="row mb-3">
				<div class="col">주소 : ${vo.address1} ${vo.address2})</div>
			</div>
			<div class="row mb-3">
				<div class="col">주문총액 : <fmt:formatNumber value="${vo.purSum}" pattern="#,###원"/> </div>
				<div class="col-6 col-lg-3"> 주문상태:
					<b> <!-- c:out은 화면에 출력하는 역할 -->
						<c:out value="${vo.status==0 ? '결제대기중':''}"/>
						<c:out value="${vo.status==1 ? '결제완료':''}"/>
						<c:out value="${vo.status==2 ? '상품준비중':''}" />
						<c:out value="${vo.status==3 ? '배송준비중':''}"/>
						<c:out value="${vo.status==4 ? '배송중':''}"/>
						<c:out value="${vo.status==5 ? '배송완료':''}"/>
						<c:out value="${vo.status==6 ? '구매확정':''}"/>
					</b>
				</div>
			</div>
		</div>
		
		<!-- 구매정보 -->
		<table class="table">
			<tr class="table-dark">
				<th>상품코드</th>
				<th>상품이미지</th>
				<th>상품이름</th>
				<th>상품가격</th>
				<th>상품개수</th>
				<th>구매가격</th>
			</tr>
			<c:forEach items="${array}" var="gvo">			
			<tr>
				<td><a href="/goods/read?gid=${gvo.gid}">${gvo.gid}</a></td>
				<td><img src="${gvo.image}" width="50px"></td>
				<td>${gvo.title}</td>
				<td><fmt:formatNumber value="${gvo.price}" pattern="#,###원"/></td>
				<td>${gvo.qnt}</td>
				<td><fmt:formatNumber value="${gvo.qnt * gvo.price}" pattern="#,###원"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>