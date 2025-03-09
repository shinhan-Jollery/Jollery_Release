package com.shinhan.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.OrdersDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository 
public class OrderDAOMybatis  {

	@Autowired
	SqlSession sqlSession;
	
	String namespaceOrder = "com.shinhan.order.";
	String namespaceOrderItem = "com.shinhan.orderItem.";
	String namespaceCart ="com.shinhan.cart";
	
	
	public List<Map<String, Object>> selectById(int order_id) {
		List<Map<String, Object>> orderItem = sqlSession.selectList(namespaceOrderItem + "selectByOrderId", order_id);
		return orderItem;
	}
	
	 // orders 테이블에 데이터 삽입
    public int insertOrder(OrdersDTO order) {
        sqlSession.insert(namespaceOrder + "insertOrder", order);
        return order.getOrder_id(); // 자동 생성된 order_id 반환
    }

    // carts 테이블에서 특정 member_id의 art_ID 가져오기
    public List<Integer> getCartsByMemberId(int member_id) {
        return sqlSession.selectList("com.shinhan.cart.getCartsByMemberId", member_id);
    }

    // order_items 테이블에 데이터 삽입
    public void insertOrderItem(int art_id, int order_id) {
        Map<String, Object> params = Map.of("art_id", art_id, "order_id", order_id);
        sqlSession.insert("com.shinhan.order.insertOrderItem", params);
    }
    
    public int updateStatus(int order_id) {
    	return sqlSession.update(namespaceOrder + "updateStatus", order_id);
    }
}
