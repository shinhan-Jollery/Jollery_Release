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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
</head>
<style>
#email-otp-code {
	width: 200px;
}

body {
	font-family: Arial, sans-serif;
	background-color: #757c7f0a !important;
}

/* Main layout */
main {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 150px 0 50px; /* 헤더 높이와 하단 여백 */
	margin: 0;
}

.container-signup {
	margin-left: 500px;
	display: flex;
	justify-content: center;
	align-items: center;
	max-width: 800px;
	width: 50%;
	padding: 50px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
}

h2 {
	margin-bottom: 20px;
}

/* Buttons */
/*회원가입버튼 */
.btn-submit {
	display: block;
	width: calc(100% - 10px);
	height: 48px;
	padding: 10px;
	background-color: #2A4491;
	color: #fff;
	text-align: center;
	border-radius: 3px;
	text-decoration: none;
}

button:hover {
	background-color: #3f91b9;
}

/* Form Elements */
.form-group {
	margin-bottom: 30px; /* 입력 섹션 간의 간격 */
}

.form-group input, .form-group select, .form-group textarea {
	/* width: calc(100% - 10px); */
	height: 48px;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 3px;
	margin-bottom: 5px;
}

.form-group textarea {
	resize: none;
}

.form-group button:hover {
	background-color: #3f91b9;
}

input[type="text"]:focus {
	border-color: #007bff;
}

label {
	display: block;
	font-size: 14px;
	margin-bottom: 5px;
}

/* Phone Row */
.phone-row {
	margin-right: 150px;
	display: flex;
	gap: 10px; /* 각 요소 간격 */
	align-items: center; /* 수직 가운데 정렬 */
}

.id-row {
	margin-right: 150px;
	display: flex;
	gap: 10px; /* 각 요소 간격 */
	align-items: center; /* 수직 가운데 정렬 */
}

