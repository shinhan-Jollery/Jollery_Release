<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/booking/css/style.css' />" />

<body>
	<!-- header -->
	<header class="header header-sticky"  style= "background-color:#5f5454e8;">
		<div class="container">
			<div class="row">
				<nav class="navbar navbar-expand-lg navbar-dark">
					<a href="${path}/main" class="navbar-brand order-1 order-lg-2" style="font-size: 1.9rem; font-weight: bold;">JOLLERY</a>
					<button class="navbar-toggler order-2" type="button"
						data-toggle="collapse" data-target=".navbar-collapse"
						aria-controls="navbarMenu" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>

					<div class="collapse navbar-collapse order-3 order-lg-1"
						id="navbarMenu">
						<ul class="navbar-nav mr-auto">
							<li class="nav-item dropdown megamenu"><a
								class="nav-link dropdown-bs-toggle" href="#!" id="navbarDropdown-4"
								role="button" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">CATEGORIES</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown-4">
									<div class="row">
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">회화</span></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=101">동양화</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=102">서양화</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=103">판화</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=104">혼합(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">조소</span></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=201">석재</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=202">목재</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=203">금속</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=204">3D프린팅</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=205">혼합재료(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">공예</span></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=301">도예</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=302">유리공예</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=303">금속공예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=304">목공예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=305">혼합재료(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">기타</span></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=401">사진</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=402">설치미술</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=403">서예</a></li>
											<li><a class="dropdown-item" href="${path}/artSearch/list?minicategoryId=404">실험예술(기타)</a></li>
										</ul>
									</div>
								</div></li>
							<!-- 검색창 추가 -->
							<form class="search-bar" action="${path}/artSearch/search" method="GET" style="margin-left:42px; height:33px;">
							    <div class="search-container">
							        <i class="icon-search"></i>
							        <input type="text" name="query" placeholder="제목,&nbsp작가이름 검색" />
							    </div>

							</form>
						</ul>
					</div>

					<div class="collapse navbar-collapse order-4 order-lg-3"
						id="navbarMenu2">
						<ul class="navbar-nav ml-auto">
							<li class="nav-item"><a class="nav-link" href=<c:url value='/auth/login' />>로그인</a></li>
							<li class="nav-item"><a class="nav-link" href="${path}/auth/login"><i class="icon-heart"></i></a></li>
							<li class="nav-item cart"><a data-toggle="modal"
								data-target="#cart" class="nav-link" href="${path}/auth/login"><span>Cart</span><span>0</span></a>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</header>
	<script>
	//price필터
    function formatPrice(price) {
        return price.toLocaleString(); // 1000단위 쉼표 추가
    }

    // 페이지 로드 후 실행
    document.addEventListener('DOMContentLoaded', function () {
        // 'artPrice' 클래스를 가진 모든 요소를 선택
        var priceElements = document.querySelectorAll('#artPrice');

        priceElements.forEach(function (priceElement) {
            var price = parseInt(priceElement.textContent.replace('원', '').trim()); // '₩' 문자 제거
            priceElement.textContent = formatPrice(price) + ' 원'; // 쉼표 추가 후 '₩' 붙이기
        });
    });
    </script>
</body>
</html>