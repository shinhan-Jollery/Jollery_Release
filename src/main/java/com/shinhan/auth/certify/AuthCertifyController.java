package com.shinhan.auth.certify;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class AuthCertifyController {
	
	@Autowired
	AuthCertifyService authCertifyService;
	
	@GetMapping("/certify")
	public String mypage(HttpServletRequest request, Model model) {
		Integer userId = (Integer) request.getAttribute("userId");
		String memberName = (String) request.getAttribute("Member_name");
		model.addAttribute("memberName", memberName);
		model.addAttribute("userId", userId);
		return "auth/certify";
	}
}
