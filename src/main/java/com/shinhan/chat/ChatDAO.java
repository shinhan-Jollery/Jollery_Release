package com.shinhan.chat;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.BlocksDTO;
import com.shinhan.VO.ChatRoomsDTO;
import com.shinhan.VO.ChatsDTO;
import com.shinhan.VO.MembersDTO;

@Repository
public class ChatDAO {
	@Autowired
	SqlSession sqlSession;

	String namespace = "com.shinhan.chat.";

	public int saveChat(ChatsDTO chat) {
		return sqlSession.insert(namespace + "saveChat", chat);
	}

	public int createRoom(ChatRoomsDTO chatRoom) {
		int result = sqlSession.insert(namespace + "createRoom", chatRoom);
		return result;
	}

	public int checkExistRoom(ChatRoomsDTO chatRoom) {
		Integer result = sqlSession.selectOne(namespace + "checkExistRoom", chatRoom);
		if (result == null) {
			return 0;
		}
		return result;
	}

	public List<Integer> getArtListByMember(int member_id) {
		List<Integer> artList = sqlSession.selectList(namespace + "getArtListByMember", member_id);
		return artList;
	}

	public List<ChatRoomsDTO> getChatRoomListByMember(int member_id) {
		List<ChatRoomsDTO> roomList = sqlSession.selectList(namespace + "getChatRoomListByMember", member_id);
		return roomList;
	}

	public String getNameByMemberId(int member_id) {
		String memberName = sqlSession.selectOne(namespace + "getNameByMemberId", member_id);
		return memberName;
	}

	public MembersDTO getMemberByArtId(int art_id) {
		MembersDTO member = sqlSession.selectOne(namespace + "getMemberByArtId", art_id);
		return member;
	}

	public ChatsDTO getRecentChat(int room_id) {
		ChatsDTO recentChat = sqlSession.selectOne(namespace + "getRecentChat", room_id);
		return recentChat;
	}

	public int getnotReadChat(Map<String, Integer> notReadMap) {
		int notReadChat = sqlSession.selectOne(namespace + "getnotReadChat", notReadMap);
		return notReadChat;
	}

	public List<ChatsDTO> getChatLog(int room_id) {
		List<ChatsDTO> chatLog = sqlSession.selectList(namespace + "getChatLog", room_id);
		return chatLog;
	}

	public int readCheck(Map<String, Integer> readCheckMap) {
		int result = sqlSession.update(namespace + "readCheck", readCheckMap);
		return result;
	}

	public ChatRoomsDTO getRoomInfo(int room_id) {
		ChatRoomsDTO chatRoom = sqlSession.selectOne(namespace + "getRoomInfo", room_id);
		return chatRoom;
	}

	public BlocksDTO getBlockInfo(BlocksDTO blocks) {
		BlocksDTO block = sqlSession.selectOne(namespace + "getBlockInfo", blocks);
		return block;
	}

	public int block(BlocksDTO blocks) {
		int result = sqlSession.insert(namespace + "block", blocks);
		return result;
	}

	public int unblock(int member_id) {
		int result = sqlSession.delete(namespace + "unblock", member_id);
		return result;
	}

}
