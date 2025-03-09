<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
	href="<c:url value='/resources/booking/css/style.css' />" />
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #757c7f0a !important;
	margin: 0;
	padding: 0;
}

main {
	margin-bottom: 140px; 
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
	gap: 20px;
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


}
.login-container{
	margin-top:200px;
	margin-bottom:200px;
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
    <section class="vh-xxl-100" style="height: 50vh;"> <!-- 전체 크기를 50%로 줄임 -->
        <div
            class="container h-100 d-flex justify-content-center align-items-center">
            <div class="bg-mode shadow rounded-3 overflow-hidden w-100"
                style="max-width: 1100px;"> <!-- 최대 너비를 약간 줄임 -->
                <div class="d-flex flex-row h-100">
                    <!-- Left: Image Section -->
                    <div
                        class="col-6 d-flex align-items-center justify-content-center p-4">
                        <img src="${path}/resources/assets/images/login.jpg"
                            alt="Sign-in Image" class="img-fluid">
                    </div>

                    <!-- Divider -->
                    <div class="vr" style="background-color: black; width: 2px; height: 80%; margin: auto;"></div>
                    <!-- <div class="custom-divider" style="width: 2px; height: 80%;"></div> 구분선 스타일 추가 -->

                    <!-- Right: Login Form -->
                    <div
                        class="col-6 d-flex align-items-center justify-content-center p-4">
                        <div class="login-container w-100" style="max-width: 400px;">
                            <h3>로그인</h3>
                            <form id="login-form">
                                <!-- 아이디 입력 -->
                                <div class="form-group">
                                    <label for="username">아이디</label>
                                    <input type="text" id="username" name="username"
                                        placeholder="아이디를 입력하세요" class="form-control" required>
                                </div>

                                <!-- 비밀번호 입력 -->
                                <div class="form-group">
                                    <label for="password">비밀번호</label>
                                    <input type="password" id="password" name="password"
                                        placeholder="비밀번호를 입력하세요" class="form-control" required>
                                </div>

                                <!-- 로그인 버튼 -->
                                <button type="button" class="btn-submit" id="login-button">로그인</button>

                                <!-- 추가 링크 -->
                                <div class="links">
                                    <a href="<c:url value='/auth/idsearch' />">아이디 찾기</a> | 
                                    <a href="<c:url value='/auth/pwsearch' />">비밀번호 찾기</a> | 
                                    <a href="<c:url value='/auth/signup' />">회원가입</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>


	<!-- footer -->
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script>
    document.getElementById("login-button").addEventListener("click", function () {
        // 폼 데이터 가져오기
        const username = document.getElementById("username").value.trim();
        const password = document.getElementById("password").value.trim();

        // JSON 변환
        const loginData = {
            username,
            password
        };

        fetch("<c:url value='/auth/login' />", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(loginData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') { 
                 

             	// 쿠키에 JWT 저장 (HttpOnly는 서버에서 설정해야 함)
                document.cookie = `jwt=${data.token}; path=/; max-age=7200`; // 2시간 유효

                // 메인 페이지로 이동
                window.location.href = "${path}/main";
            } else {
                alert(data.message); 
            }
        })
        .catch(error => {
            console.error("로그인 중 오류 발생:", error);
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        });
    });
    
 	// 엔터 키로 로그인 실행
    document.getElementById("username").addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            document.getElementById("login-button").click();  // 로그인 버튼 클릭 이벤트 실행
        }
    });

    document.getElementById("password").addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            event.preventDefault();
            document.getElementById("login-button").click();  // 로그인 버튼 클릭 이벤트 실행
        }
    });
</script>
	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js' />"></script>
</body>
</html>