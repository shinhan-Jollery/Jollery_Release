package com.shinhan.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.BlocksDTO;
import com.shinhan.VO.ChatRoomsDTO;
import com.shinhan.VO.ChatsDTO;
import com.shinhan.VO.MembersDTO;
import com.shinhan.art.artId.ArtService;
import com.shinhan.util.S3uploadUtil;

@Service
public class ChatService {

	@Autowired
	ChatDAO chatDAO;

	@Autowired
	ArtService artService;

	@Autowired
	private S3uploadUtil s3uploadUtil;

	// 채팅 저장
	public int saveChat(ChatsDTO chat) {
		return chatDAO.saveChat(chat);
	}

	// 채팅방 존재 여부 확인
	public boolean checkExistRoom(int member_id, int art_id) {
		ChatRoomsDTO checkExistRoom = new ChatRoomsDTO();
		checkExistRoom.setMember_id(member_id);
		checkExistRoom.setArt_id(art_id);

		return chatDAO.checkExistRoom(checkExistRoom) > 0;
	}

	// 채팅방 생성
	public int createRoom(int member_id, int art_id) {
		// 자기 작품에 대한 채팅방 개설 방지
		List<Integer> artList = chatDAO.getArtListByMember(member_id);
		if (artList != null && artList.contains(art_id)) {
			return 0;
		}

		ChatRoomsDTO chatRoom = new ChatRoomsDTO();
		chatRoom.setMember_id(member_id);
		chatRoom.setArt_id(art_id);

		return chatDAO.createRoom(chatRoom);
	}

	// 사용자의 작품번호 목록 조회
	public List<Integer> getArtListByMember(int member_id) {
		return chatDAO.getArtListByMember(member_id);
	}

	// 사용자의 채팅방 목록 조회
	public Map<String, Object> getRoomList(int currentMember) {
		Map<String, Object> response = new HashMap<String, Object>();
		// 채팅방 목록
		List<ChatRoomsDTO> chatRoomList = chatDAO.getChatRoomListByMember(currentMember);
		// 작품 썸네일
		List<String> urlList = new ArrayList<>();
		// 작품명
		List<String> titleList = new ArrayList<>();
		// 채팅 상대방 이름
		List<String> nameList = new ArrayList<>();
		// 최근 채팅 사용자의역
		List<ChatsDTO> recentChatList = new ArrayList<>();
		// 안 읽은 채팅
		List<Integer> notReadList = new ArrayList<>();

		for (ChatRoomsDTO chatRoom : chatRoomList) {
			int room_id = chatRoom.getRoom_id();
			int art_id = chatRoom.getArt_id();

			ArtsDTO arts = artService.selectByArtIdService(art_id);

			// 작품 썸네일
			String thumbnailUrl = "";
			thumbnailUrl = arts.getArt_thumbnail_image();
			urlList.add(thumbnailUrl);

			// 작품명
			String artTitle = "";
			artTitle = arts.getArt_title();
			titleList.add(artTitle);

			// 채팅 상대방 이름
			int member_id = chatRoom.getMember_id();
			String chatPartnerName = "";

			if (currentMember == member_id) {
				MembersDTO member = chatDAO.getMemberByArtId(art_id);
				chatPartnerName = member.getMember_name();
			} else {
				chatPartnerName = chatDAO.getNameByMemberId(member_id);
			}
			nameList.add(chatPartnerName);

			// 최근 채팅
			ChatsDTO recentChat = chatDAO.getRecentChat(room_id);
			recentChatList.add(recentChat);

			// 안 읽은 채팅
			Map<String, Integer> notReadMap = new HashMap<String, Integer>();
			notReadMap.put("room_id", room_id);
			notReadMap.put("member_id", currentMember);
			int notReadChat = chatDAO.getnotReadChat(notReadMap);
			notReadList.add(notReadChat);
		}

		response.put("member_id", currentMember);
		response.put("chatRoomList", chatRoomList);
		response.put("urlList", urlList);
		response.put("titleList", titleList);
		response.put("nameList", nameList);
		response.put("recentChatList", recentChatList);
		response.put("notReadList", notReadList);
		return response;
	}

