<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<title>Jollery</title>
<style>
body{
	background-color: #757c7f0a !important;
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
	<section class="pt-15">
		<div class="container">
			<div class="row gutter-4 justify-content-between d-flex">
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

				<!-- orders -->
				<div class="tab-pane fade show active col-lg-9 p-4 rounded shadow-sm bg-white" id="sidebar-1-2"
					role="tabpanel" aria-labelledby="sidebar-1-2" style="margin-top:20px;">
					<div class="row">
						<div class="col-12">
							<h3 class="mb-0">주문 내역</h3>
							<span class="eyebrow">${orderWithArts.size()}개의 주문이 있습니다.</span>
							<!-- 주문한 상품 수 -->
						</div>
					</div>
					<div class="row gutter-2">
						<c:forEach var="item" items="${orderWithArts}">
							<div class="col-12">
								<div class="order p-4 rounded shadow-sm bg-white"
									style="border: 0.1px solid #ddd;">
									<div class="row align-items-center">
										<div class="col-lg-4">
											<h3 class="order-number">
												${item.artTitleList[0]}
												<c:if test="${fn:length(item.artTitleList) > 1}">
                                    외 ${fn:length(item.artTitleList) - 1}개
                                </c:if>
												<br>(${fn:substring(item.order_date, 0, 10)})
												<!-- 주문날짜와 첫 번째 작품 제목 -->
											</h3>
											<a href="${path}/orderitem?orderId=${item.order_id}"
												class="action eyebrow underline">상세보기</a>
										</div>
										<div class="col-lg-4">
											<span
												class="order-status ${item.artStatusList[0] == '배송중' ? 'sent' : 'canceled'}">
												${item.artStatusList[0]} <!-- 첫 번째 작품 상태 -->
											</span>
										</div>
										<div class="col-lg-4">
											<ul class="order-preview justify-content-end">
												<li><a href="product-${item.art_id}.html"
													title="${item.art_title}" data-toggle="tooltip"
													data-placement="top"> <img
														src="${item.artImage[0]}" alt="${item.art_title}">
												</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					
				</div>
				<!-- / orders -->



			</div>
		</div>
	</section>

	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>

	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
</body>
</html>