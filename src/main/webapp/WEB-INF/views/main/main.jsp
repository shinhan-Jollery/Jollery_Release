<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap"
	rel="stylesheet">

<meta charset="UTF-8">
<title>Jollery</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />

<style>
.swiper-slide .container .row .col-lg-8 {
	font-family: 'Arial', sans-serif; /* 글씨체 변경 */
	line-height: 1.6; /* 글씨 간격 늘리기 */
}

.swiper-slide .container .row .col-lg-8 h2 {
	font-family: 'Helvetica', sans-serif; /* 헤드라인 글씨체 변경 */
	font-weight: bold; /* 헤드라인 두껍게 */
	font-size: 2.5rem; /* 글씨 크기 키우기 */
	letter-spacing: 2px; /* 글자 간격 늘리기 */
	font-style: italic;
}

.swiper-slide .container .row .col-lg-8 h5 {
	font-family: 'Poppins', sans-serif;
	/*  font-family: 'Georgia', serif; /* 본문 글씨체 변경 */
	font-size: 1.25rem; /* 글씨 크기 키우기 */
	line-height: 1.8; /* 본문 글씨 간격 넓히기 */
	letter-spacing: 1px; /* 글자 간격 늘리기 */
	color: #f0f0f0; /* 글씨 색을 밝은 색으로 변경 */
}

.btn.btn-sm.btn-white {
	font-family: 'Roboto', sans-serif; /* 버튼 글씨체 변경 */
	font-weight: 600; /* 버튼 글씨 두껍게 */
	font-size: 1.2rem; /* 버튼 글씨 크기 키우기 */
	padding: 12px 20px; /* 버튼 크기 조정 */
}

.swiper-slide .container .row .col-lg-8 h2 b {
	font-size: 2.5rem; /* 기본 텍스트 크기 */
}

.swiper-slide .container .row .col-lg-8 h2 b span {
	font-size: 2rem; /* 이모티콘 크기 */
}

.owl-carousel .equal {
	height: 500px !important; /* 강제로 높이 조정 (크기 변경 가능) */
	width: auto; /* 자동 너비 조정 */
}

/* 이미지 스타일 조정 */
.owl-carousel .image {
	background-size: cover !important; /* 이미지를 컨테이너 크기에 맞게 채우기 */
	background-position: center !important; /* 이미지 중앙 정렬 */
	height: 100%; /* figure 높이에 맞추기 */
	display: block;
	border-radius: 8px; /* 둥근 모서리 효과 */
}

/* 강제 스타일 우선 적용 */
figure.equal {
	min-height: 500px !important; /* 최소 높이 설정 */
}

.owl-carousel .owl-nav button.owl-prev, .owl-carousel .owl-nav button.owl-next
	{
	background-color: #1f3269 !important; /* 버튼 배경색 변경  */
	color: white; /* 버튼 내부 아이콘/텍스트 색상 */
	border: none; /* 테두리 제거 (원하지 않을 경우) */
}

.owl-carousel .owl-nav button.owl-prev, .owl-carousel .owl-nav button.owl-next
	{
	background-color: #1f3269 !important; /* 버튼 배경색 변경*/
	color: white; /* 버튼 내부 아이콘/텍스트 색상 */
	border: none; /* 테두리 제거 (원하지 않을 경우) */
}

.owl-carousel .owl-nav button.owl-prev:hover, .owl-carousel .owl-nav button.owl-next:hover
	{
	background-color: #307191 !important; /* 버튼 호버 시 배경색 변경 */
	color: #fff; /* 버튼 내부 아이콘/텍스트 호버 색상 */
}
</style>

