package com.shinhan.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shinhan.VO.ChatsDTO;

@RestController
@RequestMapping("/chatRest")
public class ChatRestController {

	@Autowired
	ChatService chatService;

	// 채팅하기 버튼 클릭시 로그인 체크
	@GetMapping("/chatCheckLogin")
	public String checkLogin(HttpServletRequest request) {
		if (request.getAttribute("userId") == null) {
			return "false";
		} else {
			return "true";
		}
	}

	// 채팅방 생성
	@PostMapping("/createRoom")
	public Map<String, Object> createRoom(@RequestBody Map<String, Integer> map, HttpServletRequest request) {
		int currentMember = (int) request.getAttribute("userId");
		int art_id = map.get("art_id");

		boolean checkExistRoom = chatService.checkExistRoom(currentMember, art_id);
		Map<String, Object> response = new HashMap<>();

		if (checkExistRoom) {
			response.put("exist", true);
		} else {
			chatService.createRoom(currentMember, art_id);
			response.put("exist", false);
		}

		return response;
	}

	// 사용자의 채팅방 목록 조회
	@GetMapping(value = "/getRoomList", produces = "application/json; charset=UTF-8")
	public Map<String, Object> getRoomListByMember(HttpServletRequest request) {
		int currentMember = (int) request.getAttribute("userId");

		return chatService.getRoomList(currentMember);
	}

	// 채팅 내역 조회
	@GetMapping("/chatLog/{room_id}")
	public List<ChatsDTO> getChatLog(@PathVariable int room_id) {
		return chatService.getChatLog(room_id);
	}

	// 채팅 읽음 처리
	@PostMapping("/readCheck")
	public int readCheck(@RequestBody Map<String, Integer> map) {
		return chatService.readCheck(map);
	}

	// dropzone 이미지 파일 업로드
	@PostMapping("/uploadFiles")
	public List<String> uploadFiles(List<MultipartFile> files) {
		List<String> s3UrlList = chatService.uploadFiles(files);

		return s3UrlList;
	}

	// 차단 여부 체크
	@GetMapping("/checkBlock/{room_id}")
	public boolean checkBlock(@PathVariable int room_id, HttpServletRequest request) {
		int currentMember = (int) request.getAttribute("userId");
		boolean isBlock = chatService.checkBlock(currentMember, room_id);

		return isBlock;
	}

	// 차단하기
	@PostMapping("/block")
	public int blockMember(@RequestBody Map<String, Integer> map, HttpServletRequest request) {
		int currentMember = (int) request.getAttribute("userId");

		return chatService.block(currentMember, map.get("room_id"));
	}

	// 차단풀기
	@DeleteMapping("/unblock")
	public int unblock(HttpServletRequest request) {
		int currentMember = (int) request.getAttribute("userId");

		return chatService.unblock(currentMember);
	}
}
