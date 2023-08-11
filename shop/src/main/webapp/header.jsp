<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="row">
	<div class="col">
		<div style="background: black;">
			<img src="/image/bahDnRs.png" width="100%" id="img_header">
		</div>
		<nav class="navbar navbar-expand-lg" style="background-color: #000000;">
			<div class="container-fluid" >
				<a class="navbar-brand" href="/" style="color:#FFFFFF;"><b>쇼핑몰</b></a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<c:if test="${user.role==1}">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/goods/search" style="color:#FFFFFF;">상품검색</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/goods/list" style="color:#FFFFFF;">상품목록</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/user/list" style="color:#FFFFFF;">회원목록</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/purchase/list" style="color:#FFFFFF;">구매목록</a>
						</li>
						</c:if>
					</ul>
					<ul class="navbar-nav mb-2 mb-lg-0">
						<c:if test="${user==null}">						
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/cart/list" style="color:#FFFFFF;">장바구니</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/login" style="color:#FFFFFF;">로그인</a>
							</li>
						</c:if>
						<c:if test="${user!=null}">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/read" style="color:#FFFFFF;">${user.uname}님 환영합니다.</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/cart/list" style="color:#FFFFFF;">장바구니</a>
							</li>
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="/user/logout" style="color:#FFFFFF;">로그아웃</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</nav>
	</div>
</div>