</head>
<body>
	<!-- header -->
	<c:choose>
		<c:when test="${not empty userId}">
			<%@ include file="/WEB-INF/views/common/userheader.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="/WEB-INF/views/common/guestheader.jsp"%>
		</c:otherwise>
	</c:choose>


	<!-- hero -->
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="image image-overlay image-zoom"
					style="background-image: url(resources/assets/images/demo/background-1.jpg)"></div>
				<div class="container">
					<div class="row align-items-center vh-100">
						<div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
							<h1 class="display-1 mt-1 mb-3 font-weight-light">
								2025년 상반기 <b class="d-block">졸업 전시회</b>
							</h1>
							<br> <a href="#exhibition-info"
								class="btn btn-sm btn-white btn-action"> 더 알아보기<span
								class="icon-arrow-right"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="image image-overlay image-zoom"
					style="background-image: url(assets/images/background-2.jpg)"></div>
				<div class="container">
					<div class="row align-items-end align-items-center vh-100">
						<div class="col-lg-8 text-white" data-swiper-parallax-x="-100%">
							<h2 class="font-weight-light">
								<b>"졸업작품의 새로운 가치를 발견하다 !"</b>
							</h2>
							<br>

							<h5>
								<br>JOLLERY는 졸업작품과 갤러리의 의미를 담아, <br>대학생들의 졸업 작품이 단순한
								전시로 끝나지 않고 <br> 지속적인 예술적 가치를 인정받을 수 있도록 돕는 플랫폼입니다. <br>
								버려지거나 방치되는 졸업작품에 새 생명을 불어넣고, <br>자원 순환과 창작의 가치를 함께 만들어갑니다.
								<br> 지금 바로 JOLLERY와 함께하세요!
							</h5>

							<br> <br> <br> <a href="#featured-arts"
								class="btn btn-sm btn-white btn-action">작품 둘러보기 <span
								class="icon-arrow-right"></span></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="swiper-footer">
			<div class="container">
				<div class="row align-items-center mb-5">
					<div class="col-lg-6">
						<div class="swiper-pagination"></div>
					</div>
					<div class="col-lg-6 text-right">
						<div class="swiper-navigation">
							<div class="swiper-button-prev"></div>
							<div class="swiper-button-next"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- latest products -->
	<section>
		<div class="container">
			<div class="row gutter-1 align-items-end">
				<div id="featured-arts" class="col-md-6">
					<h2>추천 작품들</h2>
				</div>
				<div class="col-md-6 text-md-right">
					<ul class="nav nav-tabs lavalamp" id="myTab" role="tablist">
						<li class="nav-item"><a class="nav-link active" id="home-tab"
							data-toggle="tab" href="#home" role="tab" aria-controls="home"
							aria-selected="true">좋아요순</a></li>
						<li class="nav-item"><a class="nav-link" id="profile-tab"
							data-toggle="tab" href="#profile" role="tab"
							aria-controls="profile" aria-selected="false">조회수순</a></li>
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel">
							<!-- 좋아요 -->
							<div class="row gutter-2 gutter-md-3">
								<c:forEach var="art" items="${artListLike}" varStatus="status">
									<c:if test="${status.index < 3}">
										<!-- 첫 3개 작품만 출력 -->
										<div class="col-12 col-lg-4">
											<div class="product">
												<figure class="product-image">
													<a href="${path}/art/detail/${art.art_id}"><img
														src="${art.art_thumbnail_image}" alt="Image"> <img
														src="${art.art_hovering_image}" alt="Image">
													</a>
												</figure>
												<div class="product-meta">
													<h3 class="product-title">
														<a href="${pageContext.request.contextPath}/art/detail/${art.art_id}">${art.art_title}</a>
													</h3>
													<div
														class="product-info d-flex justify-content-between align-items-center">
														<div>
															<span class="artPrice" id="artPrice">${art.art_price}원</span>
															<span class="product-action"> <a class="cartAdd"
																data-member-id="${userId}" data-art-id="${art.art_id}">장바구니
																	담기</a>
															</span>
														</div>
														<!-- 하트 이모티콘 -->
														<a class="text-danger like-icon"
															data-member-id="${userId}" data-art-id="${art.art_id}">
															<i class="bi bi-heart" style="font-size: 1.4rem;"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>

							<!-- 두 번째 행: 4개 작품 -->
							<div class="row gutter-2 gutter-md-3">
								<c:forEach var="art" items="${artListLike}" varStatus="status">
									<c:if test="${status.index >= 3 && status.index < 7}">
										<!-- 4개 작품 출력 -->
										<div class="col-12 col-lg-3">
											<div class="product">
												<figure class="product-image">
													<a href="${pageContext.request.contextPath}/art/detail/${art.art_id}"> <img
														src="${art.art_thumbnail_image}" alt="Image"> <img
														src="${art.art_hovering_image}" alt="Image">
													</a>
												</figure>
												<div class="product-meta">
													<h3 class="product-title">
														<a href="${pageContext.request.contextPath}/art/detail/${art.art_id}">${art.art_title}</a>
													</h3>
													<div
														class="product-info d-flex justify-content-between align-items-center">
														<div>
															<span class="artPrice" id="artPrice">${art.art_price}원</span>
															<span class="product-action"> <a class="cartAdd"
																data-member-id="${userId}" data-art-id="${art.art_id}">장바구니
																	담기</a>
															</span>
														</div>
														<!-- 하트 이모티콘 -->
														<a class="text-danger like-icon"
															data-member-id="${userId}" data-art-id="${art.art_id}">
															<i class="bi bi-heart" style="font-size: 1.5rem;"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
						<!-- End Second Row -->
						<div class="tab-pane fade" id="profile" role="tabpanel">
							<!-- 좋아요 -->
							<div class="row gutter-2 gutter-md-3">
								<c:forEach var="art" items="${artListView}" varStatus="status">
									<c:if test="${status.index < 3}">
										<!-- 첫 3개 작품만 출력 -->
										<div class="col-12 col-lg-4">
											<div class="product">
												<figure class="product-image">
													<a href="product-classic.html"> <img
														src="${art.art_thumbnail_image}" alt="Image"> <img
														src="${art.art_hovering_image}" alt="Image">
													</a>
												</figure>
												<div class="product-meta">
													<h3 class="product-title">
														<a href="product-classic.html">${art.art_title}</a>
													</h3>
													<div
														class="product-info d-flex justify-content-between align-items-center">
														<div>
															<span class="artPrice" id="artPrice">${art.art_price}원</span>
															<span class="product-action"> <a class="cartAdd"
																data-member-id="${userId}" data-art-id="${art.art_id}">장바구니
																	담기</a>
															</span>
														</div>
														<!-- 하트 이모티콘 -->
														<a class="text-danger like-icon"
															data-member-id="${userId}" data-art-id="${art.art_id}">
															<i class="bi bi-heart" style="font-size: 1.5rem;"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>

							<!-- 두 번째 행: 4개 작품 -->
							<div class="row gutter-2 gutter-md-3">
								<c:forEach var="art" items="${artListView}" varStatus="status">
									<c:if test="${status.index >= 3 && status.index < 7}">
										<!-- 4개 작품 출력 -->
										<div class="col-12 col-lg-3">
											<div class="product">
												<figure class="product-image">
													<a href="product-classic.html"> <img
														src="${art.art_thumbnail_image}" alt="Image"> <img
														src="${art.art_hovering_image}" alt="Image">
													</a>
												</figure>
												<div class="product-meta">
													<h3 class="product-title">
														<a href="product-classic.html">${art.art_title}</a>
													</h3>
													<div
														class="product-info d-flex justify-content-between align-items-center">
														<div>
															<span class="artPrice" id="artPrice">${art.art_price}원</span>
															<span class="product-action"> <a class="cartAdd"
																data-member-id="${userId}" data-art-id="${art.art_id}">장바구니
																	담기</a>
															</span>
														</div>
														<!-- 하트 이모티콘 -->
														<a class="text-danger like-icon"
															data-member-id="${userId}" data-art-id="${art.art_id}">
															<i class="bi bi-heart" style="font-size: 1.5rem;"></i>
														</a>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</section>

	<section class="bg-white">
		<div class="container">
			<div class="row gutter-1 text-black">
				<div class="col-lg-5">
					<h2>인기 카테고리</h2>
				</div>
			</div>
			<div class="row masonry gutter-1 collage">
				<div class="col-lg-6 col-md-6 col-sm-12">
					<a href="${pageContext.request.contextPath}/artSearch/list?minicategoryId=301" class="card card-equal card-scale">
						<span class="image"
						style="background-image: url(resources/assets/images/도예2.jpg); height: 600px; background-size: cover; background-position: center;"></span>
						<div class="card-footer text-white">
							<span class="btn btn-white btn-action"> <i
								class="fa fa-paint-brush"></i> 도예 <span class="icon-arrow-right"></span>
							</span>
						</div>
					</a>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12">
					<a href="${pageContext.request.contextPath}/artSearch/list?minicategoryId=101"
						class="card card-equal equal-50 card-scale"> <span
						class="image"
						style="background-image: url(resources/assets/images/tiger.jpg); height: 400px; background-size: cover; background-position: center;"></span>
						<div class="card-footer text-white">
							<span class="btn btn-white btn-action"> <i
								class="fa fa-image"></i> 동양화 <span class="icon-arrow-right"></span>
							</span>
						</div>
					</a>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-12">
					<a href="${pageContext.request.contextPath}/artSearch/list?minicategoryId=102"
						class="card card-equal equal-50 card-scale"> <span
						class="image"
						style="background-image: url(resources/assets/images/oil_painting2.jpg); height: 400px; background-size: cover; background-position: center;"></span>
						<div class="card-footer text-white">
							<span class="btn btn-white btn-action"> <i
								class="fa fa-palette"></i> 서양화 <span class="icon-arrow-right"></span>
							</span>
						</div>
					</a>
				</div>
			</div>
		</div>
	</section>



	<!-- Exhibition Information -->
	<section id="exhibition-info" class="pb-1 no-overflow">
		<div class="container">
			<h3>전시 소식</h3>
			<div class="row gutter-1">
				<div class="col-md-6 col-lg-4 level-1">
					<!-- Exhibition Card -->
					<div class="card card-equal bg-primary text-white"
						style="height: 500px; background-color: #1f3269 !important;">
						<!-- 카드 헤더 -->
						<div class="card-header p-4 text-center"></div>

						<!-- 카드 본문 -->
						<div class="card-body p-4 text-center">
							<h3 class="card-title">
								<b id="exhibition-name">${exhibition.exhibition_title} <i
									class="bi-arrow-left"></i></b>
							</h3>

							<h5 class="card-text">
								<b>Date</b>
							</h5>
							<p class="mb-2" id="exhibition-date">${exhibition.exhibition_start_date}</p>

							<h5 class="card-text">
								<b>Location</b>
							</h5>
							<p class="mb-2" id="exhibition-location">${exhibition.exhibition_location}</p>

							<h5 class="card-text">
								<b>University</b>
							</h5>
							<p class="mb-2" id="exhibition-university">${exhibition.exhibition_univ}</p>

							<h5 class="card-text">
								<b>Major</b>
							</h5>
							<p class="mb-2" id="exhibition-major">${exhibition.exhibition_major}</p>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-8">
					<!-- Owl Carousel -->
					<div class="owl-carousel owl-carousel-alt visible"
						data-items="[2,2,1,1]" data-margin="10" data-loop="true"
						data-nav="true">
						<c:forEach var="exhibition" items="${exhibitionList}">
							<figure class="equal">
								<a class="image image-fade" href="${exhibition.exhibition_link}"
									style="background-image: url('${exhibition.exhibition_poster}')"
									target="_blank" data-id="${exhibition.exhibition_id}"
									data-exhibition-name="${exhibition.exhibition_title}"
									data-exhibition-date="${exhibition.exhibition_start_date}"
									data-exhibition-location="${exhibition.exhibition_location}"
									data-exhibition-university="${exhibition.exhibition_univ}"
									data-exhibition-major="${exhibition.exhibition_major}"> </a>
							</figure>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script>
