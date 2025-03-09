<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%@ include file="chatHeader.jsp"%>
	<div class="layout overflow-hidden">
		<aside class="sidebar bg-light">
			<div class="tab-content h-100" role="tablist">
				<div class="tab-pane fade h-100 show active" id="tab-content-chats"
					role="tabpanel">
					<div class="d-flex flex-column h-100 position-relative">
						<div class="hide-scrollbar">
							<div class="container py-8">
								<div class="mb-8">
									<h2 class="fw-bold m-0">채팅목록</h2>
								</div>
								<div class="card-list" id="chatList"></div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</aside>
		<main class="main">
			<div class="container h-100">
				<div
					class="d-flex flex-column h-100 justify-content-center text-center"
					id="chatContent"></div>
				<!-- 1:1채팅 동적 생성 -->
			</div>
		</main>
	</div>

	<script>
	// dropzone template
    let dzTemplate =
        `<div class="theme-file-preview position-relative mx-2">
		    <div class="avatar avatar-lg dropzone-file-preview">
		        <span class="avatar-text rounded bg-secondary text-body file-title">
		            <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1"><path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path><polyline points="13 2 13 9 20 9"></polyline></svg>
		        </span>
		    </div>
	
		    <div class="avatar avatar-lg dropzone-image-preview">
		        <img src="#" class="avatar-img rounded file-title" data-dz-thumbnail="" alt="" >
		    </div>
	
		    <a class="badge badge-circle bg-danger text-white position-absolute top-0 end-0 m-2" href="#" data-dz-remove="">
	        <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="css-i6dzq1">
	            <line x1="18" y1="6" x2="6" y2="18"></line>
	            <line x1="6" y1="6" x2="18" y2="18"></line>
	        </svg></a>
		</div>`;
	
	let stompClient = null; // stomp client
	let lastMessageDate = null; // 최근 채팅 날짜
	let messageSendId = null; // 메세지 보낸 member_id
	let isSend = false; // 내가 보낸 메세지인지 검사
	let isImage = false; // 이미지 메세지인지 검사
	let imageFormData = new FormData(); // 이미지 처리 FormData
	let messageInputField = null; // 메세지 입력창
	let blockButton = null; // 차단 버튼
	let blockStatus = null; // 차단 상태
	const today = new Date(); // 오늘 날짜
    today.setHours(0, 0, 0, 0); // 시간을 0으로 초기화
	
	getChatRoom();
	
	// 사용자 채팅방 목록 조회
	function getChatRoom() {
	    fetch(`${path}/chatRest/getRoomList`, {
	            method: "GET",
	            headers: {
	                "Content-Type": "application/json"
	            }
	        })
	        .then((response) => response.json())
	        .then(data => {
	        	// 채팅방 목록 조회에 필요한 데이터들(안 읽은 채팅, 썸네일, 최근채팅, 이름 등)
	            let member_id = data.member_id;
	            const chatRoomList = data.chatRoomList;
	            const urlList = data.urlList;
	            const titleList = data.titleList;
	            const recentChatList = data.recentChatList;
	            const nameList = data.nameList;
	            const notReadList = data.notReadList;
	
	            const chatList = document.getElementById("chatList");

	            // 채팅방 목록 없음
	            if (chatRoomList.length === 0) {
	                let card = document.createElement("a");
	                card.className = "card border-0 text-reset";
	
	                let cardBody = `
	                <div class="card-body text-center" style="font-weight: bold; color: black !important;">
	                    <h5 class="me-auto mb-0">현재 생성된 채팅방이 없습니다.</h5>
	                </div>
	            `;
	                card.innerHTML = cardBody;
	                chatList.appendChild(card);
	            } else {
	            	for (let i = 0; i < chatRoomList.length; i++) {
		                // 채팅방
		                let chatRoom = chatRoomList[i];
		
		                // 채팅방 ID
		                let room_id = chatRoom.room_id;
		
		                // 작품 썸네일 
		                let thumbnailUrl = urlList[i];
		                if (thumbnailUrl == null) {
		                    thumbnailUrl = "";
		                }
		                const imgSrc = thumbnailUrl;
		
		                // 작품명
		                let artTitle = titleList[i];
		
		                let recentMessage = null;
		                let recentTime = null;
		                if (!recentChatList[i]) {
		                    recentMessage = "";
		                    recentTime = "";
		                } else {
		                    // 최근 메세지
		                    recentMessage = recentChatList[i].chat_message;
		                    if (recentMessage === "") {
		                        recentMessage = "사진을 보냈습니다."
		                    }
		
		                    // 최근 채팅 시간
		                    recentTime = new Date(recentChatList[i].chat_time);
		                    if (!isNaN(recentTime.getTime())) {
		                        let timeOptions = {
		                            hour: "numeric",
		                            minute: "numeric",
		                            hour12: true,
		                        };
		                        recentTime = recentTime.toLocaleString("ko-KR", timeOptions);
		                    }
		                    
		                 	// 최근 채팅 시간 처리
		                    recentTime = new Date(recentChatList[i].chat_time);
		                    if (!isNaN(recentTime.getTime())) {
		                        if (recentTime >= today) {
		                            // 오늘 날짜라면 시간 표시
		                            let timeOptions = {
		                                hour: "numeric",
		                                minute: "numeric",
		                                hour12: true,
		                            };
		                            recentTime = recentTime.toLocaleString("ko-KR", timeOptions);
		                        } else {
		                            // 오늘이 아니라면 날짜 표시
		                            let dateOptions = {
		                                month: "long",
		                                day: "numeric",
		                            };
		                            recentTime = recentTime.toLocaleString("ko-KR", dateOptions);
		                        }
		                    }
		                    
		                }
		
		                // 채팅 상대방 이름
		                let chatPartnerName = nameList[i];
		
		                // 안 읽은 채팅
		                let notRead = notReadList[i];
		
		                // 채팅방 생성
		                let card = document.createElement("a");
		                card.href = "javascript:void(0)";
		
		                card.className = "card border-0 text-reset";
		
		                let cardBody = `
		   	                <div class="card-body">
		   	                    <div class="row gx-5">
		   	                    	<div class="col-auto">
		                           		<div class="avatar">
		                               		<img src="\${imgSrc}" alt="" class="avatar-img">
		                           		</div>
		                       		</div>
		   	                        <div class="col">
		   	                            <div class="d-flex align-items-center mb-3">
		   	                                <h5 class="me-auto mb-0"git >\${artTitle} / \${chatPartnerName}</h5>
		   	                                <span class="text-muted extra-small ms-2">\${recentTime}</span>
		   	                            </div>
		   	                            <div class="d-flex align-items-center">
		   	                                <div class="line-clamp me-auto">
		   	                                    \${recentMessage}
		   	                                </div>\${notRead !== 0 ? ` <div class = "badge badge-circle bg-primary ms-5">
		                    				<span>\${notRead} </span> </div>` : ''}
		   	                            </div>
		   	                        </div>
		   	                    </div>
		   	                </div>
		   	            `;
		                card.innerHTML = cardBody;
		                chatList.appendChild(card);
		                card.addEventListener("click", function() {
		                    chatDirectPage(room_id, member_id, thumbnailUrl, artTitle, chatPartnerName);
		                });
		            }
	            }          
	        });
	}
	
	// 1:1 채팅 이동
	function chatDirectPage(room_id, member_id, thumbnailUrl, artTitle, chatPartnerName) {
	    $.ajax({
	        url: `${path}/chatDirect`,
	        method: "GET",
	        data: {
	            room_id,
	            member_id,
	            thumbnailUrl,
	            artTitle,
	            chatPartnerName
	        },
	        success: function(responseHtml) {
	            $("#chatContent").html(responseHtml);
	        }
	    });
	}
	</script>

</body>
</html>