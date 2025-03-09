package com.shinhan.order;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.VO.MembersDTO;
import com.shinhan.auth.AuthService;
import com.shinhan.cart.CartService;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrderListService orderListService;
	@Autowired
	private CartService cartService;
	@Autowired
	AuthService authService;

	@GetMapping("/orderpage")
	public String tosspay(HttpServletRequest request, Model model) {
		Integer userId = (Integer) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String member_login_ID = (String) request.getAttribute("member_login_ID");
        String isArtist = (String)request.getAttribute("isArtist");
        MembersDTO membersDTO = authService.getMemberInfo(member_login_ID);
        System.out.println(member_login_ID);
        
        model.addAttribute("part1",membersDTO.getMember_phone().split("-")[0]);
        model.addAttribute("part2",membersDTO.getMember_phone().split("-")[1]);
        model.addAttribute("part3",membersDTO.getMember_phone().split("-")[2]);
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);
        model.addAttribute("membersDTO", membersDTO);
        System.out.println(membersDTO);
        
        List<Map<String, Object>> cartItems = cartService.selectCategory(userId);
       
        int totalPrice = cartItems.stream()
        						  .mapToInt(item -> (int)item.get("art_price"))
        						  .sum();
        		
        model.addAttribute("totalPrice",totalPrice);
        model.addAttribute("cartItems",cartItems);

		return "order/orderpage";
	}
	
	//주문내역 가져와서 페이지열기
	@GetMapping("/list")
	public String orderList(HttpServletRequest request, Model model) {
		Integer userId = (Integer) request.getAttribute("userId");
        String memberName = (String) request.getAttribute("Member_name");
        String isArtist = (String)request.getAttribute("isArtist");
        model.addAttribute("isArtist",isArtist);
        model.addAttribute("userId", userId);
        model.addAttribute("memberName", memberName);

        List<Map<String, Object>> orderWithArts = orderListService.selectOrderList(userId);
        System.out.println("아이템:"+orderWithArts);
        
        for (Map<String, Object> order : orderWithArts) {
            String[] artTitle = ((String) order.get("art_title")).split(",");  
            String[] artStatus = ((String) order.get("art_status")).split(",");
            String[] artImage = ((String) order.get("art_thumbnail_image")).split(",");
            System.out.println(artImage);
            order.put("artImage", Arrays.asList(artImage));
            order.put("artTitleList", Arrays.asList(artTitle));
            order.put("artStatusList", Arrays.asList(artStatus));
        }
        
        model.addAttribute("orderWithArts", orderWithArts);
        
		return "order/orderlist";
	}
}
