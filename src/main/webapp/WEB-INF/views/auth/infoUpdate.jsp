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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">


<title>Jollery</title>
<style>
.form-group .form-control {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.form-group button {
	height: 40px;
	padding: 0 15px;
}

.form-group select {
	padding: 8px;
}

.col {
	max-width: 65%;
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
					<c:when test="${isArtist == '1'}">
						<%@ include file="/WEB-INF/views/common/sellersidebar.jsp"%>
					</c:when>
					<c:otherwise>
						<%@ include file="/WEB-INF/views/common/sidebar.jsp"%>
					</c:otherwise>
				</c:choose>
				<!-- / sidebar -->

				<!-- Button to trigger modal -->
				<button type="button" id="passwordModalTrigger" data-toggle="modal"
					data-target="#passwordModal" style="display: none;"></button>

				<!-- 비밀번호 확인 모달 -->
				<div class="modal fade" id="passwordModal" tabindex="-1"
					role="dialog" aria-labelledby="passwordModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="passwordModalLabel">비밀번호 확인</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<form id="passwordCheckForm">
									<div class="form-group">
										<label for="password">비밀번호</label> <input type="password"
											class="form-control" id="password" name="password" required>
									</div>
									<br>
									<button type="submit" class="btn btn-light"
										id="submitPasswordCheck">확인</button>
								</form>
								<div id="passwordCheckError" style="display: none; color: red;">비밀번호가
									올바르지 않습니다.</div>
							</div>
						</div>
					</div>
				</div>

				<script>
				document.addEventListener("DOMContentLoaded", function () {
				    const modalTrigger = document.getElementById("passwordModalTrigger");
				    if (modalTrigger) {
				        modalTrigger.click(); // 자동으로 모달 트리거 클릭
				    }
				});
				
				document.addEventListener("DOMContentLoaded", function () {
				    // 비밀번호 확인 폼 제출 이벤트 처리
				    document.getElementById('passwordCheckForm').addEventListener('submit', function (event) {
				        event.preventDefault(); // 폼 제출 시 페이지 리로드 방지
				        const password = document.getElementById('password').value;


				        // 오류 메시지를 초기화 (처음에는 숨김)
				        const errorElement = document.getElementById('passwordCheckError');
				        errorElement.style.display = 'none'; // 오류 메시지 숨기기

				        // AJAX 요청으로 비밀번호 확인
				        fetch('${path}/api/auth/pwCheck', {
				            method: 'POST',
				            headers: {
				                'Content-Type': 'application/json',
				            },
				            body: JSON.stringify({ password })
				        })
				            .then(response => {
				                if (!response.ok) {
				                    throw new Error("HTTP 상태 코드 오류: " + response.status);
				                }
				                return response.json();
				            })
				            .then(data => {
				                console.log("응답 데이터:", data); // 응답 데이터를 콘솔로 확인
				                if (data.success) {
				                    // 비밀번호가 맞으면 모달 닫고 사용자 정보 로드
				                    $('#passwordModal').modal('hide'); // Bootstrap 모달 닫기

				                    // 사용자 정보를 로드하는 함수 호출
				                    loadProfileData();
				                } else {
				                    // 비밀번호가 틀리면 에러 메시지 표시
				                    errorElement.style.display = 'block'; // 오류 메시지 보이기
				                    errorElement.textContent = '비밀번호가 일치하지 않습니다.'; // 오류 메시지 내용 설정
				                }
				            });
				    });
				});
				
				// 사용자 정보를 불러오는 함수
				function loadProfileData() {
				    fetch("${path}/api/auth/profile", {
				        method: "GET",
				        headers: {
				            "Content-Type": "application/json",
				        },
				    })
				        .then(response => {
				            if (!response.ok) {
				                throw new Error("HTTP 상태 코드 오류: " + response.status);
				            }
				            return response.json();
				        })
				        .then(data => {
				            if (data.success) {
				                const profile = data.data;

				                // 데이터 로드 후, 필드에 채우기
				                document.getElementById("username").value = profile.member_login_id;
				                document.getElementById("name").value = profile.member_name;
				                document.getElementById("address-line1").value = profile.member_address;
				                document.getElementById("address-line2").value = profile.member_address_detail;
				                
				                const timestamp = profile.member_birth; // 서버에서 넘어온 타임스탬프
				                const date = new Date(timestamp); // 타임스탬프를 Date 객체로 변환
				             	// YYYY-MM-DD 형식으로 변환
				                const formattedDate = date.toLocaleDateString("en-CA");
				                document.getElementById("birthdate").value = formattedDate;
				                document.getElementById("birthdate").setAttribute("placeholder", formattedDate);
				                
				                const phoneParts = profile.member_phone.split("-");
				                document.getElementById("phone-part1").value = phoneParts[0];
				                document.getElementById("phone-part2").value = phoneParts[1];
				                document.getElementById("phone-part3").value = phoneParts[2];
				                
				                const emailParts = profile.member_email.split("@");
				                document.getElementById("email-prefix").value = emailParts[0];
				                document.getElementById("email-domain").value = emailParts[1];

				                // 사용자 정보가 로드되었으므로 정보 영역을 보이도록 설정
				                //document.getElementById("profile-container").style.display = "block";
				            } else {
				                console.error("회원 정보 조회 실패:", data.message);
				            }
				        })
				        .catch(error => console.error("에러 발생:", error));
				}
				
				</script>



				<div class="col-lg-9" id="container-info">
					<div class="row">
						<div class="col">
							<div class="tab-content" id="myTabContent">
								<!-- 회원정보입력칸 -->
								<div class="container-signup p-4 rounded shadow bg-white">
									<form id="signup-form">
										<!-- 아이디 -->
										<div class="form-group">
											<label for="username">아이디*</label> <input type="text"
												id="username" name="username" class="form-control"
												placeholder="아이디" readonly>
										</div>

										<!-- 비밀번호 -->
										<div class="form-group">
											<label for="newPassword">새비밀번호</label> <input type="password"
												id="newPassword" name="newPassword" class="form-control"
												placeholder="영문 대소문자/숫자/특수문자 중 조합, 8~16자"
												oncopy="return false;" onpaste="return false;"
												oncut="return false;">
										</div>

										<!-- 비밀번호 확인 -->
										<div class="form-group">
											<label for="confirm-newPassword">새비밀번호 확인</label> <input
												type="password" id="confirm-newPassword"
												name="confirm-newPassword" class="form-control"
												placeholder="비밀번호를 다시 입력하세요" oncopy="return false;"
												onpaste="return false;" oncut="return false;">
										</div>

										<!-- 이름 -->
										<div class="form-group">
											<label for="name">이름*</label> <input type="text" id="name"
												name="name" class="form-control" placeholder="이름">
										</div>

										<!-- 생년월일 -->
										<div class="form-group">
											<label for="birthdate">생년월일*</label> <input type="text"
												id="birthdate" class="form-control" placeholder="생년월일">
										</div>
										<!-- flatpickr 스타일과 스크립트 추가 -->
										<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
										<!-- 한글 로케일 파일 추가 -->
										<script
											src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
										<script>
										// 생년월일
										flatpickr("#birthdate", {
									        dateFormat: "Y-m-d", // 원하는 날짜 형식
									        altInput: true, // 사용자 입력 필드를 달력으로 변경
									        altFormat: "F j, Y", // 대체 형식
									        locale: "ko", // 한글 로케일 설정
									    });
										</script>


										<!-- 주소 -->
										<div class="form-group">
											<label for="address-line1">주소*</label>
											<div style="display: flex; align-items: center; gap: 10px;">
												<input type="text" id="address-line1" name="address-line1"
													class="form-control" placeholder="도로명 주소" style="flex: 1;">
												<button type="button" class="btn btn-secondary"
													onclick="execDaumPostcode()">우편번호 검색</button>
											</div>
											<input type="text" id="address-line2" name="address-line2"
												class="form-control" placeholder="상세 주소"
												style="margin-top: 10px;">
										</div>

										<!-- 연락처 -->
										<div class="form-group">
											<label for="phone">연락처*</label>
											<div style="display: flex; gap: 10px;">
												<select id="phone-part1" name="phone-part1"
													class="form-control" style="width: 20%;">
													<option value="010" selected>010</option>
													<option value="011">011</option>
													<option value="016">016</option>
													<option value="019">019</option>
												</select> <input type="text" id="phone-part2" name="phone-part2"
													class="form-control" placeholder="" style="flex: 1;">
												<input type="text" id="phone-part3" name="phone-part3"
													class="form-control" placeholder="" style="flex: 1;">
											</div>
										</div>

										<!-- 이메일 입력 -->
										<div class="form-group">
											<label for="customer-email">이메일*</label>
											<div style="display: flex; align-items: center; gap: 10px;">
												<input type="text" id="email-prefix" name="email-prefix"
													class="form-control" placeholder="Email" style="flex: 1;">
												<span>@</span> <select id="email-domain" name="email-domain"
													class="form-control" style="flex: 1;">
													<option value="naver.com">naver.com</option>
													<option value="gmail.com">gmail.com</option>
													<option value="daum.net">daum.net</option>
													<option value="custom">직접 입력</option>
												</select>
											</div>
											<!-- 직접 입력 필드 -->
											<input type="text" id="custom-email-domain"
												name="custom-email-domain" class="form-control"
												placeholder="직접 입력" style="margin-top: 10px; display: none;">
										</div>
										<br>

										<!-- 회원 수정 버튼 -->
										<button type="button" class="btn btn-light"
											id="updateMemberBtn">회원정보수정</button>

										<!-- 회원 삭제 버튼 -->
										<button type="button" class="btn btn-light"
											id="deleteMemberBtn">회원 삭제</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>
	</section>
	<!-- listing -->


	<!-- footer -->
	<footer class="bg-dark text-white py-0">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</footer>

	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>

	document.getElementById(
					"email-domain")
			.addEventListener(
					"change",
					function() {
						const customField = document
								.getElementById("custom-email-domain");
						if (this.value === "custom") {
							customField.style.display = "block";
						} else {
							customField.style.display = "none";
						}
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
	                console.log("zoneCode:", data.zonecode);
	                console.log("roadAddress:", data.roadAddress);
	                console.log("jibunAddress:", data.jibunAddress);
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
	 document.addEventListener("DOMContentLoaded", function () {
		    // 회원 삭제 버튼 클릭 이벤트 처리
		    document.getElementById('deleteMemberBtn').addEventListener('click', function () {
		        // 비밀번호 확인 요청 (예: 이미 비밀번호 확인 모달에서 비밀번호 입력받음)
		        const password = prompt('비밀번호를 입력하세요');  // 비밀번호 입력 받는 예시 (보안상 비추천, 보완 필요)

		        if (!password) {
		            alert('비밀번호를 입력해야 합니다.');
		            return;
		        }

		        // 비밀번호 확인 (아래는 예시 API 호출)
		        fetch('${path}/api/auth/pwCheck', {
		            method: 'POST',
		            headers: {
		                'Content-Type': 'application/json',
		            },
		            body: JSON.stringify({ password })
		        })
		        .then(response => {
		            if (!response.ok) {
		                throw new Error("비밀번호 확인 오류");
		            }
		            return response.json();
		        })
		        .then(data => {
		            if (data.success) {
		                // 비밀번호 확인 후 회원 삭제 요청
		                fetch('${path}/api/auth/delete', {
		                    method: 'DELETE',
		                    headers: {
		                        'Content-Type': 'application/json',
		                    }
		                })
		                .then(response => {
		                    if (!response.ok) {
		                        throw new Error("회원 삭제 실패");
		                    }
		                    return response.json();
		                })
		                .then(deleteData => {
		                    if (deleteData.success) {
		                        alert(deleteData.message);
		                        // 삭제 후 페이지 리다이렉션 또는 화면 갱신
		                        window.location.href = "/logout";  // 예시: 로그아웃 후 홈페이지로 리다이렉션
		                    } else {
		                        alert(deleteData.message);
		                    }
		                })
		                .catch(error => {
		                    console.error("회원 삭제 중 오류 발생:", error);
		                    alert("회원 삭제 중 오류가 발생했습니다.");
		                });
		            } else {
		                alert("비밀번호가 틀렸습니다.");
		            }
		        })
		        .catch(error => {
		            console.error("비밀번호 확인 중 오류 발생:", error);
		            alert("비밀번호 확인 중 오류가 발생했습니다.");
		        });
		    });
		});
		document.addEventListener('DOMContentLoaded', function () {
	        document.getElementById('updateMemberBtn').addEventListener('click', function () {
	            // 요소 확인 후 처리
	            const getValue = (id) => {
	                const element = document.getElementById(id);
	                return element ? element.value : null;
	            };
	            
	            if (getValue('newPassword') != "") {
	            	let newPassword = getValue('newPassword');
		        	
		    	    // 비밀번호 길이 검사
		    	    if (newPassword.length < 8 || newPassword.length > 16) {
		    	        alert("비밀번호는 8자 이상 16자 이하로 입력해주세요.");
		    	        return;
		    	    }
		    	    
		    	
		    	    // 영문 대소문자, 숫자, 특수문자 조합 검사
		    	    const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,16}$/;
		    	    if (!regex.test(newPassword)) {
		    	        alert("비밀번호는 영문 대소문자/숫자/특수문자 중 조합, 8~16자가 되어야 합니다.");
		    	        return;
		    	    }
		    	    
		    	    // 비밀번호 확인
		    	    let confirmNewPassword = getValue('confirm-newPassword');
		    	    if (newPassword !== confirmNewPassword) {
		    	    	alert("비밀번호가 일치하지 않습니다.");
		    	    	return;
		    	    }
	            }
	            
	    	    
	    	 	// 생년월일
	    	    let birth = getValue('birthdate');
	    	    if (birth == "") {
	    	    	alert("생년월일을 입력해주세요.");
	    	    	return;
	    	    }
	        
	            const phonePart1 = getValue('phone-part1');
	            const phonePart2 = getValue('phone-part2');
	            const phonePart3 = getValue('phone-part3');
	            const phone = `\${phonePart1}-\${phonePart2}-\${phonePart3}`;

	            const emailPrefix = getValue('email-prefix');
	            const emailDomain = getValue('email-domain');
	            const email = `\${emailPrefix}@\${emailDomain}`;

	          

	            // 서버로 보낼 데이터 구성
	            const memberData = {
	                member_password: getValue('newPassword'),
	                member_name: getValue('name'),
	                member_birth: getValue('birthdate'),
	                member_phone: phone,
	                member_address: getValue('address-line1'),
	                member_address_detail:getValue('address-line2'),
	                member_email: email
	            };
	
	            // 데이터 전송
	            fetch('${path}/api/auth/infoUpdate', {
	                method: 'PUT',
	                headers: {
	                    'Content-Type': 'application/json',
	                },
	                body: JSON.stringify(memberData),
	            })
	                .then((response) => response.json())
	                .then((data) => {
	                    if (data.success) {
	                     	// 쿠키에 JWT 저장 (HttpOnly는 서버에서 설정해야 함)
	                        document.cookie = `jwt=\${data.token}; path=/; max-age=7200`; // 2시간 유효
	                        alert('회원 정보가 수정되었습니다.');
	                        location.reload();
	                    } else {
	                        alert('회원 정보 수정에 실패했습니다.');
	                    }
	                })
	                .catch((error) => {
	                    console.error('에러 발생:', error);
	                    alert('서버와의 통신에 실패했습니다.');
	                });
	        });
	    });
</script>

</body>
</html>