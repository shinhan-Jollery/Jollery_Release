<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no">

<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/vendor.css' />" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/css/style.css' />" />

<!-- 스마트 에디터 JS -->
<script type="text/javascript"
	src="${path}/resources/se2/js/service/HuskyEZCreator.js"
	src="${path}/resources/se2/js/service/SE2BasicCreator.js"
	charset="utf-8"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.css"
	integrity="sha512-7uSoC3grlnRktCWoO4LjHMjotq8gf9XDFQerPuaph+cqR7JC9XKGdvN+UwZMC14aAaBDItdRj3DcSDs4kMWUgg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.js"
	integrity="sha512-9e9rr82F9BPzG81+6UrwWLFj8ZLf59jnuIA/tIf8dEGoQVu7l5qvr02G/BiAabsFOYrIUTMslVN+iDYuszftVQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>

<title>Jollery</title>
<style>
#ir1 {
	width: 99%; /* 원하는 너비로 설정 */
	margin: 0 auto; /* 가운데 정렬 (선택사항) */
}
/* 기본적으로 서브메뉴 숨기기 */
.submenu {
	display: none;
	opacity: 0;
	transition: opacity 0.3s ease-in-out;
	background-color: #f8f9fa;
	border: 1px solid #ddd;
	margin-top: 5px;
	border-radius: 5px;
	padding: 0;
}
/* 판매자 페이지에 마우스 올리면 서브메뉴 표시 */
.seller:hover .submenu {
	display: block;
	opacity: 1;
}
/* 서브메뉴 항목 스타일 */
.submenu a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: #333;
	transition: all 0.2s ease-in-out;
}
/* 호버 시 스타일 */
.submenu a:hover {
	background-color: #ddd;
	color: #333;
}
/* 활성화 시 슬라이드 다운 */
.nav-link.seller:hover .submenu {
	display: block;
	opacity: 1;
	max-height: 500px; /* 적절히 큰 값 */
	padding: 10px;
}

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
/* 추가 */
.WritingHeader {
	margin-bottom: 20px;
	border-bottom: 2px solid #323232;
	padding-bottom: 10px;
}

.WritingHeader .title {
	font-size: 24px;
	font-weight: bold;
}

.tool_area {
	margin-top: 10px;
	text-align: right;
}

.tool_area .BaseButton {
	text-decoration: none;
	display: inline-block;
	background-color: #1f3269 !important;
	color: #fff !important;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: 14px;
}

.tool_area .BaseButton:hover {
	background-color: #1a2561;
}

.WritingContent {
	background-color: #fff;
	padding: 30px;
	border: 1px solid #e5e5e5;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 15px;
	overflow: auto; /* 스크롤이 필요한 경우 나타나도록 */
}

input {
	border: 0px;
}

.form-group label {
	/* display: block; */
	font-size: 14px;
	font-weight: bold;
	margin-bottom: 5px;
}

.form-group textarea, .form-group select {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border: 1px solid #dcdcdc;
	border-radius: 10px;
}

.form-group input {
	width: 100%;
	padding: 10px;
	font-size: 14px;
	border-radius: 10px;
}

.form-group #description {
	resize: vertical;
	height: 300px;
}

.form-group .btn-upload {
	background-color: #007bff;
	color: #fff;
	padding: 10px 15px;
	border: none;
	border-radius: 10px;
	cursor: pointer;
}

.form-group .btn-upload:hover {
	background-color: #0056b3;
}

.form-group #title, .form-group #price, .form-group #size {
	background-color: #efefef;
}

.category-row {
	display: flex;
	gap: 10px;
}

.form-group.price-and-size {
	display: flex;
	gap: 10px;
}

.price-wrapper, .size-wrapper {
	display: flex;
	align-items: center;
	background-color: #efefef;
	/* padding: 10px; */
	border-radius: 10px;
	flex: 1;
}

.price-wrapper input, .size-wrapper input {
	border: none;
	background: none;
	flex: 1;
	font-size: 14px;
}

