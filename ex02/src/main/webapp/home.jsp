<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>상품관리프로그램</title>
	
	<!-- j쿼리 -->
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	
	<!-- 부트스트랩 -->
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/style.css"/>
	
</head>
<body>
	<div class="container">
		<div class="row m-5">
			<div class="col">
				<!-- header -->
				<jsp:include page="header.jsp"></jsp:include>
				<hr>
				<!-- contents -->
				<jsp:include page="${pageName}"/>
				<hr>
				<!-- footer -->
				<jsp:include page="footer.jsp"/>
			</div>
		</div>	
	</div>
</body>
</html>