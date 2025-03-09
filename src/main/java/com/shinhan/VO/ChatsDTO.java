package com.shinhan.VO;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter

public class ChatsDTO {
	int chat_id;
	int room_id;
	int member_id;
	String chat_message;
	Timestamp chat_time;
	String chat_image1;
	String chat_image2;
	String chat_image3;
	boolean isRead;
}
