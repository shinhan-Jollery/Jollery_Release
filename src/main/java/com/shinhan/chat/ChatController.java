package com.shinhan.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.shinhan.VO.ChatsDTO;

@Controller
public class ChatController {

	@Autowired
	ChatService chatService;

	// 채팅방 목록
	@GetMapping("/chatRoom")
	public String chatRoom() {
		return "chat/chatRoomList";
	}

	// 1:1 채팅
	@GetMapping("/chatDirect")
	public String chatDirect(@RequestParam int room_id, @RequestParam int member_id, @RequestParam String thumbnailUrl,
			@RequestParam String artTitle, @RequestParam String chatPartnerName) {
		return "chat/chatDirect";
	}

	// 클라이언트가 MessageMapping 요청으로 메세지를 보내면 /topic/room/{room_id} 구독자에게 브로드캐스트(한 메시지가 여러 수신자에게 동시에 전달)
	@MessageMapping("/chat.send/{room_id}")
	@SendTo("/topic/room/{room_id}")
	public ChatsDTO send(@RequestBody ChatsDTO message, @DestinationVariable("room_id") int room_id) {
		chatService.saveChat(message);
		return message;
	}

}
