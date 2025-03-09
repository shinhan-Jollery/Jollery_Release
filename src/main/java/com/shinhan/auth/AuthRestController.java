package com.shinhan.auth;
import java.text.ParseException;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.VO.MembersDTO;
import com.shinhan.util.PasswordHashing;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
@RestController
@RequestMapping("/auth")
public class AuthRestController {
	@Autowired
	private AuthService authService;

	@Autowired
	private AuthSignUpDAO authSignUpDAO;

	// JWT 비밀키
	//원래는 코드에 있으면 안됨 환경 변수로 내려야함
	private static final String SECRET_KEY = "nahyunjungyeonmomosanajihyomimidahyuncheyoungtwuyu";
	
	@PostMapping(value = "/login", produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> login(@RequestBody Map<String, Object> requestBody, HttpServletResponse response) {
		String username = (String) requestBody.get("username");
		String password = (String) requestBody.get("password");
		
		// �α���
		//비밀번호 체크됨
		MembersDTO user = authService.loginMember(username, password);
		if (user.getMember_name() != null) {

			// JWT 생성
			String token = Jwts.builder().setSubject(user.getMember_name())
					.claim("userId", user.getMember_id())
					.claim("isArtist", user.getMember_is_artist())
					.claim("Member_name", user.getMember_name())
					.claim("member_login_ID", user.getMember_login_id())
					.setIssuedAt(new Date()) // 발급 시간
					.setExpiration(new Date(System.currentTimeMillis() + 1000 * 7200))

					.signWith(SignatureAlgorithm.HS256, SECRET_KEY).compact();
			// JWT�� ��Ű�� ����
			javax.servlet.http.Cookie jwtCookie = new javax.servlet.http.Cookie("jwtToken", token);
			jwtCookie.setPath("/");
			jwtCookie.setMaxAge(7200);
			response.addCookie(jwtCookie);


			// 서블릿 구버전 이슈
			String cookieHeader = String.format("%s=%s; Path=%s; Max-Age=%d; HttpOnly",
					jwtCookie.getName(),
					jwtCookie.getValue(), 
					jwtCookie.getPath(), 
					jwtCookie.getMaxAge());

			response.addHeader("Set-Cookie", cookieHeader);
			return ResponseEntity.ok("{\"status\":\"success\", \"message\":\"로그인성공\"}");
		} else {
			// ���� ����
			return ResponseEntity.badRequest()
					.body("{\"status\":\"fail\", \"message\":\"" + user.getMember_is_artist() + "\"}");
		}
	}
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	public ResponseEntity<String> logout(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies(); // ��� ��Ű ��������
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("jwtToken".equals(cookie.getName())) { // Ư�� ��Ű �̸� Ȯ��
					// ��Ű ���� ����
					cookie.setValue(null);
					cookie.setMaxAge(0);
					cookie.setPath("/"); // ��� ���� (���� �ÿ� �����ϰ�)
					// HttpOnly �Ӽ��� �������� �߰�
					String cookieHeader = String.format("%s=%s; Path=%s; Max-Age=0; HttpOnly", cookie.getName(),
							cookie.getValue(), cookie.getPath());
					response.addHeader("Set-Cookie", cookieHeader);
				}
			}
		}
		return ResponseEntity.ok("{\"status\":\"success\", \"message\":\"�α׾ƿ� ����\"}");
	}
	@PostMapping(value = "/register", produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> register(@RequestBody Map<String, Object> requestBody) {
		// JSON DTO�� ��ȯ
		System.out.println(requestBody);

		// birth는 변환에서 입력
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date birthDate = null;
		try {
			birthDate = dateFormat.parse((String) requestBody.get("birth"));
		} catch (ParseException e) {
			e.printStackTrace();
		}

		MembersDTO member = MembersDTO.builder().member_login_id((String) requestBody.get("username"))
				.member_password((String) requestBody.get("password")).member_name((String) requestBody.get("name"))
				.member_birth(birthDate)
				.member_email(requestBody.get("emailPrefix") + "@" + requestBody.get("emailDomain"))
				.member_phone((String) requestBody.get("phone")).member_address((String) requestBody.get("address"))

				.member_address_detail((String) requestBody.get("member_address_detail")).build();

		String hashedPassword = PasswordHashing.hashPassword(member.getMember_password());
		member.setMember_password(hashedPassword);
		// 판매자 여부 조회인데 여기서 필요 없기때문에 null 방지용
		Boolean isArtist = (Boolean) requestBody.get("isArtist");
		member.setMember_is_artist(isArtist != null && isArtist ? "1" : "0");
		// db�� ���� ���������� ���� front���� ó��
		boolean isSuccess = authService.addMember(member);
		// ������ ��ȯ
		if (isSuccess) {
			return ResponseEntity.ok("{\"status\":\"success\"}");
		} else {
			return ResponseEntity.badRequest().body("{\"status\":\"fail\"}");
		}
	}
	@PostMapping(value = "/idchecker", produces = "application/json;charset=UTF-8")
	public ResponseEntity<String> duplicateMemberIdChecker(@RequestBody Map<String, Object> requestBody) {

		String userId = (String) requestBody.get("userId");
		MembersDTO member = authSignUpDAO.selectMemberById(userId);
		boolean issuccess = member.getMember_login_id() == null;
		if (issuccess) {
			// ID 사용 가능 (성공)
			return ResponseEntity.ok("{\"status\":\"success\", \"message\":\"사용 가능한 ID입니다.\"}");
		} else {
			// ID 이미 존재 (실패)
			return ResponseEntity.ok("{\"status\":\"error\", \"message\":\"이미 사용 중인 ID입니다.\"}");
		}
	}

}
