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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.css"
	integrity="sha512-7uSoC3grlnRktCWoO4LjHMjotq8gf9XDFQerPuaph+cqR7JC9XKGdvN+UwZMC14aAaBDItdRj3DcSDs4kMWUgg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.3/dropzone.js"
	integrity="sha512-9e9rr82F9BPzG81+6UrwWLFj8ZLf59jnuIA/tIf8dEGoQVu7l5qvr02G/BiAabsFOYrIUTMslVN+iDYuszftVQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- 스마트 에디터 JS -->
<script type="text/javascript"
	src="<c:url value='/resources/smarteditor2/js/HuskyEZCreator.js' />">	charset="utf-8"></script>


<title>Jollery</title>
<style type="text/css">
#ir1 {
	width: 99%; /* 원하는 너비로 설정 */
	margin: 0 auto; /* 가운데 정렬 (선택사항) */
}

.dropzone {
	width: 885px;
}

.dropzone.dz-started .dz-message {
	display: block !important;
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
	background-color: #28a745;
	color: #fff;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: 14px;
}

.tool_area .BaseButton:hover {
	background-color: #218838;
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
	/*overflow: auto; 스크롤이 필요한 경우 나타나도록 */
	overflow: hidden; /* 부모 요소를 초과하지 않도록 */
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

								<!-- 작품 등록 -->

								<div class="tab-pane fade show active" id="sidebar-1-4"
									role="tabpanel" aria-labelledby="sidebar-1-4">


									<div class="WritingHeader">
										<h2 class="title">작품 등록</h2>
										<div class="tool_area">
											<a onclick="artsubmit()" type="button" class="BaseButton"
												style="background-color: #1f3269 !important; color: white;">등록</a>
										</div>

									</div>
									<!-- 내용 영역 -->
									<div class="WritingContent">
										<div>
											<div class="form-group category-row"
												style="margin: 5px; margin-bottom: 10px;">
												<select onchange="mini(this)" required="required"
													id="category" name="categories">
													<option value="-1">카테고리 선택</option>
													<c:forEach var="category" items="${categories}">
														<option value="${category.category_id}">${category.category_type}</option>
													</c:forEach>
												</select> <select required="required" id="subcategory"
													name="minicategories">
													<option value="-1">상세 카테고리 선택</option>
												</select>
											</div>
											<div class="form-group" style="margin: 5px;">
												<input type="text" required="required" id="title"
													placeholder="작품명을 입력해 주세요.">
											</div>
											<div class="form-group price-and-size">
												<div class="price-wrapper" style="margin: 5px;">
													<input type="number" required="required" id="price"
														placeholder="가격을 입력해 주세요." min="0"> <span
														class="suffix">원</span>
												</div>
												<div class="size-wrapper" style="margin: 5px;">
													<input type="text" id="size" placeholder="크기를 입력해 주세요.">
													<span class="suffix">(가로x세로x높이)</span>
												</div>
											</div>
											<div class="form-group" style="margin: 5px;">
												<label>내용을 입력하세요.</label>
												<!-- 스마트 에디터 텍스트 영역 -->
												<script>
												window.onload = function(){aa();};
												
												</script>
												<textarea name="ir1" id="ir1" rows="10" cols="100"></textarea>
											</div>

										</div>
										<div class="container mt-3">
											<div id="myfrm" style="margin-left: -10px; width: 865px;"
												class="dropzone" enctype="multipart/form-data">
												<div class="input-group mb-3" id="dropZone"></div>
											</div>
										</div>
										<div class="mt-2" style="color: #6c757d; font-size: 14px;">
											<span style="font-weight: bold; color: #6c757d;">⚠</span>
											'썸네일 이미지2'는 썸네일에서 사용되는 호버링 이미지로, 마우스를 올릴 때만 표시됩니다. <br>해당
											이미지는 게시글 본문에는 표시되지 않습니다. 게시글 내용에 사용될 이미지는 다른 업로드 옵션을 선택해 주세요.
										</div>
										<script
											src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>


										<script>

  let filelist = [];

  const imageIndex = ["썸네일", "썸네일2", "이미지1", "이미지2", "이미지3", "이미지4"]; // 한글 이름 배열



Dropzone.options.myfrm = {

    url: "${path}/board/insertdrop.do",

    method: "post",

    paramName: "pic",

    maxFiles: 6, // 파일 최대 개수 제한

    dictDefaultMessage: "1개이상 6개이하로 사진을 올려주세요",

    autoProcessQueue: false,

    clickable: "#dropZone",

    createImageThumbnails: true,

    previewsContainer: null,

    thumbnailHeight: 120,

    thumbnailWidth: 120,

    init: function (){ window.onbeforeunload = null; },

    addedfile: function (res) {

      if (filelist.length >= imageIndex.length) {

        alert(`최대 \${imageIndex.length}개의 파일만 업로드할 수 있습니다.`);

        return;

      }





      filelist.push(res);



      if (res.type.startsWith("image/")) {

        let reader = new FileReader();

        reader.onload = (e) => {

          const previewTemplate = `

            <div class="dz-preview dz-file-preview" style="display: inline-block; margin: 10px;" data-name="\${res.name}">

              <div class="dz-image" style="width: 120px; height: 120px; overflow: hidden; border: 1px solid #ddd; border-radius: 4px;">

                <img src="\${e.target.result}" alt="" style="width: 100%; height: auto;">

              </div>

              <div class="dz-details">

                <div class="dz-filename"><span></span></div>

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



          // Remove Button Click Event

          const removeButton = document.querySelector("#dropZone .dz-preview:last-child .remove-btn");

          removeButton.addEventListener("click", function (event) {

            event.stopPropagation(); // Dropzone 기본 동작 방지

            event.preventDefault();



            // Remove the file from filelist

            const fileIndex = filelist.findIndex((f) => f.name === res.name);

            if (fileIndex > -1) {

              filelist.splice(fileIndex, 1);

            }



            // Remove the preview element

            this.closest(".dz-preview").remove();

          });



          updatePreviewNames(); // 이름 업데이트

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



  // Sortable.js 적용

  document.addEventListener("DOMContentLoaded", function () {

    const dropZone = document.querySelector("#dropZone");



    new Sortable(dropZone, {

      animation: 150,

      onEnd: function () {

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


</script>
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
	<!-- 네이버 에디터 2.0 -->
	<script>
	 
	    var oEditors = [];
	    
/* 	    $(function(){
	    	aa();
	    }); */
	    
	    
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
		

		async function artsubmit() {
		    try {
		        // 입력값 가져오기
		        const category = document.getElementById('category').value;
		        const subcategory = document.getElementById('subcategory').value;
		        const title = document.getElementById('title').value;
		        const price = document.getElementById('price').value;
		        const size = document.getElementById('size').value;
		        const smartEditorContent = oEditors.getById["ir1"].getIR(); // 스마트 에디터 내용 가져오기

		        /* const previews = document.querySelectorAll("#dropZone .dz-preview");
		        const uploadedFiles = previews.length; // Dropzone의 업로드된 파일 개수 */
		        
		     // 필수 입력값 확인
		        if (category === "-1" || subcategory === "-1" || title === "" || price === ""/*  || uploadedFiles === 0 */) { // 이미지가 없는 경우
		            alert("카테고리, 상세 카테고리, 작품명, 가격, 이미지는 필수 항목입니다.\n\n입력 후 다시 등록해주세요.");
		            return; // 함수 종료
		        }

		        // FormData 객체 생성
		        const formData = new FormData();
	
		        // 작품 정보 추가
		        formData.append("category", category);
		        formData.append("subcategory", subcategory);
		        formData.append("title", title);
		        formData.append("price", price);
		        formData.append("size", size);
		        formData.append("smartEditorContent", smartEditorContent);
		        formData.append("userId",${userId});

		        // Dropzone에서 업로드된 파일 추가
		        const previews = document.querySelectorAll("#dropZone .dz-preview");
		        previews.forEach((item, index) => {
		            const fileName = item.getAttribute("data-name");
		            const file = filelist.find((f) => f.name === fileName);

		            if (file) {
		                const letter = imageIndex[index]; // 역할 이름 (썸네일, 이미지1 등)
		                formData.append("files", file); // 파일 추가
		                formData.append("letters", letter); // 역할 이름 추가
		            }
		        });

		        console.log("폼 데이터:", formData);
		       
		        // 서버로 데이터 전송
		        const response = await fetch('<c:url value="/art/insert" />', {
		            method: 'POST',
		            body: formData,
		        });

		        const result = await response.json();
			
		        if (response.ok && result.status === "success") {
					  window.addEventListener("beforeunload", function (event) {
					  event.preventDefault();
					  event.returnValue = ""; // 이 코드로 인해 경고 메시지가 표시됨
					});
		            alert("작품 등록이 완료되었습니다.");
		           
		            window.location.href = " <c:url value="/sale/list" />";
		        } else {
		            alert(result.message || "등록에 실패했습니다. 다시 시도해주세요.");
		        }
		    } catch (error) {
		        console.error("에러 발생:", error);
		        alert("문제가 발생했습니다. 다시 시도해주세요.");
		    }
		}

	</script>

</body>
</html>
