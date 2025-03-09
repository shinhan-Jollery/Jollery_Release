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

<link rel="stylesheet" href="${path}/resources/assets/css/vendor.css" />
<link rel="stylesheet" href="${path}/resources/assets/css/style.css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
	rel="stylesheet">


<title>Jollery</title>
<style>
/* ===== 전체 구조 ===== */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #757c7f0a !important; /* 페이지 배경: 밝은 회색 */
	color: #333; /* 기본 글자 색상 */
}

main {
	margin-top: 30px;
	margin-bottom: 80px;
	display: flex;
}

.cart-container {
	display: flex;
	gap: 40px;
	padding: 10px;
	max-width: 1100px;
}

.cart-items {
	width: 70%;
	margin-left: 105px;
}

.cart-items h3 {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 15px;
	font-size: 30px;
	color: #333; /* 기본 텍스트 색상 */
}

/* ===== 테이블 스타일 ===== */
.cart-items table {
	text-align: center;
	width: 100%;
	border-collapse: collapse;
	background-color: #fff; /* 테이블 배경: 흰색 */
	border: 1px solid #cfbfe7e8; /* 테두리 */
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
	margin-bottom: 110px;
}

.cart-items th {
	background-color: #32304ffc; /* 헤더 배경: 어두운 회색 */
	color: white; /* 헤더 글자 색상 */
	font-weight: bold;
	font-size: 16px;
	padding: 15px;
	text-transform: uppercase;
	border-bottom: 2px solid #444; /* 헤더 하단 테두리 */
}

.cart-items td {
	padding: 15px;
	border-bottom: 1px solid #ddd;
	text-align: center;
	vertical-align: middle;
	font-size: 14px;
	color: #555; /* 셀 텍스트 색상 */
}

.cart-items tr:nth-child(even) {
	background-color: #f9f9f9; /* 교차 행 배경 */
}

.cart-items tr:hover {
	background-color: #f1f1f1; /* hover 효과 */
	transition: all 0.2s ease;
}

/* ===== 이미지 스타일 ===== */
td.not-empty img {
	display: block;
	margin: 0 auto;
	max-width: 100%;
	height: auto;
}

.cart-items td img {
	width: 100px;
	height: 90px;
	object-fit: cover;
	margin-right: 15px;
	border-radius: 5px; /* 이미지 둥글게 */
	border: 1px solid #ddd; /* 이미지 테두리 */
}

/* ===== 버튼 스타일 ===== */
.delete button {
	background-color: #a2abb99e; /* 버튼 배경 색상 */
	height: 18px; /* 버튼 높이 */
	width: 18px; /* 버튼 너비 (동그랗게 만들기 위해 높이와 동일) */
	border-radius: 50%; /* 동그란 모양 */
	border: none; /* 테두리 제거 */
	color: #dc3545; /* X 표시 색상 */
	font-size: 10px; /* X 표시 크기 */
	cursor: pointer; /* 클릭 가능한 커서 표시 */
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 */
}

.delete button:hover {
	background-color: #dc3545; /* hover 시 배경색 변경 */
	color: white; /* hover 시 X 색상 변경 */
	transition: background-color 0.3s ease, color 0.3s ease; /* 부드러운 전환 */
}


/* ===== 빈 장바구니 스타일 ===== */
.empty-cart {
	text-align: center;
	vertical-align: middle;
}

.empty-cart i {
	font-size: 3rem; /* 아이콘 크기 */
	display: block; /* 아이콘을 중앙 정렬 */
	margin-bottom: 20px; /* 아이콘과 텍스트 간격 */
	color: #6c757d; /* 중간 회색 */
}

.empty-cart p {
	margin-bottom: 20px; /* 텍스트와 버튼 간격 */
	color: #555; /* 텍스트 색상 */
}

.empty-message {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

	<!-- Hero Section -->
	<section class="hero hero-small bg-white text-white py-4"></section>

	<main>
		<!-- Cart Section -->
		<section class="pt-5">
			<div class="bg-mode shadow rounded-2 overflow-hidden w-100"
				style="margin-left: 365px; width: 1200px !important;">
				<!-- 최대 너비를 약간 줄임 -->
				<div class="cart-container">
					<div class="cart-items">
						<h3>장바구니</h3>
						<br>
						<table>
							<thead>
								<tr>
									<th style="width: 20%;"></th>
									<th colspan="2" style="width: 30%;">PRODUCT</th>
									<th style="width: 9%;"></th>
									<th class="price" style="width: 21%;">PRICE</th>
									<th class="delete" style="width: 20%;">DELETE</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty cartList}">
										<td colspan="5" class="empty-cart">
											<div class="empty-message" style="margin-left: 150px">
												<i class="bi bi-cart-x text-secondary"></i>
												<p>장바구니가 비어있습니다!</p>
											</div>
										</td>
									</c:when>
									<c:otherwise>
										<c:forEach items="${cartList}" var="cart">
											<tr>
												<td class="not-empty"><a
													href="${path}/art/detail/${cart.art_ID}"> <img
														src="${cart.art_thumbnail_image}" alt="Product Image">
												</a></td>
												<td colspan="2" style="width: 290px;"><span
													style="font-weight: bold;">${cart.art_title}</span><br>
													${cart.category_type} / ${cart.mini_category_type}</td>
												<td><a class="text-danger like-icon"
													data-member-id="${userId}" data-art-id="${cart.art_ID}">
														<i class="bi bi-heart"></i>
												</a></td>
												<td class="price" id="artPrice">${cart.art_price}원</td>
												<td class="delete">
													<button onclick="deleteCart(${cart.art_ID})">&times;</button>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>

					<div class="cart-summary">
						<div class="content-wrapper">
							<div>
								<h4>
									<font color="#007bff">결제 예정 금액</font>
								</h4>

								<c:set var="sum" value="0" />
								<c:forEach var="p" items="${cartList}">
									<c:set var="sum" value="${sum + p.art_price}" />
								</c:forEach>
								<span style="font-size: 24px; font-weight: bold;" id="artPrice">${sum}
									원 </span> <br>


							</div>


						<hr>
						<c:set var="totalItems" value="0" />
						<c:forEach var="c" items="${cartList}">
							<c:set var="totalItems" value="${totalItems + 1}" />
						</c:forEach>
						<p>- 총 상품 수: ${totalItems}개</p>
						<p>- 배송비: Free </p>
						<hr>
						<button onclick="location.href='${path}/order/orderpage'">상품
							주문하기</button>
						<button onclick="location.href='${path}/like'">관심 상품</button>

					</div>
				</div>
			</div>
		</section>
	</main>



	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script>							
document.addEventListener('DOMContentLoaded', function () {
    function deleteCart(art_ID) {
    	console.log(art_ID);
        $.ajax({
            url:  '${path}/cart/delete/' + art_ID,  // RESTful DELETE URL
            type: 'DELETE',
            success: function (response) {
                
                location.reload();  // 페이지를 리로드하여 장바구니 목록 갱신
            },
            error: function (xhr, status, error) {
                alert("삭제 실패: " + error);  // 삭제 실패 시 알림
                console.error("Error details:", xhr, status, error);  // 추가 디버깅 정보 출력

            }
        });
    }

    // Ensure the function is globally accessible
    window.deleteCart = deleteCart;
});

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

</script>
	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
</body>
</html>