<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/booking/css/style.css' />" />


<title>Jollery</title>
<style>
main {
	margin-bottom: 200px;
	display: flex;
}

body {
	background-color: #757c7f0a !important;
}

.breadcrumb {
	background-color: #f8f9fa;
	border-radius: 0.25rem;
	padding: 0.75rem 1rem;
}

.breadcrumb-item a {
	color: #007bff;
}

.breadcrumb-item.active {
	color: #6c757d;
}

.product {
	border: 1px solid #e9ecef;
	border-radius: 0.25rem;
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.product:hover {
	transform: translateY(-5px);
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.product-image img {
	transition: opacity 0.3s ease;
}

.product-image img:first-child {
	opacity: 1;
}

.product-image img:last-child {
	position: absolute;
	top: 0;
	left: 0;
	opacity: 0;
}

.product:hover .product-image img:first-child {
	opacity: 0;
}

.product:hover .product-image img:last-child {
	opacity: 1;
}

.sidebar {
	margin-right: 50px;
	background-color: #f8f9fa;
	border: 1px solid #ddd;
	padding: 20px;
	border-radius: 8px;
}

.sidebar .widget-title {
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 15px;
}

.sidebar .nav-link {
	color: #333;
	font-weight: bold;
}

.sidebar .nav-link:hover {
	color: #007bff;
}

.product-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.like-icon {
	margin-left: auto; /* 오른쪽 끝으로 밀어내기 */
}

.text-center {
	text-align: center; /* 중앙 정렬 */
}

.text-primary {
	color: #fff; /* 파란색 텍스트 */
	font-weight: bold; /* 굵은 텍스트 */
}

.text-muted {
	color: #6c757d; /* 회색 텍스트 */
	font-size: 0.9rem; /* 약간 작은 크기 */
}

.mb-2 {
	margin-bottom: 0.5rem; /* 텍스트 간 간격 조정 */
}

.eyebrow {
	font-size: 1rem; /* 작은 제목 크기 */
	letter-spacing: 0.05rem; /* 약간의 간격 추가 */
}

.product-image img {
	width: 100%; /* 부모 요소의 너비에 맞춤 */
	height: 200px; /* 원하는 고정 높이 */
	object-fit: contain; /* 이미지가 잘리지 않고 비율 유지 */
}

.fixed-sidebar {
	position: fixed; /* 화면에 고정 */
	top: 0; /* 뷰포트 상단에 고정 */
	left: 0; /* 좌측에 고정 (컬럼 위치에 따라 조정) */
	height: 600px; /* 뷰포트 전체 높이 */
	overflow-y: auto; /* 내용이 넘치면 스크롤 표시 */
	background-color: white; /* 배경색 유지 */
}
</style>


</head>
<body>

	<c:choose>


		<c:when test="${not empty userId}">
			<%@ include file="/WEB-INF/views/common/userheader.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="/WEB-INF/views/common/guestheader.jsp"%>
		</c:otherwise>
	</c:choose>



	<!-- hero -->
	<section class="hero hero-small bg-white text-white py-4"></section>






	<main>
		<!-- listing -->
		<section class="pt-6">
			<div class="container">
				<div class="row justify-content-end">
					<div class="col-lg-9">
						<div class="row gutter-2 align-items-end">
							<div class="col-md-6 text-center" style="text-align: right;">
								<h3 class="mb-2 text-dark"
									style="font-weight: bold; font-family: 'Roboto', sans-serif; margin-left: 130px;">
									<c:choose>
										<c:when test="${not empty searchQuery}">
                '${searchQuery}' 검색 결과
            </c:when>
										<c:otherwise>
                ${categoryName.mini_category_type}
            </c:otherwise>
									</c:choose>
								</h3>
								<span class="eyebrow text-muted d-block"
									style="margin-left: 130px;"> <c:choose>
										<c:when test="${not empty searchQuery}">
                ${artList.size()} products
            </c:when>
										<c:otherwise>
                ${artList.size()} products
            </c:otherwise>
									</c:choose>
								</span>
							</div>
							<div class="col-md-6 text-md-right">
								<div class="dropdown">
									<a class="btn btn-outline-secondary btn-sm dropdown-bs-toggle"
										href="#!" role="button" id="dropdownMenuLink"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false"> 정렬 기준 </a>

									<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<a class="dropdown-item filter-option" data-filter="recent">최근
											작품순</a> <br> <a class="dropdown-item filter-option"
											data-filter="popular">조회수순</a> <br> <a
											class="dropdown-item filter-option" data-filter="likes">좋아요순</a>
										<br> <a class="dropdown-item filter-option"
											data-filter="priceLow">낮은 가격순</a> <br> <a
											class="dropdown-item filter-option" data-filter="priceHigh">높은
											가격순</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row gutter-4">

					<!-- sidebar -->
					<aside class="col-lg-2 sidebar bg-white shadow fixed-sidebar">

						<div class="widget">
							<span class="widget-collapse d-lg-none" data-toggle="collapse"
								data-target="#collapse-1" aria-expanded="false"
								aria-controls="collapse-1" role="button"> Filter by
								Category </span>
							<div class="d-lg-block collapse" id="collapse-1">
								<span class="widget-title">Categories</span>
								<div class="widget-content">
									<ul id="page-nav" class="nav flex-column nav-category">

										<li class="nav-item"><a class="nav-link"
											data-toggle="collapse" href="#menu-2" role="button"
											aria-expanded="false" aria-controls="menu-2">회화</a>
											<div class="collapse" id="menu-2" data-parent="#page-nav">
												<div>
													<ul class="nav flex-column">
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=101">동양화</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=102">서양화</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=103">판화</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=104">혼합(기타)</a>
														</li>
													</ul>
												</div>
											</div></li>

										<li class="nav-item"><a class="nav-link"
											data-toggle="collapse" href="#menu-3" role="button"
											aria-expanded="false" aria-controls="menu-3">조소</a>
											<div class="collapse" id="menu-3" data-parent="#page-nav">
												<div>
													<ul class="nav flex-column">
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=201">석재</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=202">목재</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=203">금속</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=204">3D프린팅</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=205">혼합재료(기타)</a>
														</li>
													</ul>
												</div>
											</div></li>

										<li class="nav-item"><a class="nav-link"
											data-toggle="collapse" href="#menu-4" role="button"
											aria-expanded="false" aria-controls="menu-4">공예</a>
											<div class="collapse" id="menu-4" data-parent="#page-nav">
												<div>
													<ul class="nav flex-column">
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=301">도예</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=302">유리공예</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=303">금속공예</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=304">목공예</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=305">혼합재료(기타)</a>
														</li>
													</ul>
												</div>
											</div></li>

										<li class="nav-item"><a class="nav-link"
											data-toggle="collapse" href="#menu-5" role="button"
											aria-expanded="false" aria-controls="menu-5">기타</a>
											<div class="collapse" id="menu-5" data-parent="#page-nav">
												<div>
													<ul class="nav flex-column">
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=401">사진</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=402">설치미술</a>
														</li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=403">서예</a></li>
														<li class="nav-item"><a class="nav-link"
															href="${path}/artSearch/list?minicategoryId=404">실험예술(기타)</a>
														</li>
													</ul>
												</div>
											</div></li>




									</ul>
								</div>
							</div>
						</div>




						<div class="widget">
							<h3 class="widget-title">Filter by Price</h3>
							<div class="widget-content">
								<label for="minPrice">최소금액:</label> <input type="number"
									id="minPrice" class="form-control rounded" placeholder="0"
									min="0"> <label for="maxPrice">최대금액:</label> <input
									type="number" id="maxPrice" class="form-control rounded"
									placeholder="1000000" min="0">
								<button id="applyPriceFilter"
									class="btn mt-3 text-white rounded"
									style="background-color: #1f3269">확인</button>
							</div>
						</div>


					</aside>

					<!-- content -->
					<div class="col-lg-9">
						<div class="row gutter-2 gutter-lg-3 bg-white rounded shadow"
							id="art-list">
							<!-- 반복문으로 상품 출력 -->
							<c:forEach var="art" items="${artList}">
								<div class="col-6 col-md-4" data-price="${art.art_price}"
									data-date="${art.art_post_date }" data-view="${art.art_view}"
									data-like="${art.art_like }">
									<div class="product">
										<figure class="product-image">
											<a href="${path}/art/detail/${art.art_id}"> <img
												src="${art.art_thumbnail_image}" alt="${art.art_title}">
												<img src="${art.art_hovering_image}" alt="${art.art_title}">
											</a>
										</figure>
										<div class="product-meta">
											<h3 class="product-title">
												<a href="${path}/art/detail/${art.art_id}"
													style="display: inline-block; max-width: 220px; margin-left: 20px; font-weight: bold; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${art.art_title}</a>
											</h3>
											<div
												class="product-info d-flex justify-content-between align-items-center">
												<div>
													<c:choose>
														<c:when test="${art.art_status == '판매중'}">
															<span class="artPrice" id="artPrice"
																style="margin-left: 20px;">${art.art_price}원</span>
															<span class="product-action"> <a class="cartAdd"
																data-member-id="${userId}" data-art-id="${art.art_id}">장바구니
																	담기</a>
															</span>
														</c:when>
														<c:otherwise>
															<p style="margin-left: 20px;">이미 판매된 상품입니다.</p>
														</c:otherwise>
													</c:choose>
												</div>
												<!-- 하트 이모티콘 -->
												<a class="text-danger like-icon" data-member-id="${userId}"
													data-art-id="${art.art_id}"> <i class="bi bi-heart"
													style="font-size: 1.4rem;"></i>
												</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>

					</div>

				</div>
			</div>
		</section>
	</main>

	<script>


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
	document.querySelectorAll('.cartAdd').forEach(icon => {
	    icon.addEventListener('click', function (e) {
	        e.preventDefault(); // 기본 동작 방지

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
	                    updateCartItemCount()
	                } else {
	                	alert(data.message);
	                }
	            })
	            .catch(error => console.error('Error:', error));
	    });
	});