function loadCartItems() {
    const cartItemsContainer = document.getElementById('cartItemsContainer');
    const template = document.getElementById('cartItemTemplate').innerHTML;

    cartItemsContainer.innerHTML = ''; // 기존 내용을 초기화

    fetch('${pageContext.request.contextPath}/cart/cartmodal', { method: 'GET' })
        .then(response => response.json())
        .then(cartList => {
        	
            if (cartList.length === 0) {
                cartItemsContainer.innerHTML = '<p>장바구니가 비어 있습니다.</p>';
                return;
            }

            cartList.forEach(item => {
            	
            	 // 가격 필터 적용
                const formattedPrice = formatPrice(parseInt(item.art_price));
                // 템플릿 데이터 삽입
                const cartItemHTML = template
                    .replace('{art_thumbnail_image}', item.art_thumbnail_image)
                    .replace('{art_title}', item.art_title)
                    .replace('{category_type}', item.category_type)
                    .replace('{mini_category_type}', item.mini_category_type)
                    .replace('{price}', formattedPrice)
                    .replace('{artid}', item.art_ID);

                cartItemsContainer.insertAdjacentHTML('beforeend', cartItemHTML);
            });
        })
        .catch(error => {
            console.error('Error fetching cart items:', error);
            cartItemsContainer.innerHTML = '<p>카트 데이터를 가져오는 데 실패했습니다.</p>';
        });
}