.phone-row select {
	width: 100px;
	height: 48px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.phone-row input {
	width: 110px;
	height: 48px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.phone-row button {
	margin-left: 15px;
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #2A4491;
	color: #fff;
	cursor: pointer;
	height: 48px;
	margin-bottom: 5px;
}

.email-row {
	margin-right: 150px;
	display: flex;
	gap: 10px; /* 각 요소 간격 */
	align-items: center; /* 수직 가운데 정렬 */
}

.email-row select {
	width: 80px;
	height: 48px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.email-row input {
	width: 120px;
	height: 48px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.email-row button {
	margin-left: 15px;
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #2A4491;
	color: #fff;
	cursor: pointer;
	height: 45px;
	margin-bottom: 5px;
}

/* OTP Row */
.otp-row {
	display: flex;
	margin-top: 10px;
	gap: 10px;
}
/* OTP Row */
.emailotp-row {
	display: flex;
	margin-top: 10px;
	gap: 10px;
}

.otp-row input {
	height: 38px;
	font-size: 14px;
	width: 200px;
	padding: 5px;
}

.otp-row button {
	height: 38px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #2A4491;
	color: #fff;
	font-size: 14px;
	padding: 5px 10px;
	border-radius: 3px;
	background-color: #2A4491;
	color: #fff;
}

/* Address Row */
.address-row {
	display: flex;
	align-items: center;
	gap: 10px;
}

.address-row input[type="text"] {
	flex: 1;
	padding: 8px;
	font-size: 14px;
	margin-bottom: 10px;
}

.address-row button {
	margin-left: 10px;
	padding: 8px 12px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #2A4491;
	color: #fff;
	cursor: pointer;
	margin-bottom: 10px;
	background-color: #2A4491;
	color: #fff;
}

/* Checkbox and Radio Buttons */
.checkbox-group, .radio-group {
	/* display: inline-block; */
	display: flex;
	margin-bottom: 5px;
	gap: 20px;
	align-items: center;
}

.checkbox-group label {
	font-size: 14px;
	white-space: nowrap;
}

.checkbox-group input[type="checkbox"] {
	margin-left: 10px;
	height: 16px;
}

input {
	width: 100%;
	height: 48px;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
	margin-bottom: 18px;
	transition: border 0.3s;
}

input:focus {
	outline: none;
	border-color: #007bff;
}

.error-message {
	font-size: 12px;
	margin-top: 1px;
}

#error-icon .icon {
	margin-right: 8px;
}

#error-icon .icon.success {
	color: bule;
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
		<!-- 회원가입 폼 -->
		<div class="container-signup">
			<form id="signup-form">
				<!-- 아이디 -->
				<div class="form-group">
					<label for="username">아이디*</label> <input type="text" id="username"
						name="username" class="form-control" placeholder="영문소문자/숫자, 4~16자"
						required onblur="duplicateCheck()">
				</div>
				<span id="idErrorSpan" class="icon"></span> <span id="idCheckSpan"
					class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>
				<!-- 비밀번호 -->
				<div class="form-group">
					<label for="password">비밀번호*</label> <input type="password"
						id="password" name="password" class="form-control"
						placeholder="영문 대소문자/숫자/특수문자 중 조합, 8~16자" required
						oncopy="return false;" onpaste="return false;"
						oncut="return false;" onblur="checkPassword()">
				</div>
				<span id="pwErrorSpan" class="icon"></span> <span id="pwCheckSpan"
					class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>

				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<label for="confirm-password">비밀번호 확인*</label> <input
						type="password" id="confirm-password" name="confirm-password"
						class="form-control" placeholder="비밀번호를 다시 입력하세요" required
						oncopy="return false;" onpaste="return false;"
						oncut="return false;" onblur="checkConfirmPassword()">
				</div>
				<span id="confirmPwErrorSpan" class="icon"></span> <span
					id="confirmPwCehckSpan" class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>

				<!-- 이름 -->
				<div class="form-group">
					<label for="name">이름*</label> <input type="text" id="name"
						name="name" class="form-control" placeholder="이름을 입력하세요" required
						onblur="checkName()">
				</div>
				<span id="nameErrorSpan" class="icon"></span> <span
					id="nameCheckSpan" class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>

				<!-- 생년월일 -->
				<div class="form-group">
					<label for="birthDate">생년월일*</label> <input type="text"
						id="birthDate" class="form-control" placeholder="생년월일" required>
				</div>
				<span id="birthErrorSpan" class="icon"></span> <span
					id="birthCheckSpan" class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>

				<!-- 주소 -->
				<div class="form-group">
					<label for="address-line1">주소*</label>
					<div class="address-row">
						<input type="text" id="address-line1" name="address-line1"
							placeholder="도로명 주소를 입력하세요" readonly>
						<button type="button" onclick="execDaumPostcode()"
							style="width: 120px; height: 48px;">우편번호 검색</button>
					</div>
					<input type="text" id="address-line2" name="address-line2"
						placeholder="상세 주소를 입력하세요" required onblur="checkAddress()">
				</div>
				<span id="addressErrorSpan" class="icon"></span> <span
					id="addressCheckSpan" class="error-message"
					style="color: red; display: none; font-size: 0.8rem;"></span>

				<!-- 연락처 -->
				<div class="form-group">
					<label for="phone">휴대폰 번호*</label>
					<div class="phone-row">
						<select id="phone-part1" name="phone-part1">
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="019">019</option>
						</select> <span style="line-height: 1;">-</span>
						<!-- 중간 번호 -->
						<input type="text" id="phone-part2" name="phone-part2"
							placeholder="" maxlength="4" oninput="validatePhonePart2(this)">
						<span style="line-height: 1;">-</span>
						<!-- 마지막 번호 -->
						<input type="text" id="phone-part3" name="phone-part3"
							placeholder="" maxlength="4" oninput="validatePhonePart3(this)">
						<button type="button" id="auth-button" onclick="smsPostcode()">휴대폰
							인증</button>
					</div>
					<div class="phone-row2">
						<!-- 인증번호 입력 영역 -->
						<div class="otp-row" style="display: none; margin-top: 20px;">
							<input type="text" id="otp-code" placeholder="인증번호 입력 (6자리)"
								maxlength="6">
							<button type="button" id="otp-submit-button"
								onclick="submitOTP()">제출</button>
						</div>
					</div>
				</div>

				<!-- 이메일 입력 -->
				<div class="form-group">
					<label for="customer-email">이메일 *</label>
					<div class="email-row">
						<!-- 이메일 앞부분 -->
						<input type="text" id="email-prefix" name="email-prefix"
							placeholder="Email" style="flex-grow: 1;"> <span
							style="line-height: 1;">@</span>
						<!-- 이메일 도메인 선택 -->
						<select id="email-domain" name="email-domain" style="flex-grow: 1">
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="daum.net">daum.net</option>
							<option value="custom">직접 입력</option>
						</select>
						<!-- 인증 버튼 -->
						<button type="button" id="email-auth-button" onclick="sendEmail()">이메일
							인증</button>
					</div>
					<div class="email-row">
						<!-- 사용자 입력 -->
						<input type="text" id="custom-email-domain"
							name="custom-email-domain" placeholder="직접 입력"
							style="margin-top: 10px; display: none;">
						<script>
				        document.getElementById("email-domain").addEventListener("change", function() {
				            const customField = document.getElementById("custom-email-domain");
				            if (this.value === "custom") {
				                customField.style.display = "block";
				            } else {
				                customField.style.display = "none";
				            }
				        });
				    </script>

						<!-- 인증번호 입력 영역 -->
						<div class="emailotp-row" style="display: none; margin-top: 20px;">
							<input type="text" id="email-otp-code"
								placeholder="인증번호 입력 (6자리)" maxlength="6">
							<button type="button" id="email-otp-submit-button"
								onclick="submitEmailOTP()">제출</button>
						</div>
					</div>
				</div>
				<hr>
				<!-- 약관 동의 -->
				<div class="form-group">
					<label>이용약관 및 개인정보 수집에 동의.*</label>
					<div class="checkbox-group">
						<label for="terms-agree">[필수] 이용약관 동의</label> <input
							type="checkbox" id="terms-agree" name="terms-agree"
							style="margin-left: 89px" required>
					</div>
					<div class="checkbox-group">
						<label for="privacy-agree">[필수] 개인정보 수집 및 이용 동의</label> <input
							type="checkbox" id="privacy-agree" name="privacy-agree" required>
					</div>
					<div class="checkbox-group">
						<label for="marketing-agree">[선택] 쇼핑정보 수신 동의</label> <input
							type="checkbox" id="marketing-agree" name="marketing-agree"
							style="margin-left: 59px">
					</div>
				</div>


				<br>
				<!-- 제출 버튼 -->
				<button type="submit" class="btn-submit">회원가입</button>
			</form>

		</div>
	</main>
	<!-- flatpickr 스타일과 스크립트 추가 -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<!-- 한글 로케일 파일 추가 -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
	<script>
	let smsAuth = false; // 회원가입 편의상 ture 원래는 false!!
	let emailAuth = false; // 회원가입 편의상 ture false!!
	
	
	function showValidation(element, spanElement, errorSpanElement, isValid) {
	    if (isValid) {
	    	errorSpanElement.innerHTML = '<i class="fas fa-check-circle" style="color: blue;"></i>';
	    	element.style.borderColor = "blue";
	    	spanElement.style.color = "blue";
	    } else {
	    	errorSpanElement.innerHTML = '<i class="fas fa-exclamation-circle" style="color: red;"></i>';
	    	element.style.borderColor = "red";
	    	spanElement.style.color = "red";
	    	spanElement.style.display = 'inline';
	    }
	}
	
	
    // 아이디 중복 체크 함수
    let validId = null;
    async function duplicateCheck() {
        let userId = document.getElementById("username").value;
        let element = document.getElementById("username");
        let spanElement = document.getElementById("idCheckSpan");
        let errorSpanElement = document.getElementById("idErrorSpan");
        
        const userIdRegex = /^(?=.*[a-z])(?=.*\d)[a-z0-9]{4,16}$/;
        
        if (!userId) { // 빈칸 입력 체크
        	spanElement.textContent = "아이디를 입력해주세요.";
        	showValidation(element, spanElement, errorSpanElement, false);
        } else if(!userIdRegex.test(userId)) { // 유효성 체크
        	spanElement.textContent = "아이디는 영문소문자/숫자, 4~16자만 가능합니다.";
        	showValidation(element, spanElement, errorSpanElement, false);	
        } else {
        	try {
                const response = await fetch('${path}/auth/idchecker', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({ userId }),
                });

                // 응답 처리
                const result = await response.json(); // JSON 파싱

                if (result.status === "success") {
                	showValidation(element, spanElement, errorSpanElement, true);
                	spanElement.textContent = "사용 가능한 아이디입니다.";
                	spanElement.style.display = 'inline';
                	validId = userId;
                } else {
                	showValidation(element, spanElement, errorSpanElement, false);
                	spanElement.textContent = "이미 존재하는 아이디입니다.";
                }
            } catch (error) {
                console.error('중복 체크 요청 중 오류 발생:', error);
                alert('서버와 통신 중 문제가 발생했습니다. 나중에 다시 시도해주세요.');
            }
        }
    }
	
 	// 비밀번호 유효성 검사
 	let validPassword = null;
    function checkPassword() {        
        let password = document.getElementById("password").value;
        let element = document.getElementById("password");
        let spanElement = document.getElementById("pwCheckSpan");
        let errorSpanElement = document.getElementById("pwErrorSpan");
        
     	// 영문 대소문자, 숫자, 특수문자 조합 검사
	    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
	    
	    // 비밀번호 길이 검사
	    if (password.length < 8 || password.length > 16) {
	    	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "비밀번호는 8자 이상 16자 이하로 입력해주세요.";
	    } else if(!regex.test(password)) {
	    	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "비밀번호는 영문 대소문자/숫자/특수문자 중 조합, 8~16자가 되어야 합니다.";
	    } else {
	    	showValidation(element, spanElement, errorSpanElement, true);
	    	spanElement.textContent = "사용 가능한 비밀번호입니다.";
	    	spanElement.style.display = 'inline';
	    	validPassword = password;
	    }
    }
	
 	// 비밀번호 확인 검사
    function checkConfirmPassword() {
	    let confirmPassword = document.getElementById("confirm-password").value;
	    let element = document.getElementById("confirm-password");
        let spanElement = document.getElementById("confirmPwCehckSpan");
        let errorSpanElement = document.getElementById("confirmPwErrorSpan");
	  	
        if (confirmPassword === "") {
        	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "비밀번호를 입력하세요.";
        } else if (validPassword !== confirmPassword) {
        	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "비밀번호가 일치하지 않습니다.";
	    } else {
	    	showValidation(element, spanElement, errorSpanElement, true);
	    	spanElement.textContent = "비밀번호가 일치합니다.";
	    	spanElement.style.display = 'inline';
	    }
    }
 	
 	// 이름 검사
 	let validName = null;
    function checkName() {
	    let name = document.getElementById("name").value;
	    let element = document.getElementById("name");
        let spanElement = document.getElementById("nameCheckSpan");
        let errorSpanElement = document.getElementById("nameErrorSpan");
	  
	    if (name === "") {
	    	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "이름을 입력하세요.";
	    } else {
	    	showValidation(element, spanElement, errorSpanElement, true);
	    	spanElement.style.display = 'none';
        	validName = document.getElementById("name").value;
	    }
    }
    
 // 달력 라이브러리
	flatpickr("#birthDate", {
        dateFormat: "Y-m-d", // 원하는 날짜 형식
        altInput: true, // 사용자 입력 필드를 달력으로 변경
        altFormat: "F j, Y", // 대체 형식
        locale: "ko", // 한글 로케일 설정
        onClose: checkBirth
    });
 
 	// 생년월일 검사
 	let validBirth = null;
    function checkBirth() {
	    let birthDate = document.getElementById("birthDate").value;
	    let element = document.querySelector(".form-group input#birthDate");
        let spanElement = document.getElementById("birthCheckSpan");
        let errorSpanElement = document.getElementById("birthErrorSpan");
	 
	    if (!birthDate) {
	    	showValidation(element, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "생년월일을 입력하세요.";
	    } else {
	    	showValidation(element, spanElement, errorSpanElement, true);
	    	element.style.borderColor = "blue";
	    	spanElement.style.display = 'none';
	    	validBirth = birthDate;
	    }   
    }

 	// 상세주소 검사
 	let validAddress2 = null;
    function checkAddress() {
    	let address1 = document.getElementById("address-line1").value;
	    let address2 = document.getElementById("address-line2").value;
	    let element1 = document.getElementById("address-line1");
	    let element2 = document.getElementById("address-line2");
        let spanElement = document.getElementById("addressCheckSpan");
        let errorSpanElement = document.getElementById("addressErrorSpan");
	  
        if (address1 == "") {
        	showValidation(element1, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "도로명 주소를 입력하세요.";
	    } else {
	    	showValidation(element1, spanElement, errorSpanElement, true);
	    	spanElement.style.display = 'none';
	    }   
        
	    if (address2 == "") {
	    	showValidation(element2, spanElement, errorSpanElement, false);
	    	spanElement.textContent = "상세주소를 입력하세요.";
	    } else {
	    	showValidation(element, spanElement, errorSpanElement, true);
	    	spanElement.style.display = 'none';
	    	validAddress2 = address2;
	    }   
    }
    
	
	document.getElementById("signup-form").addEventListener("submit", function(event) {
	    event.preventDefault();
	
	    // 폼 데이터
	    let formData = new FormData(this);
	    
	 	// 전화번호
	    let phone = null;
	    if (smsAuth) {
		    const phonePart1 = formData.get("phone-part1");
		    const phonePart2 = formData.get("phone-part2");
		    const phonePart3 = formData.get("phone-part3");
		    phone = `\${phonePart1}-\${phonePart2}-\${phonePart3}`;
	    } else {
	    	alert("휴대폰 인증을 해주세요.");
	    	return;
	    }
	 	
	 	// 이메일
	 	let emailPrefix = null;
	 	let emailDomain = null;
	    if (emailAuth) {
		    emailPrefix = formData.get("email-prefix");
		    emailDomain = formData.get("email-domain");
		    if (emailDomain === "custom") {
		        emailDomain = formData.get("custom-email-domain");
		    }
	    } else {
	    	alert("이메일 인증을 해주세요.");
	    	return;
	    }

	    const jsonData = {
	        username: validId,
	        password: validPassword,
	        name: validName,
	        birth : validBirth,
	        address: formData.get("address-line1"),
	        member_address_detail: validAddress2,
	        phone: phone,
	        emailPrefix: emailPrefix,
	        emailDomain: emailDomain,
	        termsAgree: formData.get("termsAgree") === "on",
	        privacyAgree: formData.get("privacyAgree") === "on",
	        marketingAgree: formData.get("marketingAgree") === "on"
	    };
	
	    fetch("${path}/auth/register", {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify(jsonData)
	    })
	    .then(response => response.json())
	    .then(data => {
	        alert(data.status === "success" ? "회원가입 성공!" : "회원가입 실패!");
	        if (data.status === "success") {
	            // 회원가입 성공 시 로그인 페이지로 이동
	            window.location.href = "${path}/auth/login";
	        } else {
	            // 회원가입 실패 시 다시 회원가입 페이지로 이동
	            window.location.href = "${path}/auth/signup";
	        }
	    })
	    .catch(error => {
	        alert("오류가 발생했습니다.");
	    });
	});

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

    // 이메일 인증 요청
    async function sendEmail() {
        // 이메일 조합
        const emailPrefix = document.getElementById("email-prefix").value;
        const emailDomain = document.getElementById("email-domain").value;
        const customDomain = document.getElementById("custom-email-domain").value;

        const email = `\${emailPrefix}@\${customDomain}\${emailDomain}`;

        if (!emailPrefix || !email) {
            alert("올바른 이메일 주소를 입력해주세요.");
            return;
        }

        const response = await fetch('${path}/auth/sendEmail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email }),
        });

        const result = await response.json();
        alert(result.message);
        

        if (result.status === "success") {
            // 인증번호 입력 필드 보이기
        	document.querySelector('.emailotp-row').style.display = 'flex';
        }
    }

    // 인증 코드 제출
    async function submitEmailOTP() {
        const emailPrefix = document.getElementById("email-prefix").value;
        const emailDomain = document.getElementById("email-domain").value;
        const customDomain = document.getElementById("custom-email-domain").value;

        const email = `\${emailPrefix}@\${customDomain}\${emailDomain}`;
        const code = document.getElementById("email-otp-code").value;

        if (!email || !code) {
            alert("이메일과 인증 코드를 모두 입력해주세요.");
            return;
        }

        const response = await fetch('${path}/auth/verifyCode', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ email, code }),
        });

        const result = await response.json();
        
        if (result.status === "success") {
            // 인증번호 입력 필드 보이기
            
        	document.querySelector('.emailotp-row').style.display = 'none';
        	document.getElementById('email-auth-button').style.display = 'none';
            document.getElementById('email-prefix').disabled = true;
            document.getElementById('email-domain').disabled = true;
            
            emailAuth = true;
        }
        alert(result.message);
    }

    function smsPostcode() {
        // 전화번호 합치기
        const phonePart1 = document.getElementById('phone-part1').value; // 앞자리
        const phonePart2 = document.getElementById('phone-part2').value; // 중간 번호
        const phonePart3 = document.getElementById('phone-part3').value; // 끝 번호
        const fullPhoneNumber = `\${phonePart1}-\${phonePart2}-\${phonePart3}`;
        
        const isConfirmed = confirm(`입력한 전화번호가 ${fullPhoneNumber}이 맞습니까?`);
        if (!isConfirmed) {
            alert('전화번호 인증이 취소되었습니다.');
            return;
        }

        // 인증 버튼 비활성화
        const authButton = document.getElementById('auth-button');
        authButton.disabled = true;
        authButton.textContent = '인증 요청 중'; // 버튼 텍스트 변경

        // 서버로 전화번호 전송
        fetch('${path}/auth/sms', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                phoneNumber: fullPhoneNumber,
            }),
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error('서버 응답 실패');
                }
                return response.json();
            })
            .then((data) => {
                if (data.success) {
                    alert('인증 코드가 전송되었습니다.');
                    // 인증번호 입력 칸과 제출 버튼 표시
                    document.querySelector('.otp-row').style.display = 'flex';
                } else {
                    alert('인증 코드 전송에 실패했습니다.');
                    authButton.disabled = false;
                    authButton.textContent = '휴대폰 인증';
                }
            })
            .catch((error) => {
                console.error('에러 발생:', error);
                alert('문제가 발생했습니다. 다시 시도해주세요.');
                authButton.disabled = false;
                authButton.textContent = '휴대폰 인증';
            });
    }

    function submitOTP() {
        const otpCode = document.getElementById('otp-code').value; // 사용자가 입력한 OTP 코드
        const phonePart1 = document.getElementById('phone-part1').value; // 앞자리
        const phonePart2 = document.getElementById('phone-part2').value; // 중간 번호
        const phonePart3 = document.getElementById('phone-part3').value; // 끝 번호
        const fullPhoneNumber = `\${phonePart1}\${phonePart2}\${phonePart3}`;

        if (otpCode.length !== 6 || isNaN(otpCode)) {
            alert('6자리 숫자 인증번호를 정확히 입력해주세요.');
            return;
        }

        // 서버로 OTP 검증 요청
        fetch('${path}/auth/otp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                phoneNumber: fullPhoneNumber,
                code: otpCode,
            }),
        })
            .then((response) => response.json()) // 상태 코드와 상관없이 JSON 파싱
            .then((data) => {
                console.log('서버 응답 데이터:', data);

                if (data.status === 'success') {
                    alert('인증이 완료되었습니다.');
                    // UI 업데이트 로직

                    // 전화번호 입력 칸 비활성화
                    document.getElementById('phone-part1').disabled = true;
                    document.getElementById('phone-part2').disabled = true;
                    document.getElementById('phone-part3').disabled = true;

                    // 인증번호 입력 칸과 제출 버튼 숨기기
                    document.querySelector('.otp-row').style.display = 'none';

                    // 휴대폰 인증 버튼도 숨기기
                    
                    document.getElementById('auth-button').style.display = 'none';
                    smsAuth = true;
                } else {
                    alert('인증에 실패했습니다. 다시 시도해주세요.');
                }
            })
            .catch((error) => {
                console.error('에러 발생:', error);
                alert('문제가 발생했습니다. 다시 시도해주세요.');
            });
    }

    // 유효성 검사 함수 (중간 번호)
    function validatePhonePart2(input) {
        input.value = input.value.replace(/[^0-9]/g, '').slice(0, 4); // 숫자만 허용, 최대 4자리
    }

    // 유효성 검사 함수
    function validatePhonePart3(input) {
        input.value = input.value.replace(/[^0-9]/g, '').slice(0, 4); // 숫자만 허용, 최대 4자리
    }
    
</script>


	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js' />"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
</html>