	// 사용자번호로 사용자이름 조회
	public String getNameByMemberId(int member_id) {
		return chatDAO.getNameByMemberId(member_id);
	}

	// 작품번호로 사용자 조회, 다른 서비스에도 조회하기 때문에 DTO로 사용
	public MembersDTO getMemberByArtId(int art_id) {
		return chatDAO.getMemberByArtId(art_id);
	}

	// 가장 최근 채팅 조회
	public ChatsDTO getRecentChat(int room_id) {
		return chatDAO.getRecentChat(room_id);
	}

	// 읽지 않은 채팅 조회
	public int getnotReadChat(Map<String, Integer> notReadMap) {
		return chatDAO.getnotReadChat(notReadMap);
	}

	// 채팅 내역 조회
	public List<ChatsDTO> getChatLog(int room_id) {
		return chatDAO.getChatLog(room_id);
	}

	// 채팅 읽음 처리
	public int readCheck(Map<String, Integer> map) {
		Map<String, Integer> readCheckMap = new HashMap<String, Integer>();
		readCheckMap.put("room_id", map.get("room_id"));
		readCheckMap.put("member_id", map.get("member_id"));

		return chatDAO.readCheck(readCheckMap);
	}

	// dropzone 파일 업로드
	public List<String> uploadFiles(List<MultipartFile> files) {
		List<String> s3UrlList = new ArrayList<>();

		for (MultipartFile file : files) {
			String s3Url = uploadAWS(file);
			if (s3Url != "false") {
				s3UrlList.add(s3Url);
			} else {
				s3UrlList.add("false");
			}
		}
		return s3UrlList;
	}

	// 이미지 파일 AWS 업로드
	public String uploadAWS(MultipartFile file) {
		try {
			String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
			String s3FileName = fileName;
			String s3Url = s3uploadUtil.uploadToS3(file, s3FileName);
			return s3Url;
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}

	// 차단 여부 체크
	public boolean checkBlock(int currentMember, int room_id) {
		ChatRoomsDTO room = chatDAO.getRoomInfo(room_id);
		int partner = -1;
		if (currentMember == room.getMember_id()) {
			MembersDTO member = chatDAO.getMemberByArtId(room.getArt_id());
			partner = member.getMember_id();
		} else {
			partner = room.getMember_id();
		}

		BlocksDTO getBlock1 = BlocksDTO.builder().member_id(currentMember).block_id(partner).build();
		BlocksDTO getBlock2 = BlocksDTO.builder().member_id(partner).block_id(currentMember).build();
		BlocksDTO block1 = chatDAO.getBlockInfo(getBlock1);
		BlocksDTO block2 = chatDAO.getBlockInfo(getBlock2);

		boolean isBlock = false;
		// 내가 상대를 차단
		if (block1 != null && block1.getMember_id() == currentMember && block1.getBlock_id() == partner) {
			isBlock = true;
		}
		// 상대가 나를 차단
		else if (block2 != null && block2.getMember_id() == partner && block2.getBlock_id() == currentMember) {
			isBlock = true;
		}
		return isBlock;
	}

	// 차단하기
	public int block(int currentMember, int room_id) {
		ChatRoomsDTO room = chatDAO.getRoomInfo(room_id);

		int block_id = -1;
		if (currentMember == room.getMember_id()) {
			MembersDTO member = chatDAO.getMemberByArtId(room.getArt_id());
			block_id = member.getMember_id();
		} else {
			block_id = room.getMember_id();
		}

		BlocksDTO block = BlocksDTO.builder().member_id(currentMember).block_id(block_id).build();
		return chatDAO.block(block);
	}

	// 차단풀기
	public int unblock(int member_id) {
		return chatDAO.unblock(member_id);
	}

}
