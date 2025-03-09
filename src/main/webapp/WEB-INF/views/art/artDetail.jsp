<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>

<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<title>Jollery</title>
<style>
.art-container {
	display: flex;
	flex-direction: column;
	gap: 20px;
	border: 1px solid #ddd;
	padding: 40px;
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin: 0 auto; /* 수평 중앙 정렬 */
	width: 100%;
	min-height: 900px; /* 최소 높이 설정 */
}

.main-info {
	display: flex;
	gap: 20px;
}

.main-info .image-section {
	flex: 1;
}

.main-info .image-section img {
	width: 760px;
	height: 500px; /* 원하는 고정 높이 */
	object-fit: contain; /* 이미지가 컨테이너에 맞춰 크기 조정 */
	border-radius: 8px;
}

.main-info .details-section {
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.main-info .details-section h1 {
	font-size: 28px !important;
	margin-bottom: 20px;
}

.main-info .details-section .info {
	margin-bottom: 20px;
}

.main-info .details-section .info p {
	margin: 5px 0;
}

.main-info .details-section .actions button {
	background-color: #28A745;
	color: white;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	margin-right: 10px;
	font-size: 20px;
}

.description {
	margin-top: 40px;
}

.description h2 {
	font-size: 24px;
	margin-bottom: 10px;
}

.related-products {
	margin-top: 40px;
}

.related-products h2 {
	font-size: 24px;
	margin-bottom: 20px;
}

.related-products .product-list {
	display: flex;
	gap: 20px;
}

.related-products .product-list .item {
	text-align: center;
	flex: 1;
}

.related-products .product-list .item img {
	width: 100%;
	border-radius: 8px;
	margin-bottom: 10px;
}

.art-container .BaseButton {
	text-decoration: none;
	display: inline-block;
	width: 130px; /* 버튼의 고정 너비 설정 */
	height: 40px; /* 버튼의 고정 높이 설정 */
	line-height: center; /* 버튼 내부 텍스트를 세로로 중앙 정렬 */
	text-align: center; /* 텍스트를 가로로 중앙 정렬 */
	background-color: #1f3269 !important;
	color: #fff;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: 14px;
}

.art-container .BaseButton:hover {
	background-color: #1a2561;
}

.image-section {
	background-color: #f9f9f9;
	display: flex; /* Flexbox 활성화 */
	align-items: center; /* 세로 정렬 (중앙 정렬) */
	justify-content: center; /* 가로 정렬 (필요 시 조정 가능) */
	gap: 10px; /* 자식 요소 간 간격 설정 */
	/* background-color:#f9f9f9 !important; */
}

body {
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
	<section class="pt-5">
		<div class="container">
			<div class="row gutter-4 justify-content-between">
				<!-- content -->
				<div class="col-lg-12">
					<div class="row">
						<div class="col">
							<div class="tab-content" id="myTabContent">

								<!-- 작품 정보 섹션 -->
								<input type="hidden" id="art_id" name="art_id" value="${art_id}">

								<div id="artContainer" class="art-container rounded shadow">
									<div class="main-info">

										<div class="image-section col-lg-9"
											style="background-color: f8f8f8 !important;">
											<div>
												<!-- 이미지 표시 영역 -->
												<button id="prevButton" class="image-nav-button"
													style="border: 0px; background-color: #f9f9f9"
													onclick="changeImage(-1)">
													<i class="bi bi-caret-left-fill" style="color: #6d6363d6;"></i>
												</button>
											</div>
											<div>
												<img id="artImage" src="${artsDTO.art_thumbnail_image}"
													alt="Artwork" />
											</div>
											<div>
												<button id="nextButton" class="image-nav-button"
													style="border: 0px; background-color: #f9f9f9;"
													onclick="changeImage(+1)">
													<i class="bi bi-caret-right-fill" style="color: #6d6363d6;"></i>
												</button>
											</div>

										</div>

										<div class="details-section col-lg-3">
											<div class="artist-info" style="font-weight: bold;">
												<p class="d-flex justify-content-between align-items-center"
													style="margin: 0;">
													${member_name}<span id="artistName"></span>
													<!-- 하트 이모티콘 -->
													<a class="text-danger like-icon" data-member-id="${userId}"
														data-art-id="${artsDTO.art_id}"> <i
														class="bi bi-heart" style="font-size: 1.4rem;"></i>
													</a>
												</p>
												<h1 id="artTitle" style="font-weight: bold;">${artsDTO.art_title }</h1>

											</div>

											<div class="howMuch" style="font-weight: bold;">
												<p>
													<strong><span id="artPrice">${artsDTO.art_price}</span></strong>
												</p>
											</div>
											<hr style="border: 0.5px solid #00000058;">
											<div class="info">
												<p>
													카테고리&emsp; <strong><span id="artCategory">
															${categoryDTO.category_type}</span> / <span id="artMiniCategory">${minicategoryDTO.mini_category_type}</span></strong>
												</p>
												<p>
													크기&nbsp;&emsp;&emsp;&emsp;<strong>${artsDTO.art_size}</strong>
													<span id="artDimensions"></span>
												</p>
												<P>
													등록일&emsp;&emsp; <strong><span id="artView">
															${fn:substring(artsDTO.art_post_date, 0, 10)}</span></strong>
												</P>

											</div>

											<div class="actions">
												<c:choose>
													<c:when test="${owner == 'true'}">
														<a href="<c:url value='/art/${art_id}/update' />"
															type="button" class="BaseButton"
															style="background-color: #1f3269 !important;">수정</a>
														<a onclick="artdelete()" type="button" class="BaseButton"
															style="background-color: #1f3269 !important; color: #fff !important;">삭제</a>
													</c:when>

													<c:otherwise>
														<c:if
															test="${artsDTO.art_status == '결제완료' or artsDTO.art_status == '배송중' or artsDTO.art_status == '판매완료'}">
															<p>이미 판매된 상품입니다.</p>
														</c:if>
														<c:if
															test="${artsDTO.art_status != '결제완료' and artsDTO.art_status != '배송중' and artsDTO.art_status != '판매완료'}">
															<a type="button" class="BaseButton"
																onclick="createChat(${artsDTO.art_id})"
																style="background-color: #1f3269 !important; color: white;">1:1채팅</a>
															<a class="cartAdd BaseButton" type="button"
																data-member-id="${userId}"
																data-art-id="${artsDTO.art_id}"
																style="background-color: #1f3269 !important; color: white;">장바구니
																담기</a>
														</c:if>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
									<!-- 작품 설명 -->
									<hr style="border: 0.5px solid #00000058;">



									<div class="row d-flex justify-content-between">
										<!-- 작품 상세정보 (9) -->
										<div class="col-lg-8">
											<div class="description">
												<h2 style="font-weight: bold;">작품 상세정보</h2>
												<p>${artsDTO.art_description}</p>
											</div>
										</div>

										<!-- 구매 안내 (3) -->
										<div class="col-lg-3">
											<div class="purchase-info">
												<h4 style="font-weight: bold; margin-top: 30px;">
													구매 안내
													</h2>
													<ul>
														<li>- 배송비는 무료입니다.</li>
														<li>- 구매 후 교환/환불이 불가능합니다.</li>
														<li>- 작품 배송은 5-7일이 소요됩니다.</li>
													</ul>
											</div>
										</div>
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
	// 판매자와 채팅 버튼 클릭시 채팅방 생성
	function createChat(art_id) {
		 fetch(`${path}/chatRest/createRoom`, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({ art_id : art_id })
	        })
	        .then(response => response.json())
		    .then(data => {
		    	window.open(`${path}/chatRoom`, "popupWindow", "width=1200, height=700, left=230, top=160, toolbar=no, scrollbars=yes, resizable=yes");
    		});
	}
	
 function artdelete(art_id){
	    var returnValue = confirm('정말 삭제하시겠습니까?');
	    
	    if (!returnValue) {
	        return;  // 삭제 요청 실행 안 함
	    }

	    // 삭제 요청 URL에 art_id를 동적으로 추가
		
	    const url = `<c:url value="/art/delete/${art_id}" />`;

	    fetch(url, {
	        method: 'PUT',
	        headers: {
	            'Content-Type': 'application/json',
	        }
	    })
	    .then((response) => response.json()) // 상태 코드와 상관없이 JSON 파싱
	    .then((data) => {
	       

	        if (data.status === 'success') {
	            alert('작품 삭제가 완료되었습니다.');
	            // 페이지를 새로 고침하거나 다른 화면으로 이동
	            window.location.href = '${path}/main';  //메인 페이지 보내기
	        } else {
	            alert('삭제에 실패했습니다. 다시 시도해주세요.');
	        }
	    })
	    .catch((error) => {
	        console.error('에러 발생:', error);
	        alert('문제가 발생했습니다. 다시 시도해주세요.');
	    });

	}

</script>
	<script>
	
    // 이미지 리스트 설정
    const imageList = [
    	"${artsDTO.art_thumbnail_image}",
        "${artsDTO.art_image2}",
        "${artsDTO.art_image3}",
        "${artsDTO.art_image4}",
        "${artsDTO.art_image5}"
    ].filter(image => image && image.trim() !== "");
    let currentImageIndex = 0;

    // 이미지 변경 함수
    function changeImage(direction) {
        const artImage = document.getElementById("artImage");

        // 현재 이미지 인덱스 변경 (순환하도록 처리)
        currentImageIndex = (currentImageIndex + direction + imageList.length) % imageList.length;

        // 이미지 src 업데이트
        artImage.src = imageList[currentImageIndex];
    }
</script>
	<script>
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
	                    loadCartItems(); // 카트 데이터 재로드
	                    updateCartItemCount(); // 카트 개수 업데이트
	                	alert(data.message || '장바구니에 담겼습니다.');
	                   
	                } else {
	                	alert('이미 담은 상품입니다.');
	                }
	            })
	            .catch(error => console.error('Error:', error));
	    });
	});
</script>
	<script>
// 카트 데이터 로드 함수
function loadCartItems() {
    const cartItemsContainer = document.getElementById('cartItemsContainer');
    const template = document.getElementById('cartItemTemplate').innerHTML;

    cartItemsContainer.innerHTML = ''; // 기존 내용을 초기화

    fetch('${path}/cart/cartmodal', { method: 'GET' })
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
//카트 개수 업데이트 함수
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
</script>
	<script>
	document.addEventListener('DOMContentLoaded', function() {
		
	    // 좋아요 상태 확인
	    document.querySelectorAll('.like-icon').forEach(icon => {
	        const memberId = icon.dataset.memberId;
	        const artId = icon.dataset.artId;
	        const heartIcon = icon.querySelector('i');
			console.log(artId);
			console.log(memberId);
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
	</script>
</body>
</html>
