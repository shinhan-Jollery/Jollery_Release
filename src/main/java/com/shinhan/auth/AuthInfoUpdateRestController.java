package com.shinhan.auth;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.VO.MembersDTO;
import com.shinhan.util.PasswordHashing;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@RestController
@RequestMapping("/api/auth")
public class AuthInfoUpdateRestController {

	@Autowired
	AuthInfoUpdateService authInfoUpdateService;
	@Autowired
	AuthService authService;
	// JWT 비밀키
	// 원래는 코드에 있으면 안됨 환경 변수로 내려야함
	private static final String SECRET_KEY = "nahyunjungyeonmomosanajihyomimidahyuncheyoungtwuyu";

	@PutMapping("/infoUpdate")
	public ResponseEntity<Map<String, Object>> updateMemberInfo(@RequestBody MembersDTO member,
			HttpServletRequest request, HttpServletResponse response) {

		if (member.getMember_password().equals("")) {
			member.setMember_password(null);
		}

		// 요청에서 userId 가져오기 (JWT에서 추출된 값)
		String member_login_ID = (String) request.getAttribute("member_login_ID");
		Integer memberId = (Integer) request.getAttribute("userId");
		System.out.println(memberId);

		if (memberId == null) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body(Map.of("success", false, "message", "사용자 ID가 없습니다."));
		}

		member.setMember_id(memberId);

		// 회원 정보 업데이트 서비스 호출
		boolean isUpdatedSuccessfully = authInfoUpdateService.updateMemberInfo(member);
		MembersDTO membersDTO = authService.getMemberInfo(member_login_ID);

		if (isUpdatedSuccessfully) {
			// 업데이트된 회원 정보를 기반으로 새로운 JWT 생성
			String updatedToken = Jwts.builder().setSubject(membersDTO.getMember_name())
					.claim("userId", membersDTO.getMember_id()).claim("isArtist", membersDTO.getMember_is_artist())
					.claim("Member_name", membersDTO.getMember_name())
					.claim("member_login_ID", membersDTO.getMember_login_id()).setIssuedAt(new Date()) // 발급 시간
					.setExpiration(new Date(System.currentTimeMillis() + 1000 * 7200)) // 2시간 유효
					.signWith(SignatureAlgorithm.HS256, SECRET_KEY).compact();

			// JWT를 쿠키에 저장
			javax.servlet.http.Cookie jwtCookie = new javax.servlet.http.Cookie("jwtToken", updatedToken);
			jwtCookie.setPath("/");
			jwtCookie.setMaxAge(7200); // 2시간 유효
			response.addCookie(jwtCookie);

			// 서블릿 구버전 이슈 대응 (Set-Cookie 헤더로 추가)
			String cookieHeader = String.format("%s=%s; Path=%s; Max-Age=%d; HttpOnly", jwtCookie.getName(),
					jwtCookie.getValue(), jwtCookie.getPath(), jwtCookie.getMaxAge());
			response.addHeader("Set-Cookie", cookieHeader);

			return ResponseEntity.ok(Map.of("success", true, "message", "회원 정보가 수정되었습니다."));
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body(Map.of("success", false, "message", "회원 정보 수정에 실패했습니다."));
		}
	}

	// 비밀번호확인
	@PostMapping("/pwCheck")
	public ResponseEntity<Map<String, Object>> checkPassword(@RequestBody Map<String, String> request,
			HttpServletRequest httpRequest) {
		Integer memberId = (Integer) httpRequest.getAttribute("userId");
		System.out.println("Received memberId: " + memberId);
		if (memberId == null) {
			System.out.println("Error: userId is null");
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body(Map.of("success", false, "message", "로그인이 필요합니다."));
		}

		String password = request.get("password");
		System.out.println("Received password: " + password);
		if (password == null || password.isBlank()) {
			return ResponseEntity.badRequest().body(Map.of("success", false, "message", "비밀번호를 입력해주세요."));
		}
		
		MembersDTO dto = authInfoUpdateService.checkPassword(memberId, password);
		MembersDTO hashDTO = authInfoUpdateService.getMemberInfo(memberId);
		
		
		if (dto != null) {
			return ResponseEntity.ok(Map.of("success", true));
		}
		if(PasswordHashing.checkPassword(password,hashDTO.getMember_password())) {
			return ResponseEntity.ok(Map.of("success",true));
		}
		else {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body(Map.of("success", false, "message", "비밀번호가 올바르지 않습니다."));
		}
	}

	// 회원 삭제
	@DeleteMapping("/delete")
	public ResponseEntity<Map<String, Object>> deleteMember(HttpServletRequest request) {
		Integer memberId = (Integer) request.getAttribute("userId");
		if (memberId == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body(Map.of("success", false, "message", "로그인이 필요합니다."));
		}

		boolean isDeleted = authInfoUpdateService.deleteMember(memberId);

		if (isDeleted) {
			return ResponseEntity.ok(Map.of("success", true, "message", "회원이 삭제되었습니다."));
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body(Map.of("success", false, "message", "회원 삭제에 실패했습니다."));
		}
	}

	// 기존 회원정보 보여주기
	@GetMapping("/profile")
	public ResponseEntity<Map<String, Object>> getProfile(HttpServletRequest request) {
		Integer memberId = (Integer) request.getAttribute("userId");

		if (memberId == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body(Map.of("success", false, "message", "로그인이 필요합니다."));
		}

		// 사용자 정보 조회
		MembersDTO member = authInfoUpdateService.getMemberInfo(memberId);

		if (member != null) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", true);
			response.put("data", member); // 사용자 정보
			return ResponseEntity.ok(response);
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(Map.of("success", false, "message", "회원 정보를 찾을 수 없습니다."));
		}
	}

}