package com.shinhan.auth;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class AuthInfoUpdateController {

    // 회원 정보 수정 페이지
    @GetMapping("/infoUpdate")
    public String showInfoUpdatePage(HttpServletRequest request, Model model) {
        
        
        int userId = (int) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String isArtist = (String)request.getAttribute("isArtist");
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);
        return "auth/infoUpdate";
    }
}