// 카트 개수 업데이트 함수
function updateCartItemCount() {
    fetch('${path}/cart/cartmodal', { method: 'GET' })
        .then(response => response.json())
        .then(cartList => {
            const cartItemCountElement = document.getElementById('cartItemCount');
            cartItemCountElement.textContent = cartList.length || 0; // 개수 설정
        })
        .catch(error => {
            console.error('Error fetching cart count:', error);
        });
}
$(document).ready(function() {
	

    // Carousel이 슬라이드될 때마다 카드 업데이트
    $('.owl-carousel').on('changed.owl.carousel', function(event) {
        var currentItem = event.item.index;  // 현재 슬라이드 항목의 인덱스
        var exhibition = event.relatedTarget.items()[currentItem];  // 선택된 항목
        

        // 선택된 figure에 해당하는 전시회 정보 가져오기
        var exhibitionName = $(exhibition).find('a').data('exhibition-name');
        var exhibitionDate = $(exhibition).find('a').data('exhibition-date');
        var exhibitionLocation = $(exhibition).find('a').data('exhibition-location');
        var exhibitionUniversity = $(exhibition).find('a').data('exhibition-university');
        var exhibitionMajor = $(exhibition).find('a').data('exhibition-major');

        // 카드 내용 업데이트
        $('.card-body #exhibition-name').text(exhibitionName);
        $('.card-body #exhibition-date').text(exhibitionDate);
        $('.card-body #exhibition-location').text(exhibitionLocation);
        $('.card-body #exhibition-university').text(exhibitionUniversity);
        $('.card-body #exhibition-major').text(exhibitionMajor);
    });
});

