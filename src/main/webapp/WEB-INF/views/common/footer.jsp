<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet">

<style>
#chatButton {
	position: fixed;
	top: 85vh; /* 화면 높이의 % */
	left: 91vw; /* 화면 너비의 90% */
	z-index: 1000;
	width: 90px;
	height: 90px;
	border:none;
	border-radius: 50%;
	background-color: #1f3269;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
	font-size: 36px;
	cursor: pointer;
}

#chatButton:hover {
	background-color: #0056b3;
}

#chatButton.clicked {
	transform: scale(1.2);
	color: #ff5733;
	font-weight: bold;
}

#chatButton i {
	font-size: 45px;
}

</style>
</head>
<body>

	<button id="chatButton" onclick="openChatRoom()"
		class="btn btn-primary">
		<i class="fas fa-comment-dots"></i>
	</button>

	<script>
		function openChatRoom() {
			fetch(`${path}/chatRest/chatCheckLogin`, {
	            method: 'GET',
	            headers: {
	                'Content-Type': 'application/json'
	            }
	        })
	        .then(response => response.text())
	        .then(data => {
	        	if (data === "true"){
	        		window.open("${path}/chatRoom", "popupWindow", 
	        	    "width=1200, height=700, left=230, top=160, toolbar=no, scrollbars=yes, resizable=yes");

	        	} else {
	        		alert("로그인을 해주세요!")
	        	}
	        });
		}
	</script>


	<!-- footer -->
	<footer class="text-white py-0"
		style="background-color: #5f5454e8;">
		<div class="container">
			<div class="row separated1">
				<div class="col-lg-4 py-3" style="height: 200px !important;">
					<div class="row">
						<div class="col-md-9">
							<ul class="list-group list-group-columns">

								<br>
								<li class="list-group-item"><a href="about.html">더 알아보기</a></li>
								<li class="list-group-item"><a href="contact.html">고객센터</a></li>
								<li class="list-group-item"><a href="faq.html">FAQ</a></li>
								<li class="list-group-item"><a href="blog.html">블로그</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-4 py-3" style="height: 200px !important;">
					<div class="row">
						<div class="col-lg-10">
							<h4 class="eyebrow mb-5">구독하기</h4>
							<div class="input-group">
								<!-- 입력 필드 크기 조정 (변경 없음) -->
								<input type="text" class="form-control form-control-sm"
									placeholder="Email" aria-label="Subscribe"
									aria-describedby="button-addon2">
								<div class="input-group-append">
									<!-- 버튼 크기 및 텍스트 크기 조정 -->
									<button class="btn btn-white btn-sm" type="button"
										id="button-addon2"
										style="font-size: 0.875rem; padding: 0.25rem 0.5rem;">구독</button>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="col-lg-4 py-4" style="height: 200px !important;">
					<div class="row">
						<div class="col-lg-10">
							<h4 class="eyebrow mb-5">팔로우</h4>
							<nav class="nav nav-icons">
								<!-- 아이콘 크기 조정 -->
								<a class="nav-link" href="#!"> <i class="icon-facebook-o"
									style="font-size: 16px;"></i></a> <a class="nav-link" href="#!">
									<i class="icon-twitter-o" style="font-size: 16px;"></i>
								</a>

								<a class="nav-link" href="#!"><i class="icon-instagram"
									style="font-size: 19px;"></i></a>
								<a class="nav-link" href="#!"><i class="icon-youtube-o"
									style="font-size: 16px;"></i></a>
							</nav>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>

</body>
</html>