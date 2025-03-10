package com.shinhan.VO;


import java.io.Serializable;
import java.util.Date;

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


// 9�� Į��
public class MembersDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	int member_id;
	String member_login_id;
	String member_password;
	String member_name;
	Date member_birth;
	String member_phone;
	String member_address;
	String member_address_detail;
	String member_email;
	String member_is_artist;
}