</script>

	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>

	<script>
//좋아요
document.addEventListener('DOMContentLoaded', function() {
	    // 좋아요 상태 확인
	    document.querySelectorAll('.like-icon').forEach(icon => {
	        const memberId = icon.dataset.memberId;
	        const artId = icon.dataset.artId;
	        const heartIcon = icon.querySelector('i');

	        // 서버에 상태 확인 요청

	        fetch(`${pageContext.request.contextPath}/api/likes/check`, {

	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify({ member_id: memberId, art_id: artId })
	        })
	            .then(response => response.json())
	            .then(isLiked => {
	            	console.log('isLiked:',isLiked);
	                if (isLiked) {
	                    heartIcon.classList.remove('bi-heart');
	                    heartIcon.classList.add('bi-heart-fill');
	                } else {
	                    heartIcon.classList.remove('bi-heart-fill');
	                    heartIcon.classList.add('bi-heart');
	                }
	            })
	            .catch(error => console.error('Error:', error));
	    });

	    // 좋아요 상태 변경 처리
	    document.querySelectorAll('.like-icon').forEach(icon => {
	        icon.addEventListener('click', function (e) {
	            e.preventDefault();

	            const memberId = this.dataset.memberId;
	            const artId = this.dataset.artId;
	            const heartIcon = this.querySelector('i');

	            // 서버에 상태 변경 요청
<<<<<<< HEAD
	            fetch(`${pageContext.request.contextPath}/api/likes/toggle`, {
=======
	            fetch(`${path}/api/likes/toggle`, {
>>>>>>> f0623bf243e720250b340bbab148728cd09f2345
	                method: 'POST',
	                headers: { 'Content-Type': 'application/json' },
	                body: JSON.stringify({ member_id: memberId, art_id: artId })
	            })
	                .then(response => response.json())
	                .then(newStatus => {
	                    if (newStatus) {
	                        heartIcon.classList.remove('bi-heart');
	                        heartIcon.classList.add('bi-heart-fill');
	                    } else {
	                        heartIcon.classList.remove('bi-heart-fill');
	                        heartIcon.classList.add('bi-heart');
	                    }
	                })
	                .catch(error => console.error('Error:', error));
	        });
	    });
	});

//장바구니

document.querySelectorAll('.cartAdd').forEach(icon => {
	    icon.addEventListener('click', function (e) {
	        e.preventDefault(); // 기본 동작 방지
	        updateCartItemCount();
	        const memberId = this.dataset.memberId; // 데이터 속성에서 memberId 가져오기
	        const artId = this.dataset.artId; // 데이터 속성에서 artId 가져오기

	        if (!memberId || !artId) {
	            
	            return;
	        }

	        // 서버에 요청
	        fetch('${path}/cart/add', {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify({ member_id: memberId, art_id: artId }) // JSON 데이터로 전송
	        })
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error(`HTTP 상태 코드 오류: ${response.status}`);
	                }
	                return response.json();
	            })
	            .then(data => {
	                if (data.success) {
	                    alert(data.message || '장바구니에 담겼습니다.');
	                    updateCartItemCount();
	                } else {
	                    alert(data.message);
	                }
	            })
	            .catch(error => console.error('Error:', error));
	    });
	});
</script>




</body>
</html>