.price-wrapper .suffix, .size-wrapper .suffix {
	margin-left: 10px;
	margin-right: 15px;
	white-space: nowrap;
	font-size: 14px;
	color: #333;
	white-space: nowrap;
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

								<!-- 작품 정보 수정 -->
								<input type="hidden" id="art_id" name="art_id"
									value="${artInfo.art_id}">
								<div class="tab-pane fade show active" id="sidebar-1-5"
									role="tabpanel" aria-labelledby="sidebar-1-5">
									<div class="WritingHeader">
										<h2 class="title">작품 정보 수정</h2>
										<div class="tool_area">
											<a onclick="artupdate()" type="button" class="BaseButton"
												style="background-color: #1f3269 !important; color: white;">수정</a>

											<a onclick="artdelete()" type="button" class="BaseButton"
												style="background-color: #1f3269 !important; color: white !important;">삭제</a>
										</div>


									</div>
									<div class="WritingContent">
										<form action="update.do" method="post">
											<div class="form-group category-row" style="margin: 10px;">
												<select onchange="mini(this)" required="required"
													id="category" name="categories">
													<option value="${categoryDTO.category_id}">${categoryDTO.category_type}</option>
													<c:forEach var="category" items="${categories}">
														<option value="${category.category_id}">${category.category_type}</option>
													</c:forEach>
												</select> <select required="required" id="subcategory"
													name="minicategories">
													<option value="${minicategoryDTO.mini_category_id}">${minicategoryDTO.mini_category_type}</option>
												</select>
											</div>
											<div class="form-group" style="margin: 10px;">
												<input type="text" required="required" id="title"
													value="${artInfo.art_title}" placeholder="작품명을 입력해 주세요.">
											</div>
											<div class="form-group price-and-size" style="margin: 10px;">
												<div class="price-wrapper">
													<input type="number" required="required" id="price"
														value="${artInfo.art_price}" placeholder="가격을 입력해 주세요."
														min="0"> <span class="suffix">원</span>

												</div>



												<div class="size-wrapper">
													<input type="text" id="size" value="${artInfo.art_size}"
														placeholder="크기를 입력해 주세요.">
													<!-- 칸이 비어있으면 "크기를 입력해주세요" 문자가 표시됨 -->
													<!-- 비어있지 않으면 이미 넣어있는 문자가 출력 -->
													<span class="suffix">(가로x세로x높이)</span>
												</div>
											</div>
											<div class="form-group art_status" style="margin: 10px;">
												<label>배송 상태를 업데이트하세요.</label>
												<!-- 구매자가 결제를 완료해야 목록이 뜨도록 설정 -->
												<select required="required" id="status" name="status">
													<option value="${artInfo.art_status}">현재 상태 :
														${artInfo.art_status}</option>
													<option>판매중</option>
													<option>결제완료</option>
													<option>배송중</option>
													<option>판매완료</option>
												</select>
											</div>
											<div class="form-group" style="margin: 5px;">
												<label>내용을 입력하세요.</label>
												<!-- 스마트 에디터 텍스트 영역 -->
												<script>
												window.onload = function(){aa();};
												
												</script>
												<textarea name="ir1" id="ir1" rows="10" cols="100">${artInfo.art_description}</textarea>
											</div>
											<div class="container mt-3">
												<div id="myfrm" class="dropzone"
													enctype="multipart/form-data">
													<div class="input-group mb-3" id="dropZone"></div>
												</div>
											</div>
											<div class="mt-2" style="color: #6c757d; font-size: 14px;">
												<span style="font-weight: bold; color: #6c757d;">⚠</span>
												'썸네일 이미지2'는 썸네일에서 사용되는 호버링 이미지로, 마우스를 올릴 때만 표시됩니다. <br>해당
												이미지는 게시글 본문에는 표시되지 않습니다. 게시글 내용에 사용될 이미지는 다른 업로드 옵션을 선택해
												주세요.
											</div>
										</form>

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
	<footer>
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</footer>

	<script src="<c:url value='/resources/assets/js/vendor.min.js' />"></script>
	<script src="<c:url value='/resources/assets/js/app.js'/>"></script>
	<!-- 네이버 에디터 2.0 -->
	<script>
	var oEditors = [];
		function aa() {
			/* alert("aa"); */
			
			console.log("스마트에디터 초기화 시작");
			nhn.husky.EZCreator
					.createInIFrame({
						oAppRef : oEditors,
						elPlaceHolder : "ir1",
						sSkinURI : "${path}/resources/se2/SmartEditor2Skin.html",
						fCreator : "createSEditor2"
					});
			console.log("스마트에디터 초기화 완료");
		}
		
		function mini(selectElement) {
		        const categoryId = $(selectElement).val(); // 선택된 카테고리 ID 가져오기
				console.log('1', categoryId);
		        // 대분류가 선택되지 않았을 경우 초기화
		        if (categoryId === "-1") {
		            $('#subcategory').html('<option value="-1">상세 카테고리 선택</option>');
		            return;
		        }
		        // Ajax 요청
		        $.ajax({
		            url: '${path}/art/api/insert', // RestController에서 매핑된 URL
		            type: 'GET',
		            data: { category_id: categoryId }, // 선택된 category_id 전달
		            success: function(response) {
		            	console.log(response);
		                // 상세 카테고리 초기화
		               $('#subcategory').html('<option value="-1">상세 카테고리 선택</option>');
		                // 상세 카테고리 추가
		                response.forEach(function(subCategory) {
		                    $('#subcategory').append(
		                        `<option value="\${subCategory.mini_category_id}">\${subCategory.mini_category_type}</option>`
		                    );
		                });
		            },
		            error: function() {
		                alert('상세 카테고리를 불러오는 중 문제가 발생했습니다.');
		            }
		        });
		}
		
		</script>

	<script>
	async function artupdate() {
		    const art_id = document.getElementById("art_id").value; // 숨겨진 필드에서 가져오기
		    /* const category = document.getElementById('category').value; */
		    const subcategory = document.getElementById('subcategory').value;
		    const title = document.getElementById('title').value;
		    const price = document.getElementById('price').value;
		    const smartEditorContent = oEditors.getById["ir1"].getIR(); // 에디터 내용 가져오기
		    const status = document.getElementById('status').value;
		    const size = document.getElementById('size').value;

		    // FormData 객체 생성
		    const formData = new FormData();
		    formData.append("category", category);
		    formData.append("subcategory", subcategory);
		    formData.append("title", title);
		    formData.append("price", price);
		    formData.append("size", size);
		    formData.append("smartEditorContent", smartEditorContent);
		    formData.append("userId", `${userId}`);
		    formData.append("status", status);
		    


		    const previews = document.querySelectorAll("#dropZone .dz-preview");

		    previews.forEach(async (item, index) => {
		        const fileName = item.getAttribute("data-name"); // 파일 이름 가져오기
		        const imgElement = item.querySelector("img"); // 이미지 태그 가져오기
		        const imgSrc = imgElement.src; // 이미지 URL 가져오기

		        // filelist에서 파일 검색
		        let file = filelist.find((f) => f.name === fileName);

		        if (!file) {
		            try {
		                // URL에서 이미지 데이터를 가져와 Blob으로 변환
		                const response = await fetch(imgSrc, {
						    method: 'GET',
						    mode: 'no-cors', // no-cors 모드 추가
						});
		                if (!response.ok) {
		                    throw new Error(`이미지를 가져오는 데 실패했습니다. 상태 코드: \${response.status}`);
		                }
		                const blob = await response.blob();

		                // Blob을 File 객체로 변환
		                file = new File([blob], fileName, { type: blob.type });

		                // filelist에 추가
		                filelist.push(file);

		                console.log("URL에서 가져온 이미지 추가:", file);
		            } catch (error) {
		                console.error("이미지 변환 중 오류 발생:", error);
		            }
		        }

		        if (file instanceof File) {
		            // FormData에 파일 및 역할 추가
		            const letter = imageIndex[index]; // 역할 이름 (썸네일, 이미지1 등)
		            formData.append("files", file); // 파일 추가
		            formData.append("letters", letter); // 역할 이름 추가

		            console.log("업로드된 이미지 추가:", file);
		        } else {
		            console.error("파일 객체가 아닌 데이터가 발견되었습니다:", file);
		        }
		    });

		    // FormData 디버깅 출력
		    for (let key of formData.keys()) {
		        console.log(key, ":", formData.get(key));
		    }

		    
		    const url = `<c:url value="/art/${art_id}/update" />`;
		    try {
		        // 서버로 데이터 전송
		        const response = await fetch(url, {
		            method: 'POST',
		            body: formData,
		        });

		        const result = await response.json();

		        if (response.ok && result.status === "success") {
		            window.addEventListener("beforeunload", function (event) {
		                event.preventDefault();
		                event.returnValue = "";
		            });
		            alert("작품 수정이 완료되었습니다.");
		            
		            window.location.href = "<c:url value="/sale/list" />";
		        } else {
		            alert(result.message || "등록에 실패했습니다. 다시 시도해주세요.");
		        }
		    } catch (error) {
		        console.error("에러 발생:", error);
		        alert("문제가 발생했습니다. 다시 시도해주세요.");
		    }
		}
</script>
	<script>
		function artdelete(art_id){
		    var returnValue = confirm('정말 삭제하시겠습니까?');
		    
		    if (!returnValue) {
		        return;  // 삭제 요청 실행 안 함
		    }

		    // 삭제 요청 URL에 art_id를 동적으로 추가
			
		    const url = `<c:url value="/art/delete/${art_id}" />`;

		    fetch(url, {
		        method: 'PUT',
		        headers: {
		            'Content-Type': 'application/json',
		        }
		    })
		    .then((response) => response.json()) // 상태 코드와 상관없이 JSON 파싱
		    .then((data) => {
		        console.log('서버 응답 데이터:', data);

		        if (data.status === 'success') {
		            alert('작품 삭제가 완료되었습니다.');
		            // 페이지를 새로 고침하거나 다른 화면으로 이동
		            window.location.href = '${path}/main';  //메인 페이지 보내기
		        } else {
		            alert('삭제에 실패했습니다. 다시 시도해주세요.');
		        }
		    })
		    .catch((error) => {
		        console.error('에러 발생:', error);
		        alert('문제가 발생했습니다. 다시 시도해주세요.');
		    });

		}
		
	</script>
	<script>
	let filelist = [];
	const imageIndex = ["썸네일", "썸네일2", "이미지1", "이미지2", "이미지3", "이미지4"];
	Dropzone.options.myfrm = {
	  url: "${path}/board/insertdrop.do", // 사용x
	  method: "post",
	  paramName: "pic",
	  maxFiles: 6,
	  dictDefaultMessage: "1개 이상 6개 이하로 사진을 올려주세요.",
	  autoProcessQueue: false,
	  clickable: "#dropZone",
	  createImageThumbnails: true,
	  previewsContainer: "#dropZone",
	  thumbnailHeight: 120,
	  thumbnailWidth: 120,
	  init: async function () {
	    // 기존 이미지 URL 배열
	    const existingImages = [
	      "${artInfo.art_thumbnail_image}",
	      "${artInfo.art_hovering_image}",
	      "${artInfo.art_image2}",
	      "${artInfo.art_image3}",
	      "${artInfo.art_image4}",
	      "${artInfo.art_image5}",
	    ];

	    const dropzoneInstance = this;

	    // 기존 이미지를 Dropzone에 추가
	    for (let index = 0; index < existingImages.length; index++) {
	      const imageUrl = existingImages[index];
	      if (imageUrl) {
	        try {
	          // URL에서 Blob 가져오기
	          const response = await fetch(imageUrl, {
				    method: 'GET',
				    mode: 'no-cors', // no-cors 모드 추가
				});
	          const blob = await response.blob();

	          // Blob을 File 객체로 변환
	          const fileName = `이미지\${index + 1}`;
	          const file = new File([blob], fileName, { type: blob.type });

	          // Dropzone 미리보기 추가
	          const previewTemplate = `
	            <div class="dz-preview dz-file-preview" style="display: inline-block; margin: 10px;" data-name="\${fileName}">
	              <div class="dz-image" style="width: 120px; height: 120px; overflow: hidden; border: 1px solid #ddd; border-radius: 4px;">
	                <img src="\${imageUrl}" alt="\${fileName}" style="width: 100%; height: 100%; object-fit: cover;">
	              </div>
	              <div class="dz-details">
	                <div class="dz-filename"><span>\${fileName}</span></div>
	              </div>

	              <button class="remove-btn"
						style="background: #6c6262ab; 
						color: #fff; border: none;
						border-radius: 5px; padding: 5px 10px; 
						cursor: pointer; margin-top: 10px; 
						display: block; 
						width: 32px;
						margin-left: auto;
	margin-right: auto;">x</button>
	            </div>
	          `;
	          document.querySelector("#dropZone").insertAdjacentHTML("beforeend", previewTemplate);

	          // 파일 리스트에 추가
	          filelist.push(file);

	          // 제거 버튼 이벤트 추가
	          const removeButton = document.querySelector("#dropZone .dz-preview:last-child .remove-btn");
	          removeButton.addEventListener("click", function (event) {
	            event.stopPropagation();
	            event.preventDefault();

	            const fileIndex = filelist.findIndex((f) => f.name === fileName);
	            if (fileIndex > -1) {
	              filelist.splice(fileIndex, 1);
	            }
	            this.closest(".dz-preview").remove();
	            updatePreviewNames();
	          });
	        } catch (error) {
	          console.error(`이미지 로드 실패: \${imageUrl}`, error);
	        }
	      }
	    }
	    updatePreviewNames(); // 이름 업데이트
	  },
	  addedfile: function (res) {
	    if (filelist.length >= imageIndex.length) {
	      alert(`최대 \${imageIndex.length}개의 파일만 업로드할 수 있습니다.`);
	      return;
	    }
	    filelist.push(res);
	    if (res.type && res.type.startsWith("image/")) {
	      const reader = new FileReader();
	      reader.onload = (e) => {
	        const previewTemplate = `
	          <div class="dz-preview dz-file-preview" style="display: inline-block; margin: 10px;" data-name="\${res.name}">
	            <div class="dz-image" style="width: 120px; height: 120px; overflow: hidden; border: 1px solid #ddd; border-radius: 4px;">
	              <img src="\${e.target.result}" alt="" style="width: 100%; height: 100%; object-fit: cover;">
	            </div>
	            <div class="dz-details">
	              <div class="dz-filename"><span>\${res.name}</span></div>
	            </div>
	            <button class="remove-btn"
					style="background: #6c6262ab; 
					color: #fff; border: none;
					border-radius: 5px; padding: 5px 10px; 
					cursor: pointer; margin-top: 10px; 
					display: block; 
					width: 32px;
					margin-left: auto;
					margin-right: auto;">x</button>
	          </div>
	        `;
	        document.querySelector("#dropZone").insertAdjacentHTML("beforeend", previewTemplate);

	        const removeButton = document.querySelector("#dropZone .dz-preview:last-child .remove-btn");
	        removeButton.addEventListener("click", function (event) {
	          event.stopPropagation();
	          event.preventDefault();

	          const fileIndex = filelist.findIndex((f) => f.name === res.name);
	          if (fileIndex > -1) {
	            filelist.splice(fileIndex, 1);
	          }
	          this.closest(".dz-preview").remove();
	          updatePreviewNames();
	        });
	        updatePreviewNames();
	      };
	      reader.readAsDataURL(res);
	    } else {
	      alert("이미지 파일만 미리보기를 지원합니다.");
	    }
	  },
	  success: function (responseData) {
	    console.log(responseData);
	  },
	};

</script>

	<script>
  // 미리보기 이름 업데이트 함수
  function updatePreviewNames() {
    const previews = document.querySelectorAll("#dropZone .dz-preview");
    previews.forEach((item, index) => {
      const imgElement = item.querySelector(".dz-image img");
      const nameElement = item.querySelector(".dz-filename span");
      if (imgElement && nameElement) {
        const letter = imageIndex[index]; // 한글 배열에서 해당 인덱스의 글자 가져오기
        imgElement.alt = `\${letter}`;
        nameElement.textContent = `\${letter}`;
      }
    });
  }
  // Sortable.js 적용
document.addEventListener("DOMContentLoaded", function () {
  const dropZone = document.querySelector("#dropZone");
    new Sortable(dropZone, {
      animation: 150,
      onEnd: function (evt) {
        const reorderedList = [];
        document.querySelectorAll("#dropZone .dz-preview").forEach((item) => {
          const fileName = item.getAttribute("data-name");
          const file = filelist.find((f) => f.name === fileName);
          if (file) reorderedList.push(file);
        });
        filelist = reorderedList;
        updatePreviewNames(); // 순서 변경 후 이름 업데이트
      },
    });
  });

</script>
</body>
</html>