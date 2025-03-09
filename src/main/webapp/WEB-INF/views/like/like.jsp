<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
	rel="stylesheet">
<title>Jollery</title>
<style>
body {
	background-color: #757c7f0a !important;
}

.card-body img {
	width: 100%; /* 부모 요소의 너비에 맞게 조정 */
	height: 200px; /* 원하는 고정 높이 */
	object-fit: cover; /* 이미지 비율 유지 및 고정 크기에 맞춤 */
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
	<section class="hero hero-small bg-white text-white py-4"></section>

	<!-- listing -->
	<section class="pt-5">
		<div class="container">
			<div class="row gutter-4 justify-content-between">

				<!--  sidebar -->
				<c:choose>
					<c:when test="${isArtist == '1'}">
						<%@ include file="/WEB-INF/views/common/sellersidebar.jsp"%>
					</c:when>
					<c:otherwise>
						<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
					</c:otherwise>
				</c:choose>
				<!-- / sidebar -->


				<!-- / sidebar -->

				<!-- content -->
				<div class="col-lg-9">
					<div class="row">
						<div class="col">
							<div class="tab-content" id="myTabContent">


								<!-- wishlist -->
								<div class="tab-pane fade show active" id="sidebar-1-3"
									role="tabpanel" aria-labelledby="sidebar-1-3">
									<div class="row">
										<div class="col">
											<h3 class="mb-0">관심 상품</h3>
											<span class="eyebrow">총 갯수: ${likedArts.size()}</span>
										</div>
									</div>
									<div class="row gutter-2">
										<c:forEach var="art" items="${likedArts}">
											<div class="col-md-6 col-lg-4 bg-white rounded shadow">
												<!-- 부트스트랩 카드 컴포넌트 -->
												<div class="card">
													<!-- 카테고리 -->
													<div class="card-header text-left">
														${art.category_type} / ${art.mini_category_type}</div>

													<!-- 작가 이름 -->

													<div class="card-body text-left"
														style="padding: 0.7rem; font-size: 1.0rem; margin-left:20px;">

														<p class="card-text ">${art.member_name}</p>
													</div>

													<!-- 이미지 -->
													<div class="card-body text-center" style="padding: 1rem;">
														<img src="${art.art_thumbnail_image}" class="img-fluid"
															alt="Artwork Thumbnail">
													</div>

													<!-- 제목, 가격, 하트 -->
													<div class="card-footer">
														<div
															class="d-flex justify-content-between align-items-center">
															<!-- 제목과 가격 -->
															<div>
																<a href="/jollery/art/detail/${art.art_ID}"
																	class="card-title mb-0">${art.art_title}</a>
																<p class="card-text mb-0" id="artPrice">${art.art_price}원</p>
															</div>

															<!-- 하트 이모티콘 -->
															<a class="text-danger like-icon"
																data-member-id="${userId}" data-art-id="${art.art_ID}">
																<i class="bi bi-heart" style="font-size: 1.5rem;"></i>
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
					</div>
				</div>
				<!-- / content -->

			</div>
		</div>
	</section>
	<!-- listing -->



	<!-- footer -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>





	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    // 좋아요 상태 확인
	    document.querySelectorAll('.like-icon').forEach(icon => {
	        const memberId = icon.dataset.memberId;
	        const artId = icon.dataset.artId;
	        const heartIcon = icon.querySelector('i');

	        // 서버에 상태 확인 요청
	        fetch(`/jollery/api/likes/check`, {
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
	            fetch(`/jollery/api/likes/toggle`, {
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

	</script>
</body>
</html>