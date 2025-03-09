<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
</style>


<link rel="stylesheet"
	href="<c:url value='/resources/booking/css/style.css' />" />

<body>
	<!--  sidebar -->
	<!-- Sidebar START -->
	<div class="col-lg-4 col-xl-3">
		<!-- Responsive offcanvas body START -->
		<div class="offcanvas-lg offcanvas-end" tabindex="-1"
			id="offcanvasSidebar">


			<!-- Offcanvas body -->
			<div class="offcanvas-body p-3 p-lg-0">
				<div class="card bg-white w-100 rounded shadow-lg">

					<!-- Edit profile button -->
					<div class="position-absolute top-0 end-0 p-3"></div>

					<!-- Card body START -->
					<div class="card-body p-3">
						<!-- Avatar and content -->
						<div class="text-center mb-3">

							<h6 class="mb-0">${memberName } 님</h6>
							<hr>
						</div>

						<!-- Sidebar menu item START -->
						<ul class="nav nav-pills-primary-soft flex-column">
							<!-- 회원정보 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/auth/infoUpdate"><i
									class="bi bi-person fa-fw me-2"></i>회원정보</a></li>
							<!-- 주문내역 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/order/list"><i
									class="bi bi-ticket-perforated fa-fw me-2"></i>주문내역</a></li>
							<!-- 관심상품 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/like"><i class="bi bi-heart fa-fw me-2"></i>관심상품</a>
							</li>
							<!-- 작품등록 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/art/insert"><i
									class="bi bi-plus-circle fa-fw me-2"></i>작품등록</a></li>
							<!-- 판매내역 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/sale/list"><i class="bi bi-boxes fa-fw me-2"></i>판매내역</a>
							</li>
							<!-- 정산 -->
							<li class="nav-item"><a class="nav-link"
								href="${path}/auth/account"><i
									class="bi bi-currency-dollar fa-fw me-2"></i>정산</a></li>
							<!-- 로그아웃 -->
							<li class="nav-item"><a
								class="nav-link text-danger bg-danger-soft-hover"
								href="javascript:logout()"><i
									class="fas fa-sign-out-alt fa-fw me-2"></i>로그아웃</a></li>
						</ul>
						<!-- Sidebar menu item END -->
					</div>
					<!-- Card body END -->
				</div>
			</div>
		</div>
		<!-- Responsive offcanvas body END -->
	</div>
	<!-- Sidebar END -->

	<script>
function logout() {
    fetch("<c:url value='/auth/logout'/>", { method: 'POST' })
        .then(response => {
            if (response.ok) {
                // 로그아웃 성공 시 메인 페이지로 리다이렉트
                alert('로그아웃');
                window.location.href = "${path}/main";
            } else {
                alert('로그아웃 실패');
            }
        })
        .catch(error => console.error('Error:', error));
}
</script>

</body>
</html>