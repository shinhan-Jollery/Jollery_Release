package com.shinhan.auth.certify;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shinhan.VO.MembersDTO;
import com.shinhan.util.S3uploadUtil;

@RestController
@RequestMapping("/auth")
public class AuthCertifyRestController {

	@Autowired
	private AuthCertifyService authCertifyService;
	
	@Autowired
	private S3uploadUtil s3uploadUtil;

	@PostMapping("/certify")
	public String uploadFile(MultipartFile file, HttpServletRequest request) {
		try {

			String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
			String s3Url = s3uploadUtil.uploadToS3(file, fileName);

			// request에서 userId 가져오기
			Object userIdObj = request.getAttribute("userId"); // Object로 가져옴
			if (userIdObj == null) {
				System.out.println("userId가 request에 없음");
				return "false";
			}

			// Object를 Integer로 변환
			int memberId;
			if (userIdObj instanceof Integer) {
				memberId = (Integer) userIdObj;
			} else {
				System.out.println("userId가 Integer가 아님: " + userIdObj.getClass().getName());
				return "false";
			}

			// DTO 설정
			MembersDTO member = new MembersDTO();
			member.setMember_id(memberId); // 정수로 변환된 값을 설정
			member.setMember_is_artist(s3Url);

			int result = authCertifyService.updateService(member);

			if (result > 0) {
				System.out.println("DB 업데이트 성공");
				return s3Url;
			} else {
				System.out.println("DB 업데이트 실패");
				return "false";

			}
		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
}