package com.shinhan.sale;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.VO.ArtsDTO;

@Controller
@RequestMapping("/sale")
public class SaleListController {
	
	@Autowired
	private SaleListService saleListService;
	
	@GetMapping("/list")
	public String saleList(HttpServletRequest request, Model model) {
		Integer userId = (Integer) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String isArtist = (String)request.getAttribute("isArtist");
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);

        List<ArtsDTO> onSaleArts = saleListService.getArtsByStatus(userId, "판매중");
        model.addAttribute("onSaleArts", onSaleArts);
        
        List<ArtsDTO> soldArts = saleListService.getArtsByStatus(userId, "판매완료");
        model.addAttribute("soldArts", soldArts);
        
        List<ArtsDTO> deliveryArts = saleListService.getArtsByStatus(userId, "배송중");
        model.addAttribute("deliveryArts", deliveryArts);
        
        List<ArtsDTO> orderArts = saleListService.getArtsByStatus(userId, "결제완료");
        model.addAttribute("orderArts", orderArts);
        
        return "order/salelist";
	}
}
