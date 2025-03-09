<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Jollery</title>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<style>

/* 전체 페이지 스타일 */
body {
	background-color: #757c7f0a !important; /* 배경색 설정 */
}

main {
	margin-top: 150px;
	margin-bottom: 150px;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: calc(100vh - 10rem); /* 화면 높이에서 푸터 높이 제외 */
}

/* 주문 페이지 섹션 */
.order-section {
	height: 680px;
	width: 1300px;
	display: flex;
	justify-content: space-between;
	gap: 20px;
	margin-top: 90px;
	margin-left: 300px;
}

/* 주문 폼 스타일 */
.order-form {
	flex: 1;
	height: 580px;
	background: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

/* 주문 요약 스타일 */
.order-summary {
	width: 485px !important;
	padding: 20px;
	border-radius: 5px;
	border: 2px solid #d4cce1e8;
	margin-left: 15px;
	background: #f0f2f5d6;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

/* 폼 요소 스타일 */
h4 {
	margin-bottom: 3px;
}

.form-group {
	margin-bottom: 5px;
}

/* 입력 필드 기본 스타일 */
.form-group input, .form-group select, .form-group textarea {
	width: calc(100% - 10px);
	padding: 10px;
	border-radius: 3px;
	border: 1px solid #ddd;
	margin-bottom: 5px;
}

.form-group textarea {
	resize: none; /* 텍스트 영역 크기 조정 비활성화 */
}

.form-group label {
	display: block;
	font-weight: bold; /* 라벨 텍스트 굵게 */
}

/* 전화번호 입력 행 스타일 */
.phone-row {
	display: flex;
	gap: 10px;
	align-items: center;
}

.phone-row select, .phone-row input {
	height: 38px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.phone-row select {
	width: 90px !important; /* 드롭다운 너비 고정 */
}

.phone-row input {
	width: 120px !important;
}

/* 주소 입력 행 스타일 */
.address-row {
	display: flex;
	align-items: center;
	gap: 10px;
}

.address-row input[type="text"] {
	flex: 1;
	font-size: 14px;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	margin-bottom: 10px;
}

.address-row button {
	padding: 8px 12px;
	font-size: 14px;
	background-color: #2A4491 !important;
	color: #fff;
	cursor: pointer;
	border-radius: 4px;
	border: 1px solid #ccc;
	margin-left: 10px;
	margin-bottom: 10px;
}

/* 주문 요약 항목 스타일 */
.summary-item {
	display: flex;
	justify-content: space-between;
	margin-bottom: 15px;
}

.summary-total {
	font-weight: bold;
	color: #007BFF !important; /* 총합 항목 강조 */
}

/* 제출 버튼 스타일 */
.btn-submit {
	width: 100%;
	padding: 10px;
	background-color: #2A4491;
	color: #fff;
	text-align: center;
	border-radius: 3px;
	text-decoration: none;
}

button:hover {
	background-color: #3f91b9 !important; /* 버튼 호버 시 배경색 변경 */
}

/* 추가 입력 필드 스타일 */
input[type="text"] {
	width: 100%;
	padding: 8px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="text"]:focus {
	border-color: #007bff; /* 포커스 시 파란색 테두리 */
}

/* 라디오 버튼 그룹 스타일 */
.radio-group {
	display: flex;
	gap: 20px;
	align-items: center;
	margin-bottom: 10px;
}

.radio-group label {
	display: flex;
	align-items: center;
	font-size: 14px;
}

/* 테이블 컨테이너 스타일 */
.table-container {
	width: 450px;
	height: 340px;
	overflow-y: auto; /* 세로 스크롤 활성화 */
	border-radius: 5px;
}

.table-container table {
	height: 200px;
	border-collapse: collapse;
}

.table-container table td {
	padding: 8px;
	text-align: left;
}


</style>
</head>
<body>

	<!-- header -->
	<header>
		<c:choose>
			<c:when test="${not empty userId}">
				<%@ include file="/WEB-INF/views/common/userheader.jsp"%>
			</c:when>
			<c:otherwise>
				<%@ include file="/WEB-INF/views/common/guestheader.jsp"%>
			</c:otherwise>
		</c:choose>
	</header>

	<div id="wrap">
		<main>
			<!-- 주문 페이지 -->
			<div class="order-section">

				<!-- 주문 정보 입력 -->
				<div class="order-form">
					<h4>주문자 정보</h4>
					<!-- 이메일 입력 -->
					<div class="form-group">
						<label for="customer-email">이메일</label>
						<div style="display: flex; align-items: center; gap: 10px;">
							<input type="text" id="email-prefix" name="email-prefix"
								value="${membersDTO.member_email}"
								style="flex-grow: 1; height: 40px;">
						</div>
						<!-- 직접 입력 필드 -->
						<input type="text" id="custom-email-domain"
							name="custom-email-domain" placeholder="직접 입력"
							style="margin-top: 10px; display: none;">
						<hr>
						<script>
						document
								.getElementById("custom-email-domain")
								.addEventListener(
										"",
										function() {
											const customField = document
													.getElementById("custom-email-domain");
											if (this.value === "custom") {
												customField.style.display = "block";
											} else {
												customField.style.display = "none";
											}
										});
					</script>
					</div>

					<!-- 배송지 정보 -->
					<h4>배송지 정보</h4>
					<div class="radio-group">
						<label> <input type="radio" name="address-option"
							value="same" checked> 최근 배송지
						</label> <label> <input type="radio" name="address-option"
							value="new"> 새로운 배송지
						</label>
					</div>
					<div id="address-form">
						<!-- 받으시는 분 -->
						<div class="form-group">
							<label for="recipient-name">받으시는 분 *</label> <input type="text"
								id="recipient-name" name="recipient-name"
								value="${membersDTO.member_name}">
						</div>

						<!-- 주소 -->
						<div class="form-group">
							<label for="address-line1">주소 *</label>
							<div class="address-row">
								<input type="text" id="address-line1" name="address-line1"
									value="${membersDTO.member_address}"
									style="width: 530px !important">
								<button type="button" onclick="execDaumPostcode()">우편번호
									검색</button>
							</div>
							<input type="text" id="address-line2" name="address-line2"
								value="${membersDTO.member_address_detail}" style="width: 530px">
						</div>

						<!-- 연락처 -->
						<div class="phone-row">
							<select id="phone-part1" name="phone-part1">
								<option value="010" selected>${part1}</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="019">019</option>
							</select> - <input value="${part2}" type="text" id="phone-part2"
								name="phone-part2"> - <input value="${part3}"
								type="text" id="phone-part3" name="phone-part3">
						</div>

						<!-- 배송 메시지 -->
						<div class="form-group">
							<label for="delivery-message">배송 메시지</label>
							<textarea id="delivery-message" name="delivery-message">${deliveryMessage}</textarea>
						</div>
					</div>

				</div>

				<script>
			document.addEventListener("DOMContentLoaded", function () {
				  const recipientNameField = document.getElementById("recipient-name");
				  const addressLine1Field = document.getElementById("address-line1");
				  const addressLine2Field = document.getElementById("address-line2");
				  const phonePart1Field = document.getElementById("phone-part1");
				  const phonePart2Field = document.getElementById("phone-part2");
				  const phonePart3Field = document.getElementById("phone-part3");
				  const deliveryMessageField = document.getElementById("delivery-message");
			      const phoneNumber = "${membersDTO.member_phone}"; // 예: "010-3123-1312"
			      const [part1, part2, part3] = phoneNumber.split('-');
				  // 라디오 버튼 이벤트 리스너 추가
				  setReadOnly(true);
				  document.querySelectorAll('input[name="address-option"]').forEach(radio => {
				    radio.addEventListener("change", function () {
				      if (this.value === "same") {
				    	  console.log("정상작동됨")
				        // 최근 배송지를 선택한 경우: 필드 값 설정 및 읽기 전용 처리


				        recipientNameField.value = "${membersDTO.member_name}";
				        addressLine1Field.value = "${membersDTO.member_address}";
				        addressLine2Field.value = "${membersDTO.member_address_detail}";
				        phonePart1Field.value = part1;
				        phonePart2Field.value = part2;
				        phonePart3Field.value = part3;
				        deliveryMessageField.value = "${deliveryMessage}";

				        // 읽기 전용 설정
				        setReadOnly(true);
				      } else if (this.value === "new") {
				        // 새로운 배송지를 선택한 경우: 필드 값 초기화 및 읽기 가능 처리
				        recipientNameField.value = "";
				        addressLine1Field.value = "";
				        addressLine2Field.value = "";
				        phonePart1Field.value = "010"; // 기본값 설정
				        phonePart2Field.value = "";
				        phonePart3Field.value = "";
				        deliveryMessageField.value = "";

				        // 읽기 가능 설정
				        setReadOnly(false);
				      }
				    });
				  });

				  // 읽기 전용 상태를 설정하는 함수
				  function setReadOnly(isReadOnly) {
				    recipientNameField.readOnly = isReadOnly;
				    addressLine1Field.readOnly = isReadOnly;
				    addressLine2Field.readOnly = isReadOnly;
				    phonePart2Field.readOnly = isReadOnly;
				    phonePart3Field.readOnly = isReadOnly;
				    // select 요소는 disabled로 처리
				    phonePart1Field.disabled = isReadOnly;
				  }
				});
</script>

				<!-- 주문 요약 -->
				<div class="order-summary">
					<h2>
						<font style="font-size: 28px;">주문상품 정보</font>
					</h2>
					<hr>
					<!-- 상품 목록 -->
					<div class="table-container">
						<table>
							<tbody>
								<c:forEach items="${cartItems}" var="item">


									<tr>
										<td><div class="summary-item product-image"
												style="display: flex; align-items: center; gap: 15px;">
												<img src="${item.art_thumbnail_image}" alt="상품 이미지"
													style="width: 90px; height: 80px; border-radius: 5px; border: 1px solid #ddd;">
											</div></td>
										<td><span style="font-weight: bold; font-size: 16px;">&nbsp${item.art_title}</span><br>
											<span style="font-size: 14px;">&nbsp${item.category_type}
												/ ${item.mini_category_type}</span></td>
										<td><span id="artPrice"
											style="font-size: 15px; font-weight: bold;">${item.art_price}</span>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 금액 요약 -->
					<hr>
					<div class="summary-item">
						총 주문금액 <span id="artPrice">${totalPrice}원</span>
					</div>
					<div class="summary-item">
						배송비 <span>Free</span>
					</div>
					<hr />
					<div class="summary-item summary-total">
						총 결제예정 금액 <span id="artPrice">${totalPrice}원</span>
					</div>

					<!-- 결제 버튼 -->
					<button id="open-popup" class="btn-submit">결제하기</button>
				</div>

			</div>
		</main>
	</div>

</body>

<!-- footer -->
<%@ include file="/WEB-INF/views/common/footer.jsp"%>

<script>
	//상품 선택한 것도 받아와야됨
	document.getElementById("open-popup").addEventListener("click", function () {
	    const popupWidth = Math.min(window.innerWidth * 0.8, 1500);
	    const popupHeight = Math.min(window.innerHeight * 0.8, 1500);
	    const left = window.screenX + (window.innerWidth - popupWidth) / 2;
	    const top = window.screenY + (window.innerHeight - popupHeight) / 2;
		const member_id = "${userId}";
		const memberName = "${memberName}";
	    const amount = "${totalPrice}"; // 예: 결제 금액
	    const deliveryMessageValue  = document.getElementById("delivery-message").value;
	    // URL에 매개변수를 추가
	      const url = `<c:url value='/resources/toss/checkout.jsp' />`;
	      sessionStorage.setItem("member_id", member_id);
	      sessionStorage.setItem("memberName", memberName);
	      sessionStorage.setItem("amount", amount);
	      sessionStorage.setItem("deliveryMessage", deliveryMessageValue);
	    const popup = window.open(
	    		url,
	        "결제 페이지",
	        `width=popupWidth,height=popupHeight,top=${top},left=left,resizable=yes`
	    );

	    const popupCheckInterval = setInterval(() => {
	        if (popup.closed) {
	          clearInterval(popupCheckInterval); // 감지 중지
	          console.log("팝업이 닫혔습니다.");

	          // localStorage에서 paymentStatus 확인
	          const paymentStatus = localStorage.getItem("paymentStatus");
	          if (paymentStatus === "success") {
	            console.log("결제 성공!");
	            localStorage.setItem("paymentStatus", null);
	            window.location.href = "<c:url value="/order/list" />"; // 원하는 URL로 이동
	          } else {
	            alert("결제 실패 또는 취소되었습니다.");
	          }
	        }
	      }, 500); 
	    }
	);

</script>
<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
<script src="<c:url value='/resources/assets/js/app.js' />"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        var width = 500; // 팝업의 너비
        var height = 600; // 팝업의 높이

        new daum.Postcode({
            oncomplete: function(data) {
                // 도로명 주소와 지번 주소 가져오기
                const roadAddr = data.roadAddress; // 도로명 주소
                const jibunAddr = data.jibunAddress; // 지번 주소
                const zoneCode = data.zonecode;
                
                // 도로명 주소 또는 지번 주소를 address-line1에 설정
                const fullAddress = [zoneCode, roadAddr || jibunAddr].filter(Boolean).join(" ");
                document.getElementById('address-line1').value = fullAddress;

                // 상세 주소 입력 필드로 포커스 이동
                document.getElementById('address-line2').focus();
            }
        }).open({
            left: (window.screen.width / 2) - (width / 2),
            top: (window.screen.height / 2) - (height / 2)
        });
    }
    
</script>



</html>