</script>
	<script>
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

	            fetch(`${pageContext.request.contextPath}/api/likes/toggle`, {

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
	
	//filltering
	document.addEventListener("DOMContentLoaded", () => {
    // 필터 옵션과 작품 리스트 가져오기
    const filterOptions = document.querySelectorAll(".filter-option");
    const artList = document.getElementById("art-list");
    const artItems = Array.from(document.querySelectorAll("#art-list .col-6"));

    filterOptions.forEach(option => {
        option.addEventListener("click", (e) => {
            const filter = e.target.getAttribute("data-filter");

            // 기존 리스트 정렬
            let sortedItems = [...artItems];

            if (filter === "recent") {
                // 최신 작품순 (날짜 기준 내림차순)
                sortedItems.sort((a, b) => new Date(b.dataset.date) - new Date(a.dataset.date));
            } else if (filter === "popular") {
                // 조회수순 (조회수 기준 내림차순)
                sortedItems.sort((a, b) => b.dataset.view - a.dataset.view);
            } else if (filter === "likes") {
                // 관심순 (좋아요 기준 내림차순)
                sortedItems.sort((a, b) => b.dataset.like - a.dataset.like);
            } else if (filter === "priceLow") {
                // 낮은 가격순 (가격 기준 오름차순)
                sortedItems.sort((a, b) => a.dataset.price - b.dataset.price);
            } else if (filter === "priceHigh") {
                // 높은 가격순 (가격 기준 내림차순)
                sortedItems.sort((a, b) => b.dataset.price - a.dataset.price);
            } 

            // 정렬된 항목으로 리스트 다시 렌더링
            artList.innerHTML = "";
            sortedItems.forEach(item => artList.appendChild(item));
        });
    });
});

	document.getElementById('applyPriceFilter').addEventListener('click', function () {
	    // 가격 범위 필터링을 위해 minPrice와 maxPrice를 가져옵니다.
	    const minPrice = parseInt(document.getElementById('minPrice').value) || 0;
	    const maxPrice = parseInt(document.getElementById('maxPrice').value) || 1000000;
	    

	    // 가격 범위 필터링 (priceRange)
	    filter = "priceRange";  // 필터를 "priceRange"로 설정
		
	    // 필터링 및 정렬 로직
	    let sortedItems = [...document.querySelectorAll("#art-list .col-6")];  // 예시로 .product 클래스를 가진 모든 항목을 가져옴
		console.log(sortedItems);
	    if (filter === "priceRange") {
	        // 가격 범위 필터링 (가격 범위에 맞는 아이템만 남기고 정렬)
	        sortedItems = sortedItems.filter(item => {
	            const price = parseInt(item.dataset.price);
	            return price >= minPrice && price <= maxPrice;
	        });

	        // 가격 오름차순 정렬
	        sortedItems.sort((a, b) => a.dataset.price - b.dataset.price);
	    }

	    // 정렬된 아이템을 다시 DOM에 렌더링 (예시로 art-list에 업데이트)
	    const artList = document.getElementById('art-list');
	    artList.innerHTML = '';  // 기존 아이템을 지움

	    sortedItems.forEach(item => {
	        artList.appendChild(item);  // 필터링된 아이템을 art-list에 추가
	    });
	});
	</script>

	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>




	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
</body>

</html>