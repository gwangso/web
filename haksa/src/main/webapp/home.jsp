<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학사관리</title>
	
	<!-- j쿼리 -->
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    
	<!-- 핸들바 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	
	<!-- 부트스트랩 -->
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/style.css"/>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e567e3f58b6abf032ee2c12db3a9cd1d"></script>
	
	<!-- 페이지네이션 사용 라이브러리 -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>
	
	<!-- 부트스트랩 아이콘 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>

<body>
	<div class="container">
		<div class="row my-5">
			<div class="col">
				<!-- header -->
				<jsp:include page="header.jsp"></jsp:include>
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