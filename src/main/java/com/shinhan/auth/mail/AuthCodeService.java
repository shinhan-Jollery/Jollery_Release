package com.shinhan.auth.mail;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.AuthCodeDTO;

@Service
public class AuthCodeService {
	@Autowired
	AuthCodeDAO authCodeDAO;
	/**
	 * 인증 코드를 DB에 저장  Method에 Email, id, 
	 * @param authcode
	 * @return 성공여부
	 */
	public boolean insertAuthCode(AuthCodeDTO authcode) {
		int result = authCodeDAO.insertAuthCode(authcode);
		return result > 0; 
	}
	/**
	 * method로 인증코드 반환 
	 * @param method
	 * @return 해당 인증번호
	 */
	public AuthCodeDTO selectByAuth_Method(String method) {
		AuthCodeDTO authCode = authCodeDAO.selectByAuth_Method(method);
		return authCode;
	}

}
