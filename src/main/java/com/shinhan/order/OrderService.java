package com.shinhan.order;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.OrdersDTO;
import com.shinhan.cart.CartService;

@Service
public class OrderService {

	@Autowired
	OrderDAOMybatis orderDAO;
	@Autowired
	CartService cartService;
	
	public List<Map<String, Object>> selectByIdService(int order_id) {
		return orderDAO.selectById(order_id);
	}

    // 주문db저장
    public Map<String, Object> processOrder(int member_id, String deliveryMessage,String order_paymentMethod) {
        Map<String, Object> response = new HashMap<>();
        boolean isSuccess = false;

        try {
            // orders 테이블에 값 삽입
            OrdersDTO order = new OrdersDTO();
            order.setMember_id(member_id);
            order.setOrder_date(LocalDateTime.now());
            order.setOrder_request(deliveryMessage);
            order.setOrder_paymentMethod(order_paymentMethod);

            int orderId = orderDAO.insertOrder(order); // order_id 받기

            // carts 테이블에서 art_ID 받기
            List<Integer> artIds = orderDAO.getCartsByMemberId(member_id);

            //order_items 테이블에 art_ID와 order_ID 삽입
            for (int artId : artIds) {
                orderDAO.insertOrderItem(artId, orderId);
              //다른 사람 카트에서 해당 제품 없애기
                cartService.outOfStock(artId);
            }
            cartService.deleteCarts(member_id);
    		
            // 모두 성공시
            isSuccess = true;
        } catch (Exception e) {
            e.printStackTrace();
            isSuccess = false; // 예외 발생 시 실패로 설정
        }

        // 실행 결과 반환
        if (isSuccess) {
            response.put("status", "success");
            response.put("message", "성공적으로 주문되었습니다.");
        } else {
            response.put("status", "fail");
            response.put("message", "주문이 실패하였습니다.");
        }

        return response;
    }
    
    public int updateStatus(int order_Id) {
    	return orderDAO.updateStatus(order_Id);
    }
}
