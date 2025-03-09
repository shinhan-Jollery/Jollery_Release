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

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/min/dropzone.min.css">

<script src="${path}/resources/chat/assets/js/dropzone.js"></script>


<title>Jollery</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #757c7f0a !important;
}

.upload-container {
	background-color: #f9f9f9;
	border: 2px dotted #ddd;
	height: 400px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	position: relative;
}

.upload-container.dragover {
	background-color: #e6f7ff;
	border-color: #007bff;
}

.upload-container label {
	color: #000;
}

.upload-container span {
	text-decoration: underline;
	color: #007bff;
	cursor: pointer;
}

.text-muted {
	color: #6c757d;
}

.btn-primary {
	background-color: #007bff;
	border: none;
	padding: 10px 20px;
	color: white;
	cursor: pointer;
	border-radius: 4px;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.text-center {
	text-align: center;
}

.rounded {
	border-radius: 5px;
}

.py-5 {
	padding-top: 3rem;
	padding-bottom: 3rem;
}

.mb-0 {
	margin-bottom: 0;
}

.mt-1 {
	margin-top: 0.25rem;
}
.but{
	background-color: #1f3269 !important;
	color: #fff !important;
	border: none !important;                /* 기본 테두리 제거 */
	border-radius: 10px !important;
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


				<!--  sidebar -->
				<c:choose>
					<c:when test="${isArtist == '1'}">
						<%@ include file="/WEB-INF/views/common/sellersidebar.jsp"%>
					</c:when>
					<c:otherwise>
						<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
					</c:otherwise>
				</c:choose>
				<!-- / sidebar -->


				<!-- content -->
				<div class="col-lg-9">
					<div class="row">
						<div class="col">
							<div class="tab-content" id="myTabContent">
								<!-- 판매자 인증 -->
								<div class="tab-pane fade show active" id="sidebar-1-4"
									role="tabpanel" aria-labelledby="sidebar-1-4">
									<div class="row">
										<div class="col">
											<h3 class="mb-0">판매자 인증</h3>
										</div>
									</div>
									<div class="row">
										<div class="col-12 text-center">
											<p>재학 증명서 및 졸업 증명서로 인증 가능</p>
											<form class="dropzone" id="my-dropzone"
												enctype="multipart/form-data">
												<!-- Dropzone 기본 메시지는 자동으로 표시됩니다 -->
											</form>
											<button id="submit-btn" class="but btn btn-primary mt-1">등록</button>
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




	<footer>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</footer>
	


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>

	<script>
		let authForm = new FormData();
		
		const dropzone = new Dropzone("#my-dropzone", {
			url : "${path}/auth/certify", // 업로드 API URL
			method : "put",
			autoProcessQueue : false, // 자동 업로드 방지
			uploadMultiple : false, // 파일 하나씩 업로드
			maxFiles : 1, // 업로드 가능한 파일 개수 제한
			maxFilesize : 5, // 최대 파일 크기 (MB)
			acceptedFiles : "image/*,application/pdf", // 허용 파일 형식
			addRemoveLinks : true, // 파일 제거 링크 표시
			dictDefaultMessage : "여기로 파일을 드래그하거나 클릭하세요.",
			dictRemoveFile : "삭제",
		});
		
		dropzone.on('addedfile', function(file) {
			console.log('addedfile');
			authForm.append("file", file);
	    });

		document.getElementById('submit-btn').addEventListener('click',
				function() {
					if (dropzone.getAcceptedFiles().length === 0) {
						alert("파일을 업로드 해주세요.");
					} else {
						console.log("123");
						dropzone.processQueue(); // 큐 처리
						fetch('${path}/auth/certify', {
				            method: "POST",
				            body: authForm,
				            headers: {
				                'Accept': 'application/json'
				            }
				        })
				        .then((response) => response.json())
				        .then((fileUrl) => {
				        	console.log(fileUrl);
				        });
						dropzone.removeAllFiles(true);
						alert("등록 성공");
						window.location.href = " <c:url value="/main" />";
					}
				});
	</script>
</body>
</html>