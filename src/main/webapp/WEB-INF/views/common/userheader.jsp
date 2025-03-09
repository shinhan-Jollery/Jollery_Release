<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet"
	href="<c:url value='/resources/booking/css/style.css' />" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
	rel="stylesheet">

<style>
</style>
</head>

<body>


	<!-- 로그인후 header -->
	<header class="header header-sticky"
		style="background-color: #5f5454e8;">
		<div class="container">
			<div class="row">
				<nav class="navbar navbar-expand-lg navbar-dark">

					<a href="${path}/main" class="navbar-brand order-1 order-lg-2"
						style="font-size: 1.9rem; font-weight: bold;">JOLLERY</a>

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
								class="nav-link dropdown-bs-toggle" href="#!"
								id="navbarDropdown-4" role="button" data-bs-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false">CATEGORIES</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdown-4">
									<div class="row">
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">회화</span></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=101">동양화</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=102">서양화</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=103">판화</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=104">혼합(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">조소</span></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=201">석재</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=202">목재</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=203">금속</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=204">3D프린팅</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=205">혼합재료(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">공예</span></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=301">도예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=302">유리공예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=303">금속공예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=304">목공예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=305">혼합재료(기타)</a></li>
										</ul>
										<ul class="col-6 col-md-3 col-lg-2">
											<li><span class="megamenu-title">기타</span></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=401">사진</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=402">설치미술</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=403">서예</a></li>
											<li><a class="dropdown-item"
												href="${path}/artSearch/list?minicategoryId=404">실험예술(기타)</a></li>
										</ul>
										<div class="col-lg-4" style="border-radius:15px;">
											<div class="promo" >
												<span class="image image-overlay"
													style="background-image: url(resources/assets/images/michael.jpg) !important; border-radius:5px;"></span>
												
											</div>
										</div>
									</div>
								</div></li>
							<!-- 검색창 추가 -->
							<form class="search-bar" action="${path}/artSearch/search"
								method="GET" style="margin-left: 45px; height: 33px;">
								<div class="search-container">
									<i class="icon-search"></i> <input type="text" name="query"
										placeholder="제목,&nbsp작가이름 검색" />
								</div>

							</form>
						</ul>
					</div>

					<!-- 회원 정보, 로그아웃, 관심상품, 장바구니 -->
					<div class="collapse navbar-collapse order-4 order-lg-3"
						id="navbarMenu2">
						<ul class="navbar-nav ml-auto">
							<!-- 회원 정보 드롭다운 -->
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-bs-toggle" href="#!" id="userDropdown"
								role="button" data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false"> ${memberName}</a> <c:choose>

									<c:when test="${isArtist == '1'}">
										<div class="dropdown-menu dropdown-menu-right"
											aria-labelledby="userDropdown">
											<a class="dropdown-item" href="${path}/auth/infoUpdate">회원정보</a>
											<br> <a class="dropdown-item" href="${path}/order/list">주문내역</a>
											<br> <a class="dropdown-item" href="${path}/like">관심상품</a>
											<br> <a class="dropdown-item" href="${path}/art/insert">작품등록</a>
											<br> <a class="dropdown-item" href="${path}/sale/list">판매내역</a>
											<br> <a class="dropdown-item"
												href="${path}/auth/account">정산</a>
										</div>
									</c:when>

									<c:otherwise>
										<div class="dropdown-menu dropdown-menu-right"
											aria-labelledby="userDropdown">
											<a class="dropdown-item" href="${path}/auth/infoUpdate">회원정보</a>
											<br> <a class="dropdown-item" href="${path}/order/list">주문내역</a>
											<br> <a class="dropdown-item" href="${path}/like">관심상품</a>
											<br> <a class="dropdown-item"
												href="${path}/auth/certify">판매자 인증</a>
										</div>
									</c:otherwise>
								</c:choose></li>
							<!-- 로그아웃 버튼 -->

							<li class="nav-item"><a class="nav-link"
								href="javascript:logout()">로그아웃</a></li>
							</li>
							<!-- 관심상품 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/like"><i class="icon-heart"></i></a></li>
							<!-- 장바구니 -->
							<li class="nav-item cart"><a data-toggle="modal"
								data-target="#cart" class="nav-link"> <span>Cart</span> <span
									id="cartItemCount">0</span>
							</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</header>
	<!-- Cart Modal -->
	<div class="modal fade sidebar" id="cart" tabindex="-1" role="dialog"
		aria-labelledby="cartLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="cartLabel">장바구니</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 카트 아이템이 동적으로 삽입될 공간 -->
					<div id="cartItemsContainer" class="row gutter-3">
						<!-- Items will be loaded here dynamically -->
					</div>
				</div>
				<div class="modal-footer">
					<div class="container-fluid">
						<div class="row gutter-0">
							<div class="col d-none d-md-block">
								<a href="${path}/cart/cartlist"
									class="btn btn-lg btn-block btn-secondary">장바구니 보기</a>
							</div>
							<div class="col">

								<a href="${path}/order/orderpage"

									class="btn btn-lg btn-block text-white"
									style="background-color: #1f3269">주문하기</a>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- HTML 템플릿 -->
	<script type="text/template" id="cartItemTemplate">
    <div class="col-12">
        <div class="cart-item cart-item-sm">
            <div class="row align-items-center">
                <div class="col-lg-9">
                    <div class="media media-product">
                        
                            <img src="{art_thumbnail_image}" alt="Image">
                      
                        <div class="media-body">
                            <h5 class="media-title">{art_title}</h5>
                            <span class="media-subtitle">{category_type} / {mini_category_type}</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 text-center text-lg-right">
                    <span class="cart-item-price">{price}원</span>
                </div>
                <a class="cart-item-close" onclick="deleteCart('{artid}')">
                    <i class="icon-x"></i>
                </a>
            </div>
        </div>
    </div>
</script>



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
    
    function logout() {
        fetch("<c:url value='/auth/logout'/>", { method: 'POST' })
            .then(response => {
                if (response.ok) {
                    // 로그아웃 성공 시 메인 페이지로 리다이렉트
                    
                    window.location.href = "${path}/main";
                } else {
                    alert('로그아웃 실패');
                }
            })
            .catch(error => console.error('Error:', error));
    }
    
    document.addEventListener('DOMContentLoaded', function () {
        // 페이지가 로드될 때 카트 개수 및 데이터를 업데이트
        updateCartItemCount();

        // 모달이 열릴 때 카트 데이터 로드
        $('#cart').on('show.bs.modal', function () {
        	loadCartItems();
        });

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

        // 카트 아이템 삭제 함수
        window.deleteCart = function (artid) {
        	
            $.ajax({
                url: '${path}/cart/delete/' + artid, // RESTful DELETE URL
                type: 'DELETE',
                success: function (response) {
                	
                   
                    loadCartItems(); // 카트 데이터 재로드
                    updateCartItemCount(); // 카트 개수 업데이트
                },
                error: function (xhr, status, error) {
                	
                    alert("삭제 실패: " + error); // 삭제 실패 시 알림
                    console.error("Error details:", xhr, status, error); // 추가 디버깅 정보 출력
                }
            });
        };
    });
   

</script>

</body>
</html>
