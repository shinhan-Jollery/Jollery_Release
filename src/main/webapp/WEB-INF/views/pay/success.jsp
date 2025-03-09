<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<link rel="icon"
	href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/toss/css/style.css' />" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Jollery</title>
</head>

<body>
	<div class="box_section"
		style="max-width: 600px; margin: 0 auto; text-align: center;">
		<img width="100px"
			src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png"
			alt="결제 완료" />
		<h2>결제를 완료했어요</h2>

		<div class="p-grid typography--p"
			style="margin-top: 50px; display: flex; justify-content: space-between;">
			<div class="p-grid-col text--left">
				<b>결제금액</b>
			</div>
			<div class="p-grid-col text--right" id="amount">--</div>
		</div>

		<div class="p-grid typography--p"
			style="margin-top: 10px; display: flex; justify-content: space-between;">
			<div class="p-grid-col text--left">
				<b>주문번호</b>
			</div>
			<div class="p-grid-col text--right" id="orderId">--</div>
		</div>


		<div class="p-grid" style="margin-top: 30px;">
			<button class="button p-grid-col5"
				style="padding: 10px 20px; font-size: 16px; cursor: pointer;"
				onclick="window.close(); return true;">주문 내역</button>
		</div>
	</div>

<script>
  // sessionStorage에서 데이터 가져오기
  document.addEventListener('DOMContentLoaded', () => {
    const tossamount = sessionStorage.getItem('amount'); // 결제 금액
    const tossorderId = sessionStorage.getItem('orderId'); // 주문 번호
    const payment = sessionStorage.getItem("paymentMethod");
    const formattedAmount = Number(tossamount).toLocaleString('ko-KR') + ' 원';
    document.getElementById('amount').textContent = formattedAmount;
    document.getElementById('orderId').textContent = tossorderId;
  });
</script>
	<script>
	document.addEventListener("DOMContentLoaded", async function () {
		//부모창 이동용
		localStorage.setItem("paymentStatus", "success");
	    const paymentMethod = sessionStorage.getItem("paymentMethod");
	    const amount = sessionStorage.getItem("amount");
	    const memberName = sessionStorage.getItem("memberName");
	    const member_id = sessionStorage.getItem("member_id");
	    const deliveryMessage = sessionStorage.getItem("deliveryMessage");

	    // JSON 데이터 생성
	    const bodydata = {
	        paymentMethod: paymentMethod.code || null, // paymentMethod가 객체라면 code 속성 참조
	        orderId: "order12345", // 예시로 고정값 사용 (필요에 따라 동적으로 설정)
	        memberName: memberName,
	        amount: amount,
	        member_id: member_id,
	        deliveryMessage: deliveryMessage,
	    };
	});
	</script>
</body>
</html>