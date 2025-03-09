package com.shinhan.pay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.shinhan.VO.MembersDTO;
import com.shinhan.order.OrderService;

import java.util.Map;

@RestController
@RequestMapping("/pcpay")
public class PayRestController {

    @Autowired
    private PayService payService; // PayService 주입
    @Autowired
    private OrderService orderService;

    @GetMapping("/paymentinfo/{orderId}")
    public ResponseEntity<?> getPaymentInfo(@PathVariable String orderId) {
        try {
            // 서비스 호출 (결제 정보 JSON 반환)
            Map<String, Object> paymentInfo = payService.getPayment(orderId);

            // JSON 데이터를 그대로 반환
            System.out.println("pcpayrestcontroller");
            System.out.println(paymentInfo);
            return ResponseEntity.ok(paymentInfo);
        } catch (Exception e) {
            // 에러 처리
            return ResponseEntity.badRequest().body(Map.of(
                "error", "결제 정보를 가져오는 데 실패했습니다.",
                "message", e.getMessage()
            ));
        }
    }
    
	@PostMapping(value = "/paychecker")
	public void paychecker(@RequestBody Map<String, Object> requestBody) {
		Map<String, String> order_paymentMethod = (Map<String, String>) requestBody.get("paymentMethod");
		System.out.println(order_paymentMethod.get("code"));
		String paymentMethod = order_paymentMethod.get("code");
		System.out.println(paymentMethod);
		String deliveryMessage = (String) requestBody.get("deliveryMessage");
		String memberName = (String) requestBody.get("memberName");
		Integer member_id = Integer.parseInt((String) requestBody.get("member_id"));
//		String member_id = (String) requestBody.get("member_id");
//		System.out.println(requestBody.get("amount"));
		//배송료 삭제로 인한 필요 X
//		Integer amount = Integer.parseInt((String) requestBody.get("amount"));
		orderService.processOrder(member_id,deliveryMessage,paymentMethod);
		

	}
	
	
}

