package com.shinhan.pay;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pcpay")
public class PayController {
	
	@GetMapping("/tosspay")
	public String tosspay() {
		return "pay/tosspay";
	}
	@GetMapping("/tosspay1")
	public String tosspay1() {
		return "error/error";
	}
	@GetMapping
	public String checkout() {
		return "pay/checkout";
	}
	
////	@GetMapping("/success")
////	public String successToss() {
////		
//		System.out.println(2);
//		return "pay/success";
//	}
}
