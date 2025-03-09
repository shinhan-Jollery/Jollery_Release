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
.custom-table {
	border-collapse: collapse;
}

.custom-table th, .custom-table td {
	text-align: center;
	vertical-align: middle;
}

.custom-table thead th {
	border-top: 2px solid #dee2e6;
	border-bottom: 2px solid #dee2e6;
}

.custom-table tbody td {
	border-bottom: 1px solid #dee2e6;
}

.custom-table th:first-child, .custom-table td:first-child {
	border-left: none;
}

.custom-table th:last-child, .custom-table td:last-child {
	border-right: none;
}

body {
	background-color: #757c7f0a !important;
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
					<c:when test="${Integer.parseInt(isArtist) == 1}">
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

								<!-- payments -->
								<div class="tab-pane fade show active" id="sidebar-1-6"
									role="tabpanel" aria-labelledby="sidebar-1-6">
									<div class="row">
										<div class="col">
											<h3 class="mb-0">정산</h3>

										</div>
									</div>
									<div class="row gutter-2 mb-6">
										<div class="col-md-6">
											<div class="card card-data bg-white shadow">
												<div class="card-header card-header-options">
													<div class="row align-items-center">
														<div class="col">
															<h3 class="card-title">등록 계좌</h3>
														</div>
														<div class="col text-right">
															<div class="dropdown">
																<button id="dropdownMenu2" data-toggle="dropdown"
																	aria-haspopup="true" aria-expanded="false"
																	type="button"
																	class="btn btn-lg btn-secondary rounded btn-ico">
																	<i class="icon-more-vertical"></i>
																</button>
																<ul class="dropdown-menu"
																	aria-labelledby="dropdownMenu2">
																	<li><a class="dropdown-item" href="#!"
																		id="update-account-btn">계좌 수정</a></li>
																	<li><a class="dropdown-item" href="#!"
																		id="delete-account-btn">계좌 삭제</a></li>
																</ul>
															</div>
														</div>
													</div>
												</div>
												<div id="account-container" class="card w-90">
													<div class="card-body" style="border: none !important;">
														<!-- 계좌 정보를 JavaScript로 동적으로 표시 -->
														<div id="account-info" style="display: none;">
															<h5 class="text-muted">은행, 계좌번호</h5>
															<p class="card-text">
																<b id="account-bank"></b> <span id="account-number"></span>
															</p>
															<h5 class="text-muted">등록 날짜</h5>
															<p class="card-text" id="account-register-date"></p>
														</div>

														<!-- 계좌 등록 폼 -->
														<form id="account-form" style="display: none;"
															method="post">
															<div class="form-group">
																<label for="account_bank">은행명</label> <select
																	class="form-control" id="account_bank"
																	name="account_bank" required>
																	<option value="" disabled selected>은행을 선택하세요</option>
																	<option value="국민은행">국민은행</option>
																	<option value="신한은행">신한은행</option>
																	<option value="우리은행">우리은행</option>
																	<option value="하나은행">하나은행</option>
																	<option value="농협은행">농협은행</option>
																</select>
															</div>
															<div class="form-group">
																<label for="account_number">계좌번호</label> <input
																	type="text" class="form-control"
																	id="account_number_input" name="account_number"
																	placeholder="계좌번호를 입력하세요" required>
															</div>
															<br>
															<button type="button" class="btn btn-light btn-sm"
																id="register-account">계좌 등록</button>
														</form>
														<!-- 계좌 수정 폼 -->
														<form id="account-update-form" style="display: none;">
															<div class="form-group">
																<label for="account_bank">은행명</label> <select
																	class="form-control" id="update-account-bank"
																	name="account_bank" required>
																	<option value="" disabled selected>은행을 선택하세요</option>
																	<option value="국민은행">국민은행</option>
																	<option value="신한은행">신한은행</option>
																	<option value="우리은행">우리은행</option>
																	<option value="하나은행">하나은행</option>
																	<option value="농협은행">농협은행</option>
																</select>
															</div>
															<div class="form-group">
																<label for="account_number">계좌번호</label> <input
																	type="text" class="form-control"
																	id="update-account-number" placeholder="계좌번호를 입력하세요"
																	required>
															</div>
															<br>
															<button type="button" class="btn btn-light btn-sm"
																id="submit-update-btn">수정 완료</button>
														</form>

														<!-- 계좌 삭제 확인 모달 -->
														<div class="modal" tabindex="-1" id="delete-confirm-modal">
															<div class="modal-dialog">
																<div class="modal-content">
																	<div class="modal-header">
																		<h5 class="modal-title">계좌 삭제</h5>
																		<button type="button" class="btn-close"
																			data-bs-dismiss="modal" aria-label="Close"></button>
																	</div>
																	<div class="modal-body">
																		<p>계좌를 삭제하려면 비밀번호를 입력하세요.</p>
																		<input type="password" class="form-control"
																			id="delete-password" placeholder="비밀번호">
																	</div>
																	<div class="modal-footer">
																		<button type="button"
																			class="btn btn-secondary cancel-btn"
																			data-bs-dismiss="modal">취소</button>
																		<button type="button" class="btn btn-danger"
																			id="confirm-delete-btn">계좌 삭제</button>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
												<script>
												document.addEventListener("DOMContentLoaded", function () {
												    // 계좌 정보를 가져오는 AJAX 요청
												    fetch('${pageContext.request.contextPath}/auth/account/data', {
												        method: 'GET',
												        headers: {
												            'Content-Type': 'application/json',
												        }
												    })
												    .then(response => {
												        if (!response.ok) {
												            throw new Error("HTTP 상태 코드 오류: " + response.status);
												        }
												        return response.json();
												    })
												    .then(data => {
												    	console.log(data);
												        if (data.success) {
												            if (data.account) {
												                // 계좌 정보가 있을 경우
												                const account = data.account;
												                document.getElementById("account-bank").textContent = account.account_bank;
												                document.getElementById("account-number").textContent = account.account_number;

												                const timestamp = account.account_register_date;
												                const date = new Date(timestamp);
												                const formattedDate = date.toLocaleDateString("en-CA");
												                document.getElementById("account-register-date").textContent = formattedDate;

												                document.getElementById("account-info").style.display = "block"; // 계좌 정보 표시
												                document.getElementById("account-form").style.display = "none"; // 계좌 등록 폼 숨김
												            } else {
												                // 계좌 정보가 없을 경우
												                document.getElementById("account-form").style.display = "block"; // 폼 표시
												                document.getElementById("account-info").style.display = "none"; // 계좌 정보 숨김
												            }
												        } else {
												            console.error("서버 응답 오류:", data.message);
												        }
												    })
												    .catch(error => {
												        console.error("계좌 정보를 불러오는 중 오류 발생:", error);
												    });
												});

										    document.addEventListener("DOMContentLoaded", function () {
										        // 계좌 정보가 없으면 폼 표시
										        fetch('${pageContext.request.contextPath}/auth/account/data')
										            .then(response => response.json())
										            .then(data => {
										                if (!data.success || !data.account) {
										                    document.getElementById("account-form").style.display = "block"; // 계좌 등록 폼 표시
										                } else {
										                    document.getElementById("account-info").style.display = "block"; // 계좌 정보 표시
										                    document.getElementById("account-bank").textContent = data.account.account_bank;
										                    document.getElementById("account-number").textContent = data.account.account_number;
										                    document.getElementById("account-register-date").textContent = new Date(data.account.account_register_date).toLocaleDateString();
										                }
										            })
										            .catch(error => console.error("계좌 정보를 불러오는 중 오류 발생:", error));
										
										        // 계좌 등록 버튼 클릭 시 AJAX 요청
										        document.getElementById("register-account").addEventListener("click", function () {
										            const accountBank = document.getElementById("account_bank").value;
										            const accountNumber = document.getElementById("account_number_input").value;
										
										            // 유효성 검사
										            if (!accountBank || !accountNumber) {
										                alert("은행명과 계좌번호를 모두 입력해주세요.");
										                return;
										            }
										
										            const accountData = {
										                account_bank: accountBank,
										                account_number: accountNumber
										            };
										
										            // 계좌 등록 요청
										            fetch('${pageContext.request.contextPath}/auth/account/register', {
										                method: 'POST',
										                headers: {
										                    'Content-Type': 'application/json'
										                },
										                body: JSON.stringify(accountData)
										            })
										            .then(response => response.json())
										            .then(data => {
										                if (data.success) {
										                    alert("계좌 등록이 완료되었습니다.");
										                    location.reload();  // 새로 고침하여 최신 계좌 정보 로드
										                } else {
										                    alert("계좌 등록에 실패했습니다.");
										                }
										            })
										            .catch(error => console.error("계좌 등록 중 오류 발생:", error));
										        });
										    });
										    
										 // 계좌 수정 버튼 클릭 시
									        document.getElementById("update-account-btn").addEventListener("click", () => {
									            document.getElementById("account-info").style.display = "none";
									            document.getElementById("account-update-form").style.display = "block";
									        });

									        // 계좌 수정 제출
									        document.getElementById("submit-update-btn").addEventListener("click", () => {
									            const updatedBank = document.getElementById("update-account-bank").value;
									            const updatedNumber = document.getElementById("update-account-number").value;

									            fetch('${pageContext.request.contextPath}/auth/account/update', {
									                method: 'PUT',
									                headers: { 'Content-Type': 'application/json' },
									                body: JSON.stringify({
									                    account_bank: updatedBank,
									                    account_number: updatedNumber
									                })
									            })
									            .then(response => {
									                if (!response.ok) {
									                    throw new Error("HTTP 상태 코드 오류: " + response.status);
									                }
									                return response.json();
									            })
									            .then(data => {
									                if (data.success) {
									                    alert("계좌가 수정되었습니다.");
									                    location.reload();
									                } else {
									                    alert(data.message || "계좌 수정 중 오류가 발생했습니다.");
									                }
									            })
									            .catch(error => console.error("계좌 수정 중 오류 발생:", error));
									        });

									        document.addEventListener("DOMContentLoaded", function () {
									            const deleteModalElement = document.getElementById("delete-confirm-modal");
									            const deleteModal = new bootstrap.Modal(deleteModalElement);

									            // 계좌 삭제 버튼 클릭 시 모달 표시
									            document.getElementById("delete-account-btn").addEventListener("click", () => {
									            	console.log("Delete button clicked");
									                deleteModal.show();
									            });

									            // 모달의 취소 버튼 클릭 시 모달 닫기
									            deleteModalElement.querySelector(".cancel-btn").addEventListener("click", () => {
									                deleteModal.hide();
									            });

									            // 계좌 삭제 확인
									            document.getElementById("confirm-delete-btn").addEventListener("click", () => {
									                const password = document.getElementById("delete-password").value;

									                fetch('${pageContext.request.contextPath}/auth/account/delete', {
									                    method: 'DELETE',
									                    headers: { 'Content-Type': 'application/json' },
									                    body: JSON.stringify({ password: password })
									                })
									                    .then(response => {
									                        if (!response.ok) {
									                            throw new Error("HTTP 상태 코드 오류: " + response.status);
									                        }
									                        return response.json();
									                    })
									                    .then(data => {
									                        if (data.success) {
									                            alert("계좌가 삭제되었습니다.");
									                            location.reload();
									                        } else {
									                            alert(data.message || "계좌 삭제 중 오류가 발생했습니다.");
									                        }
									                    })
									                    .catch(error => console.error("계좌 삭제 중 오류 발생:", error))
									                    .finally(() => {
									                        deleteModal.hide(); // 삭제 요청 후 모달 닫기
									                    });
									            });
									        });
									    
										</script>

											</div>
										</div>

									</div>

									<div class="row">
										<div class="col">
											<h3 class="mb-0">정산 내역</h3>
										</div>
									</div>
									<div class="row mt-3">
										<div class="col">
											<table
												class="table table-bordered custom-table rounded shadow bg-white"
												style="border-radius: 50px; overflow: hidden;">
												<thead>
													<tr>
														<th>정산 고유번호</th>
														<th>정산 금액</th>
														<th>정산 날짜</th>
														<th>정산 상태</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>001</td>
														<td>₩1,000,000</td>
														<td>2024-11-01</td>
														<td>정산 완료</td>
													</tr>
													<tr>
														<td>002</td>
														<td>₩500,000</td>
														<td>2024-12-01</td>
														<td>정산 대기중</td>
													</tr>
												</tbody>
											</table>
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



	<!-- footer -->
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>


	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
</body>
</html>