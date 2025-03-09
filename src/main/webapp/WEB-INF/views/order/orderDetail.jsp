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


<title>Jollery</title>
    <style>
    
        body {
            font-family: Arial, sans-serif;
            background-color: #757c7f0a;
            margin: 0;
            padding: 0;
        } 

        .section {
            margin-bottom: 20px;
        }

        .section-header {
        	background-color: #a2abb99e;
       		//background-color: #f9f9f9;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }

        .product-list {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
        }

        .product-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .product-item:last-child {
            border-bottom: none;
        }

        .product-image {
            width: 80px;
            height: 80px;
            margin-right: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .product-details {
            flex-grow: 1;
        }

        .product-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .product-price {
            font-size: 14px;
            color: #888;
        }

        .order-info,
        .payment-info {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }

        .info-row:last-child {
            margin-bottom: 0;
        }

        .info-label {
            font-weight: bold;
            color: #555;
        }

        .info-value {
            color: #333;
        }

        .total-price {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-align: right;
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
	<section class="hero hero-small bg-white text-white py-5"></section> 

	<!-- listing -->
	<section class="pt-5">
		<div class="container">
			<div class="row gutter-4 justify-content-between">

				<!--  sidebar -->
				<c:choose>
					<c:when test="${Integer.parseInt(isArtist) == 1}">
						<%@ include file="/WEB-INF/views/common/sellersidebar.jsp"%>
					</c:when>
					<c:otherwise>
						<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
					</c:otherwise>
				</c:choose>
				<!-- / sidebar -->

 



                <!-- Content -->
                <div class="col-lg-9">
                    <div class="tab-content">
                        <!-- Order Details -->
                        <div class="container">
                            <!-- Order Information -->
                            <div class="section">
                                <h4>주문 내역</h4>
                                <!-- Order details to be dynamically inserted -->
                            </div>
                            <!-- <div class="section" style="background-color:#b7d0dfdb"> 주문날짜(주문번호)</div> -->
                            <c:set var="orderDate" value="${orderDetails[0]}" />
                            <div class="section" style="background-color:#b7d0dfdb; padding: 13px; font-size: 18px; font-weight: bold; ">
    						${orderDate.order_date} (주문번호 - J10000123${orderDate.order_ID}) 
							</div>
                            
                            
                            <!-- Product Information -->
                            <div class="section">
                                <div class="section-header">상품 정보</div>
                                <div class="product-list">
                                    <c:forEach var="product" items="${orderDetails}">
                                        <div class="product-item">
                                            <img src="${product.art_thumbnail_image}" alt="상품 이미지" class="product-image">
                                            <div class="product-details">
                                                <div class="product-title">${product.art_title}</div>
                                                <div class="product-category">${product.category_type} / ${product.mini_category_type}</div>
                                                <div class="product-price" id="artPrice">${product.art_price} ₩</div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            
                            

                            <!-- Shipping Information -->
                            <div class="section">
                                <div class="section-header">배송 정보</div>
                                 <div class="order-info">
                                    <c:set var="orderInfo" value="${orderDetails[0]}" />
                                    <div class="info-row">
                                        <span class="info-label">받는 사람:</span>
                                        <span class="info-value">${orderInfo.member_name}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">연락처:</span>
                                        <span class="info-value">${orderInfo.member_phone}</span>
                                    </div>
                                   
                                    <div class="info-row">
                                        <span class="info-label">주소:</span>
                                        <span class="info-value">${orderInfo.member_address}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">상세 주소:</span>
                                        <span class="info-value">${orderInfo.member_address_detail}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">배송 메시지:</span>
                                        <span class="info-value">${orderInfo.order_request}</span>
                                    </div>
                            </div>
                            </div>
                            

                            <!-- Payment Information -->
                            <div class="section">
                                <div class="section-header">결제 정보</div>
                                <div class="payment-info">
                                    <div class="info-row">
                                        <span class="info-label">결제 수단:</span>
                                        <span class="info-value">${orderInfo.order_paymentMethod}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">총 상품 금액:</span>
                                        <span class="info-value" id="artPrice">${totalPrice}</span>
                                    </div>
                                    <div class="info-row">
                                        <span class="info-label">배송비:</span>
                                        <span class="info-value">무료</span>
                                    </div>
                                    <hr>
                                    <div class="total-price">총 결제 금액: <span id="artPrice">${totalPrice}</span></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

</section>



	<!-- footer -->
	<footer>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</footer>


	<!-- search -->
	<div class="modal fade search" id="search" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<input type="text" class="form-control"
						placeholder="Type your search here"
						aria-label="Type your search here"
						aria-describedby="button-addon2">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
		</div>
	</div>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>

</body>
</html>
