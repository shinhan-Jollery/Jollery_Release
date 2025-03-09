<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
	<%@ include file="chatHeader.jsp"%>
	<div class="d-flex flex-column h-100 position-relative"
		data-dropzone-area="">
		<div class="chat-header border-bottom py-4 py-lg-7">
			<div class="row align-items-center">
				<div class="d-flex justify-content-center">
					<h5 class="text-truncate mb-0" id="chatPartnerName"
						style="font-weight: bold;">chatPartnerName</h5>
				</div>
				<div class="col-auto">
					<img id="thumbnail" src="" class="chat-photo rounded-circle">
				</div>
				<div class="col-auto text-center">
					<h4 class="text-truncate mb-0" id="artTitle">artTitle</h4>
				</div>
				<div class="col-auto ms-auto">
					<button class="blockButton" id="blockButton">block</button>
				</div>

			</div>
		</div>
		<main>
			<div class="chat-messages p-4 p-lg-6" id="chat-messages">
				<!-- 채팅 동적 생성 -->
			</div>
		</main>
		<!-- 채팅 footer -->
		<footer>
			<div
				class="chat-footer pb-3 pb-lg-7 position-absolute bottom-0 start-0">
				<!-- 이미지 미리보기 -->
				<div class="dz-preview bg-dark" id="dz-preview-row"
					data-horizontal-scroll=""></div>
				<div class="chat-container">
					<!-- 채팅 폼 -->
					<form class="chat-form rounded-pill bg-dark"
						onsubmit="return false;">
						<div class="row align-items-center gx-0">
							<div class="col-auto">
								<!-- 파일 전송 -->
								<div class="btn btn-icon btn-link text-body rounded-circle"
									id="dz-btn">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="black"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-paperclip">
                        <path
											d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48">
                        </path>
                    </svg>
								</div>
							</div>

							<!-- "메세지 보내기" -->
							<div class="col">
								<div class="input-group">
									<textarea id="messageInput" class="form-control px-0"
										placeholder="메세지 보내기" rows="1" data-autosize="true"></textarea>
								</div>
							</div>

							<!-- 전송 버튼 -->
							<div class="col-auto">
								<button class="btn btn-icon btn-primary rounded-circle ms-5"
									id="send-btn" onclick="sendMessage()">
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round" class="feather feather-send">
                        <line x1="22" y1="2" x2="11" y2="13"></line>
                        <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                    </svg>
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</footer>
	</div>

	<script>
    room_id = `${param.room_id}`;
	member_id = `${param.member_id}`;
	thumbnailUrl = `${param.thumbnailUrl}`;
	artTitle = `${param.artTitle}`;
	chatPartnerName = `${param.chatPartnerName}`;
	
	enterChatRoom(room_id, member_id);
	
	// 차단한 상대이거나 차단당했다면 대화 불가, 차단버튼 상태 변경
	blockButton = document.getElementById("blockButton");
	fetch(`${path}/chatRest/checkBlock/\${room_id}`, {
		method: "GET"
	})
    .then(response => response.json())
    .then(isBlock => {
        if (isBlock) {
            blockStatus = true;
            blockButton.textContent = "차단 해제";

            // 대화불가
            let messageInput = document.getElementById("messageInput");
            messageInput.value = "대화가 불가능합니다.";
            messageInput.setAttribute("readonly", true);

            // 전송불가
            let sendButton = document.getElementById('send-btn');
            sendButton.setAttribute("disabled", true);
        } else {
            blockStatus = false;
            blockButton.textContent = "차단";
        }
    })
    .catch(error => {
        console.error("Error:", error);
    });
	
	blockButton.addEventListener("click", function() {
	    if (blockStatus) {
	        unblock();
	    } else {
	        block();
	    }
	
	});
	
	// 기존 Dropzone 인스턴스 제거
	Dropzone.autoDiscover = false;
	if (Dropzone.instances.length > 0) {
	    Dropzone.instances.forEach(instance => instance.destroy());
	}
	
	// dropzone 이미지 파일 처리
	if (document.querySelector('[data-dropzone-area]')) {
	    mydropzone = new Dropzone('[data-dropzone-area]', {
	        url: `${path}/chatRest/uploadFiles`,
	        clickable: "#dz-btn",
	        previewsContainer: "#dz-preview-row",
	        previewTemplate: dzTemplate,
	        parallelUploads: 3,
	        autoProcessQueue: false,
	    });
	
	    mydropzone.on('addedfile', function(file) {
	        document.querySelectorAll('.avatar.avatar-lg.dropzone-file-preview').forEach(function(element) {
	            element.remove();
	        });
	        isImage = true;
	        document.getElementById("messageInput").value = "";
	        imageFormData.append("files", file);
	        mydropzone.previewsContainer.classList.add('dz-preview-moved', 'pb-10', 'pt-3', 'px-2');
	    });
	
	    mydropzone.on('reset', function(file) {
	        isImage = false;
	        mydropzone.previewsContainer.classList.remove('dz-preview-moved', 'pb-10', 'pt-3', 'px-2');
	    });
	}
	
	// 채팅방 입장
	function enterChatRoom(room_id, member_id) {
	    // 기존에 연결 끊고 입장
	    disconnect();
	
	    let socket = new SockJS(`${path}/ws`);
	    stompClient = Stomp.over(socket);
	
	    stompClient.connect({}, function(frame) {
	        // 채팅방 설정
	        document.getElementById("chatPartnerName").textContent = chatPartnerName;
	
	        document.getElementById("artTitle").textContent = artTitle;
	
	        document.getElementById("thumbnail").src = thumbnailUrl;
	
	        //채팅 내역 가져오기
	        getChatLog(room_id);
	
	        // 채팅 읽음 처리
	        readCheck(room_id, member_id);
			
	        // subscribe된 채팅방에 메시지가 도착하면 콜백함수 실행
	        stompClient.subscribe(`/topic/room/\${room_id}`, function(
	            message) {
	            const parsedMessage = JSON.parse(message.body);
	
	            messageSendId = parsedMessage.member_id;
	            if (member_id == messageSendId) {
	                isSend = true;
	            } else {
	                isSend = false;
	            }
	            showMessage(JSON.parse(message.body), isSend);
	        });
	    });
	}
	
	// 메세지 보내기
	function sendMessage() {
	    let message = null;
	    let messageInput = document.getElementById("messageInput");
	    let messageContent = messageInput.value.trim();
	
	    if (isImage) {
	    	// 이미지 파일 처리
	        fetch(`${path}/chatRest/uploadFiles`, {
	                method: "POST",
	                body: imageFormData,
	                headers: {
	                    'Accept': 'application/json'
	                }
	            })
	            .then((response) => response.json())
	            .then((filesUrl) => {
	                message = {
	                    room_id: room_id,
	                    member_id: member_id,
	                    chat_message: "",
	                    chat_time: new Date(),
	                    chat_image1: "",
	                    chat_image2: "",
	                    chat_image3: ""
	                };
	
	                filesUrl.forEach((fileUrl, index) => {
	                    if (index === 0) {
	                        message.chat_image1 = fileUrl;
	                    } else if (index === 1) {
	                        message.chat_image2 = fileUrl;
	                    } else if (index === 2) {
	                        message.chat_image3 = fileUrl;
	                    }
	                });
					// 채팅방에 메세지 전송
	                stompClient.send(`/app/chat.send/\${room_id}`, {}, JSON.stringify(message));
	                mydropzone.previewsContainer.classList.remove('dz-preview-moved', 'pb-10', 'pt-3', 'px-2');
	                mydropzone.removeAllFiles(true);
	                imageFormData = new FormData();
	            })
	            .catch(error => {
	                console.error("Error:", error);
	            });
	    } else if (messageContent !== "") {
	        message = {
	            room_id: room_id,
	            member_id: member_id,
	            chat_message: messageContent,
	            chat_time: new Date()
	        };
	     // 채팅방에 메세지 전송
	        stompClient.send(`/app/chat.send/\${room_id}`, {}, JSON.stringify(message));
	    } else {
	        return;
	    }
	    messageInput.value = "";
	}
	
	// 메세지 보여주기
	function showMessage(message, isSend) {
		addDateDivider(message);
		
	    let chatMessages = document.getElementById('chat-messages');
	
	    let messageContainer = document.createElement('div');
	    messageContainer.className = 'message';
	
	    if (isSend) {
	        messageContainer.classList.add('message-out');
	    }
	
	    let messageInner = document.createElement('div');
	    messageInner.className = 'message-inner';
	
	    let messageBody = document.createElement('div');
	    messageBody.className = 'message-body';
	
	    let messageContent = document.createElement('div');
	    messageContent.className = 'message-content';
		
	    // 이미지 보여주기
	    if (message.chat_image1) {
	        let messageGallery = document.createElement('div');
	        messageGallery.className = 'message-gallery';
	
	        let row = document.createElement('div');
	        row.className = 'row gx-3';
	
	        let images = [message.chat_image1, message.chat_image2, message.chat_image3];
	        let validImages = images.filter(image => image);
	
	        let colSize = validImages.length === 1 ? 'col-12' : validImages.length === 2 ? 'col-6' : 'col-4';
	
	        validImages.forEach((image, index) => {
	            if (image) {
	                let col = document.createElement('div');
	                col.className = colSize;
	
	                let img = document.createElement('img');
	                img.className = 'img-fluid rounded';
	                img.src = image;
	                img.alt = '';
	
	                col.appendChild(img);
	                row.appendChild(col);
	            }
	        });
	        messageGallery.appendChild(row);
	        messageContent.appendChild(messageGallery);
	    } else {
	        let messageText = document.createElement('div');
	        messageText.className = 'message-text';
	        messageText.innerHTML = `<p>\${message.chat_message}</p>`;
	        messageContent.appendChild(messageText);
	    }
	
	    messageBody.appendChild(messageContent);
	    messageInner.appendChild(messageBody);
	
	    // 채팅 timestamp
	    let formattedTime = "시간 정보 없음";
	    let chatDate = new Date(message.chat_time);
	    if (!isNaN(chatDate.getTime())) {
	        let timeOptions = {
	            hour: 'numeric',
	            minute: 'numeric',
	            hour12: true,
	        };
	        formattedTime = chatDate.toLocaleString('ko-KR', timeOptions);
	    }
	
	    let messageFooter = document.createElement('div');
	    messageFooter.className = 'message-footer';
	    messageFooter.innerHTML = `<span class="extra-small text-muted">\${formattedTime}</span>`;
	
	    messageInner.appendChild(messageFooter);
	    messageContainer.appendChild(messageInner);
	    chatMessages.appendChild(messageContainer);
	
	    // 100ms 후에 스크롤을 맨 아래로 이동
	    setTimeout(() => {
	        chatMessages.scrollTop = chatMessages.scrollHeight;
	    }, 100);
	}
	
	// websocket disconnect 
	function disconnect() {
	    if (stompClient) {
	        stompClient.disconnect();
	        stompClient = null;
	    }
	}
	
	// 채팅 읽음 처리
	function readCheck(room_id, member_id) {
	    fetch(`${path}/chatRest/readCheck`, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	            body: JSON.stringify({
	                room_id: room_id,
	                member_id: member_id
	            })
	        })
	        .catch(error => {
	            console.error("Error:", error);
	        });
	}
	
	// 채팅 내역 가져오기
	function getChatLog(room_id) {
	    fetch(`${path}/chatRest/chatLog/\${room_id}`, {
	    	method: "GET"
	    })
        .then(response => response.json())
        .then(messages => {
            messages.forEach(message => {
                addDateDivider(message);
                let isSend = false;

                if (member_id == message.member_id) {
                    isSend = true;
                } else {
                    isSend = false;
                }
                showMessage(message, isSend);
            });
        })
        .catch(error => {
            console.error("Error:", error);
        });
	}
	
	// 날짜 구분
	function addDateDivider(message) {
	    // 메시지 보낸 날짜 포맷팅
	    let formattedDate = "날짜 정보 없음";
	    if (message.chat_time) {
	        let chatDate = new Date(message.chat_time);
	        if (!isNaN(chatDate.getTime())) {
	            let dateOptions = {
	                year: 'numeric',
	                month: 'long',
	                day: 'numeric',
	                weekday: 'long',
	            };
	            formattedDate = chatDate.toLocaleString('ko-KR', dateOptions);
	        }
	    }
	
	    let messageDate = formattedDate;
	 	// 마지막으로 표시된 날짜와 다르면 날짜 표시
	    if (lastMessageDate !== messageDate) {
	        let chatMessages = document.getElementById('chat-messages');
	
	        let divider = document.createElement('div');
	        divider.className = 'message-divider';
	        divider.innerHTML = `<small class="text-muted" id="divider">\${messageDate}</small>`;
	
	        chatMessages.appendChild(divider);
	
	        // 마지막 메시지 날짜 업데이트
	        lastMessageDate = messageDate;
	    }
	}
	
	//차단하기
	function block() {
	    const isConfirmed = confirm("차단하시겠습니까?");
	
	    if (isConfirmed) {
	        let data = {
	            room_id: room_id
	        };
	        fetch(`${path}/chatRest/block`, {
	                method: "POST",
	                headers: {
	                    "Content-Type": "application/json"
	                },
	                body: JSON.stringify(data)
	            })
	            .then(response => response.json())
	            .then(data => {
	                alert("차단되었습니다.");
	                location.reload();
	            })
	            .catch(error => {
	                console.error("Error:", error);
	            });
	    }
	}
	
	//차단풀기
	function unblock() {
	    const isConfirmed = confirm("차단을 해제하시겠습니까?");
	
	    if (isConfirmed) {
	        fetch(`${path}/chatRest/unblock`, {
	                method: "DELETE"
	            })
	            .then(response => response.json())
	            .then(data => {
	                alert("차단이 해제되었습니다.");
	                location.reload();
	            })
	            .catch(error => {
	                console.error("Error:", error);
	            });
	    }
	}
	
	// Enter키로 채팅 전송하기
	messageInputField = document.getElementById('messageInput');
	
	messageInputField.addEventListener('keydown', function(event) {
	    if (event.key === 'Enter') {
	        event.preventDefault();
	        sendMessage();
	    }
	}); 
	</script>

</body>
</html>