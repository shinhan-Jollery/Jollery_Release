package com.shinhan.main;




import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.ExhibitionsDTO;
import com.shinhan.art.ArtSearchService;

@Controller
public class mainController {

	
	@Autowired
	private ArtSearchService artSearchService;
	@Autowired
	private ExhibitionService exhibitionService;
	
    @GetMapping("main")
    public String mypage(HttpSession session, HttpServletRequest request, Model model) {
        try {
            // 로그인 정보를 받기
            Integer userId = (Integer) request.getAttribute("userId");
            String memberName = (String) request.getAttribute("Member_name");
            String isArtist = (String)request.getAttribute("isArtist");
            model.addAttribute("isArtist",isArtist);

            model.addAttribute("userId", userId);
            model.addAttribute("memberName", memberName);
            System.out.println("username: " + memberName);
            List<ArtsDTO> artListLike = artSearchService.getArtByLike();
            List<ArtsDTO> artListView = artSearchService.getArtByVeiw();
            List<ExhibitionsDTO> exhibitionList = exhibitionService.selectAllExhibition();
            
            model.addAttribute("exhibitionList",exhibitionList);
            model.addAttribute("artListLike",artListLike);
            model.addAttribute("artListView",artListView);
            
        } catch (Exception e) {
            System.out.println("로그인 정보가 없습니다.");
        }

        return "main/main";
    }
}
