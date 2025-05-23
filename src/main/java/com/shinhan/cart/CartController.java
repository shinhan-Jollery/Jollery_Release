package com.shinhan.cart;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/cart")
public class CartController {

	@Autowired
	CartService cartService;

	@GetMapping("/cartlist")
	public String getCart(HttpServletRequest request, Model model) {
		Integer member_id = (Integer) request.getAttribute("userId");
		String memberName = (String) request.getAttribute("Member_name");
		String isArtist = (String) request.getAttribute("isArtist");
		model.addAttribute("isArtist", isArtist);
		model.addAttribute("member_id", member_id);
		model.addAttribute("memberName", memberName);
		model.addAttribute("cartList", cartService.selectCategory(member_id));

		return "cart/cart";
	}

	@ResponseBody
	@GetMapping("/cartmodal")
	public ResponseEntity<List<Map<String, Object>>> getCartModal(HttpServletRequest request, Model model) {
		Integer member_id = (Integer) request.getAttribute("userId");
		model.addAttribute("member_id", member_id);
		List<Map<String, Object>> cartItems = cartService.selectCategory(member_id);

		return ResponseEntity.ok(cartItems);
	}

	@ResponseBody
	@DeleteMapping(value = "/delete/{art_id}", produces = "text/plain;charset=utf-8")
	public String delete(HttpServletRequest request, @PathVariable int art_id) {
		System.out.println("DELETE: art_ID = " + art_id);
		Integer member_id = (Integer) request.getAttribute("userId");
		int result = cartService.deleteService(member_id, art_id);

		return result > 0 ? "delete성공" : "delete실패";
	}

}

/* model.addAttribute("cartList",cartService.selectAll(member_id)); */
