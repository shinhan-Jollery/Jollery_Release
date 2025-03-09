<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
	rel="stylesheet">
<title>Jollery</title>
<style>
.custom-table {
	border-collapse: collapse;
}

.custom-table th, .custom-table td {
	text-align: center;
	vertical-align: middle;
}

.custom-table thead th {
	border-top: 2px solid #dee2e6;
	border-bottom: 2px solid #dee2e6;
}

.custom-table tbody td {
	border-bottom: 1px solid #dee2e6;
}

.custom-table th:first-child, .custom-table td:first-child {
	border-left: none;
}

.custom-table th:last-child, .custom-table td:last-child {
	border-right: none;
}

body {
	background-color: #757c7f0a !important;
}

.but {
	background-color: #1f3269 !important;
	color: #fff !important;
	border: none !important; /* 기본 테두리 제거 */
	border-radius: 10px !important;
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
			<div class="row gutter-4 justify-content-between d-flex">

				<!-- sidebar -->
				<c:choose>
					<c:when test="${Integer.parseInt(isArtist) == 1}">
						<%@ include file="/WEB-INF/views/common/sellersidebar.jsp"%>
					</c:when>
					<c:otherwise>
						<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
					</c:otherwise>
				</c:choose>
				<!-- / sidebar -->

				<!-- 판매 내역 -->
				<div class="tab-pane fade show active col-lg-9" id="sidebar-1-5"
					role="tabpanel" aria-labelledby="sidebar-1-5">

					<!-- 현재 판매중인 상품 -->
					<div class="row border p-3 mb-4 rounded bg-white shadow-lg">
						<div class="col-12">
							<div
								class="d-flex justify-content-between align-items-center  px-3 py-2 rounded mb-3">
								<h5 class="mb-0 text-dark" style="font-size: 16px;">현재 판매중인
									상품</h5>

							</div>
						</div>
						<div class="col-12">
							<c:forEach var="art" items="${onSaleArts}">
								<div class="card mb-3 border">
									<div class="card-body">
										<div class="row align-items-center">
											<div class="col-md-2 text-center">
												<img src="${art.art_thumbnail_image}" alt="${art.art_title}"
													class="img-fluid rounded">
											</div>
											<div class="col-md-4">
												<h5 class="card-title mb-1">${art.art_title}</h5>
												<p class="card-text text-muted mb-0">${art.category_type}/${art.mini_category_type}</p>
											</div>
											<div class="col-md-2">
												<span
													class="order-status ${art.art_status == '판매중' ? 'sent' : 'canceled'}">
													${art.art_status} <!-- 첫 번째 작품 상태 -->
												</span>
											</div>
											<div class="col-md-2 text-end">
												<!-- art_price에 쉼표 추가 -->
												<span class="text-dark fw-bold" id="artPrice">${art.art_price}</span>
											</div>
											<div class="col-md-2 text-end">
												<a href="${path}/art/detail/${art.art_ID}"
													class="but btn btn-outline-primary btn-sm">상세 보기</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

					<!-- 배송중 상품 -->
					<div class="row border p-3 mb-4 rounded bg-white shadow-lg">
						<div class="col-12">
							<div
								class="d-flex justify-content-between align-items-center bg-white px-3 py-2 rounded mb-3">
								<h5 class="mb-0 text-dark" style="font-size: 16px;">결제완료 상품</h5>

							</div>
						</div>
						<div class="col-12">
							<c:forEach var="art" items="${orderArts}">
								<div class="card mb-3 border">
									<div class="card-body">
										<div class="row align-items-center">
											<div class="col-md-2 text-center">
												<img src="${art.art_thumbnail_image}" alt="${art.art_title}"
													class="img-fluid rounded">
											</div>
											<div class="col-md-4">
												<h5 class="card-title mb-1">${art.art_title}</h5>
												<p class="card-text text-muted mb-0">${art.category_type}/${art.mini_category_type}</p>
											</div>
											<div class="col-md-2">
												<span
													class="order-status ${art.art_status == '배송중' ? 'sent' : 'canceled'}">
													${art.art_status} <!-- 첫 번째 작품 상태 -->
												</span>
											</div>
											<div class="col-md-2 text-end">
												<span class="text-dark fw-bold" id="artPrice">${art.art_price}</span>
											</div>
											<div class="col-md-2 text-end">
												<a href="${path}/art/detail/${art.art_ID}"
													class="but btn btn-outline-primary btn-sm">상세 보기</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
							<c:forEach var="art" items="${deliveryArts}">
								<div class="card mb-3 border">
									<div class="card-body">
										<div class="row align-items-center">
											<div class="col-md-2 text-center">
												<img src="${art.art_thumbnail_image}" alt="${art.art_title}"
													class="img-fluid rounded">
											</div>
											<div class="col-md-4">
												<h5 class="card-title mb-1">${art.art_title}</h5>
												<p class="card-text text-muted mb-0">${art.category_type}/${art.mini_category_type}</p>
											</div>
											<div class="col-md-2">
												<span
													class="order-status ${art.art_status == '배송중' ? 'sent' : 'canceled'}">
													${art.art_status} <!-- 첫 번째 작품 상태 -->
												</span>
											</div>
											<div class="col-md-2 text-end">
												<span class="text-dark fw-bold" id="artPrice">${art.art_price}</span>
											</div>
											<div class="col-md-2 text-end">
												<a href="${path}/art/detail/${art.art_ID}"
													class="but btn btn-outline-primary btn-sm">상세 보기</a>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>

					<!-- 판매 완료 -->
					<div class="row border p-3 mb-4 rounded bg-white shadow-lg">
						<div class="col-12">
							<div
								class="d-flex justify-content-between align-items-center bg-white px-3 py-2 rounded mb-3">
								<h5 class="mb-0 text-dark" style="font-size: 16px;">판매 완료
									상품</h5>

							</div>
						</div>
						<div class="col-12">
							<c:forEach var="art" items="${soldArts}">
								<div class="card mb-3 border">
									<div class="card-body">
										<div class="row align-items-center">
											<div class="col-md-2 text-center">
												<img src="${art.art_thumbnail_image}" alt="${art.art_title}"
													class="img-fluid rounded">
											</div>
											<div class="col-md-4">
												<h5 class="card-title mb-1">${art.art_title}</h5>
												<p class="card-text text-muted mb-0">${art.category_type}/${art.mini_category_type}</p>
											</div>
											<div class="col-md-2">
												<span
													class="order-status ${art.art_status == '판매완료' ? 'light' : 'canceled'}">
													${art.art_status} <!-- 첫 번째 작품 상태 -->
												</span>
											</div>
											<div class="col-md-2 text-end">
												<span class="text-muted" id="artPrice">${art.art_price}</span>
											</div>
											<div class="col-md-2 text-end">
												<a href="${path}/art/detail/${art.art_ID}"
													class="but btn btn-outline-primary btn-sm">상세 보기</a>
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
	</section>


	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
</body>
</html>