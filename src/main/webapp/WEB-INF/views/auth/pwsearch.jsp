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
	text-align: center;
	margin-bottom: 20px;
	font-size: 24px;
	color: #34495e;
}

form {
	display: flex;
	flex-direction: column;
	/* gap: 20px; */
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
	padding: 10px;
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

.pwSearch-container {
	margin-top: 150px;
	margin-bottom: 150px;
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
	
<div id="content">
	<main>
		<section class="vh-xxl-100" style="height: 50vh;">
			<!-- 전체 크기를 50%로 줄임 -->
			<div
				class="container h-100 d-flex justify-content-center align-items-center">
				<div class="bg-mode shadow rounded-3 overflow-hidden w-100"
					style="max-width: 1100px;">
					<!-- 최대 너비를 약간 줄임 -->
					<div class="d-flex flex-row h-100" style= " max-height: 640px;">
						<!-- Left: Image Section -->
						<div
							class="col-6 d-flex align-items-center justify-content-center p-4">
							<img src="${path}/resources/assets/images/login.jpg"
								alt="Sign-in Image" class="img-fluid">
						</div>

						<!-- Divider -->
						<div class="vr"
							style="background-color: black; width: 2px; height: 80%; margin: auto;"></div>

						<!-- Right: PW 찾기 Form -->
						<div
							class="col-6 d-flex align-items-center justify-content-center p-4">
							<div class="pwSearch-container w-100" style="max-width: 400px;">
								<h3>이메일로 비밀번호 찾기</h3>
								<br>
								<form id="find-pw-form">
									<!-- 이름 입력 -->
									<div class="form-group">
										<label for="membername">이름</label> <input type="text"
											id="membername" placeholder="이름을 입력하세요" style="height: 53px;">
									</div>
									<br>
									<!-- 아이디 입력 -->
									<div class="form-group">
										<label for="memberid">아이디</label> <input type="text"
											id="memberid" placeholder="아이디를 입력하세요" style="height: 53px;">
									</div>

									<!-- 이메일 인증 버튼 -->
									<br>
									<button class="btn-submit" style="width: 400px; height: 53px;" type="button"
										id="auth-button" onclick="sendMemberEmail()" >이메일 인증</button>

									<br>
                                <!-- 인증번호 입력 -->
                                <div class="form-group" style="display: none;" id="otp-section">
                                     <br>
                                    <input type="text" id="memberemail-otp-code" placeholder="인증번호 입력 (6자리)" maxlength="6" class="form-control"
                                    style="width:240px; margin-left:20px;">

                                    <button type="button" id="member-otp-submit-button" class="btn-submit" 
                                    style="height: 45px; width: 110px; font-size:13px; margin-left:8px; margin-top:3px;"
                                    onclick="submitMemberEmailOTP()">제출</button>
                                </div>
                                <br>





									<!-- 추가 링크 -->
									<div class="links mt-3">
										<a href="<c:url value='/auth/idsearch' />">아이디 찾기</a> | <a
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



 </div>
 
	<!-- footer -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js' />"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</body>
<script>
    // 이메일 인증 요청
    async function sendMemberEmail() {
    	const membername = document.getElementById("membername").value.trim();
        const memberid = document.getElementById("memberid").value.trim();
		console.log(membername);
        // JSON 변환
        const bodydata = {
        		membername,
        		memberid
        };
        const response = await fetch('${path}/auth/sendMemberEmail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(bodydata),
        });

        const result = await response.json();
        alert(result.message);
        

        if (result.status === "success") {
            // 인증번호 입력 필드 보이기
            const otpSection = document.getElementById("otp-section");
        	otpSection.style.display = "flex";  // flex로 변경
        	/* document.getElementById('otp-section').style.display = 'flex'; */
        }
    }

    // 인증 코드 제출
    async function submitMemberEmailOTP() {
    	const membername = document.getElementById("membername").value.trim();
        const memberid = document.getElementById("memberid").value.trim();
        const code = document.getElementById("memberemail-otp-code").value;
        // JSON 변환
        const bodydata = {
        		membername,
        		memberid,
        		code
        };
        

        const response = await fetch('${path}/auth/MemberverifyCode', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify( bodydata ),
        });
	
        const result = await response.json();
        alert(result.message);
        if (result.status === "success") {
        	window.location.href = "${path}/main";
        }
    }
</script>
</html>