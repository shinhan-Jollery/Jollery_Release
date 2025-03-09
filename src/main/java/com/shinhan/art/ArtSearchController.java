package com.shinhan.art;



import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.MiniCategoriesDTO;
import com.shinhan.art.artId.ArtService;

@Controller
@RequestMapping("/artSearch")
public class ArtSearchController {
	@Autowired
	private ArtSearchService artSearchService;
	@Autowired
	private ArtService artService;
	
	@GetMapping("/list")
	public String artList(@RequestParam("minicategoryId") int minicategoryId, HttpServletRequest request, Model model) {
		Integer userId = (Integer) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String isArtist = (String)request.getAttribute("isArtist");
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);
        
        List<ArtsDTO> artList = artSearchService.selectByMiniCategoryId(minicategoryId);
        model.addAttribute("artList",artList);
        
     // minicategoryId로 얻은 카테고리명 추가
        MiniCategoriesDTO miniCategoryName = artService.selectArtCategoryIDService(minicategoryId); // 카테고리 이름을 얻는 메서드
        model.addAttribute("categoryName", miniCategoryName);
        
        return "art/artSearch";
	}
	
	@GetMapping("/search")
    public String artListSearch(@RequestParam(value = "query") String query, Model model, HttpServletRequest request) {
		Integer userId = (Integer) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String isArtist = (String)request.getAttribute("isArtist");
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);
		

        
        List<ArtsDTO> artList = new ArrayList<>();
        if (query != null && !query.isEmpty()) {
        	 // 제목으로 검색
            artList.addAll(artSearchService.selectByArtTitle(query));

            // 작가 이름으로 검색
            artList.addAll(artSearchService.selectByMemberName(query));
        }

        model.addAttribute("artList", artList);
        model.addAttribute("searchQuery", query);
        return "art/artSearch";
    }
	
	 @GetMapping("/filter")
	    public String filterArtList(@RequestParam("filter") String filter, Model model, @RequestParam int minPrice, @RequestParam int maxPrice) {
	        List<ArtsDTO> artList;

	        switch (filter) {
	            case "recent":
	                artList = artSearchService.getArtByRecent();
	                break;
	            case "popular":
	                artList = artSearchService.getArtByVeiw();
	                break;
	            case "likes":
	                artList = artSearchService.getArtByLike();
	                break;
	            case "priceLow":
	                artList = artSearchService.getArtByPriceASC();
	                break;
	            case "priceHigh":
	                artList = artSearchService.getArtByPriceDESC();
	                break;
	            case "priceRange":
	            	artList = artSearchService.getArtByPriceRange(minPrice, maxPrice);
	            default:
	                artList = artSearchService.getArtByRecent(); // 기본값: 최근 작품순
	        }

	        model.addAttribute("artList", artList);
	        return "art/artSearch"; // JSP 또는 Thymeleaf 페이지 반환
	    }
}

