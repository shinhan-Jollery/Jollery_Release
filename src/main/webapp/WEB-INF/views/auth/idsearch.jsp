<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />

<meta charset="UTF-8">
<title>Jollery</title>
<style>
/* 전체 페이지 스타일 */
body {
	font-family: Arial, sans-serif;
	background-color: #757c7f0a !important;
	margin: 0;
	padding: 0;
}

main {
	margin-top: 50px;
	margin-bottom: 180px;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 80vh;
}

h3 {
	text-align: center !important;
	margin-bottom: 20px;
	font-size: 24px;
	color: #34495e;
}

form {
	display: flex;
	flex-direction: column;
}

.form-group label {
	font-size: 14px;
	margin-bottom: 5px;
	color: #34495e;
}

.form-group input {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border-radius: 5px;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

.btn-submit {
	width: 100%;
	padding: 15px;
	background-color: #2a4491;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: background-color 0.3s;
}

.btn-submit:hover {
	background-color: #3f91b9;
}

.links {
	text-align: center;
	margin-top: 10px;
}

.links a {
	color: #2980b9;
	text-decoration: none;
	font-size: 14px;
	margin: 0 5px;
}

.links a:hover {
	text-decoration: underline;
}

.custom-divider {
	background-color: black;
	width: 2px;
	height: 80%;
	margin: auto;
}

.idSearch-container {
	margin-top: 200px;
	margin-bottom: 200px;
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



	<main>
		<section class="vh-xxl-100" style="height: 50vh;">
			<!-- 전체 크기를 50%로 줄임 -->
			<div
				class="container h-100 d-flex justify-content-center align-items-center">
				<div class="bg-mode shadow rounded-3  overflow-hidden w-100"
					style="max-width: 1100px;">
					<!-- 최대 너비를 약간 줄임 -->
					<div class="d-flex flex-row h-100" style="max-height: 640px;">
						<!-- Left: Image Section -->
						<div
							class="col-6 d-flex align-items-center justify-content-center p-4">
							<img src="${path}/resources/assets/images/login.jpg"
								alt="Sign-in Image" class="img-fluid">
						</div>

						<!-- Divider -->
						<div class="vr"
							style="background-color: black; width: 2px; height: 80%; margin: auto;"></div>

						<!-- Right: ID 찾기 Form -->
						<div
							class="col-6 d-flex align-items-center justify-content-center p-4">

							<div class="idSearch-container w-100" style="max-width: 400px;">
								<h3>아이디 찾기</h3>

								<form id="find-id-form">
									<!-- 이름 입력 -->
									<div class="form-group">
										<label for="membername">이름</label> <input type="text"
											id="membername" name="membername" placeholder="이름을 입력하세요"
											class="form-control" required>
									</div>

									<br>
									<!-- 이메일 입력 -->
									<div class="form-group">
										<label for="email" style="display: block; margin-bottom: 5px;">이메일</label>
										<div style="display: flex; align-items: center; gap: 10px;">
											<div
												style="display: flex; flex-grow: 1; align-items: center;">
												<input type="text" id="email-prefix" name="email-prefix"
													placeholder="Email" class="form-control"
													style="flex-grow: 1; border-radius: 5px; height: 53px; width: 150px;">
												<span style="margin: 0 5px;">@</span> <select
													id="email-domain" name="email-domain" class="form-control"
													style="border-radius: 5px; height: 53px; width: 115px;">
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="daum.net">daum.net</option>
													<option value="custom">직접 입력</option>
												</select>
											</div>
											<button class="btn-submit"
												style="height: 45px; width: 120px; font-size: 13px;"
												type="button" id="auth-button" onclick="sendMemberEmail()">이메일
												인증</button>
										</div>
										<input type="text" id="custom-email-domain"
											name="custom-email-domain" placeholder="직접 입력"
											style="margin-top: 5px; display: none; width: calc(100% - 160px);">
									</div>


									<hr>
									<!-- 인증번호 입력 -->
									<div class="form-group" style="display: none;" id="otp-section">
										<br> <input type="text" id="memberemail-otp-code"
											placeholder="인증번호 입력 (6자리)" maxlength="6"
											class="form-control" style="width: 240px; margin-left: 20px;">

										<button type="button" id="member-otp-submit-button"
											class="btn-submit"
											style="height: 45px; width: 110px; font-size: 13px; margin-left: 8px; margin-top: 3px;"
											onclick="submitMemberEmailOTP()">제출</button>
									</div>
									<br>
									<button type="button" id="member-otp-submit-button"
										class="btn-submit"
										style="height: 45px; width: 120px; font-size: 13px; margin-left: 8px; margin-top: 3px;"
										onclick="submitMemberEmailOTP()">제출</button>
							</div>
							<br>



							<!-- ID 찾기 버튼 -->
							<button type="submit" class="btn-submit" id="find-id-button">아이디
								찾기</button>

							<!-- 추가 링크 -->
							<div class="links mt-3">
								<a href="<c:url value='/auth/login' />">로그인 화면으로 돌아가기</a> | <a
									href="<c:url value='/auth/signup' />">회원가입</a>
							</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			</div>
		</section>
	</main>



	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js' />"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>

document.getElementById("email-domain").addEventListener("change", function() {
    const customField = document.getElementById("custom-email-domain");
    if (this.value === "custom") {
        customField.style.display = "block";
    } else {
        customField.style.display = "none";
    }
});

    // 이메일 인증 요청
    async function sendMemberEmail() {
    	const membername = document.getElementById("membername").value.trim();
        const emailPrefix = document.getElementById("email-prefix").value;
        const emailDomain = document.getElementById("email-domain").value;
        const customDomain = document.getElementById("custom-email-domain").value;

        const email = `\${emailPrefix}@\${customDomain}\${emailDomain}`;

        // JSON 변환
        const bodydata = {
        		membername,
        		email
        };
        const response = await fetch('${path}/auth/sendMemberEmailbyName', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(bodydata),
        });

        const result = await response.json();
        alert(result.message);
        console.log(result);
        console.log(result.status);
        

        if (result.status === "success") {

            // 인증번호 입력 필드 보이기
        	document.getElementById("otp-section").style.display = "block";

        }
    }

    // 인증 코드 제출
    async function submitMemberEmailOTP() {
    	const membername = document.getElementById("membername").value.trim();
        const emailPrefix = document.getElementById("email-prefix").value;
        const emailDomain = document.getElementById("email-domain").value;
        const customDomain = document.getElementById("custom-email-domain").value;

        const email = `\${emailPrefix}@\${customDomain}\${emailDomain}`;
        const code = document.getElementById("memberemail-otp-code").value;
        // JSON 변환
        const bodydata = {
        		membername,
        		email,
        		code
        };
        

        const response = await fetch('${path}/auth/verifyandSendId', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify( bodydata ),
        });
	
        const result = await response.json();
        alert(result.message);
        if (result.status === "success") {
                // 메인 페이지로 이동
                window.location.href = "${path}/main";

        }
    }
</script>
</body>

</html>