package com.shinhan.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.CartsDTO;

@Repository
public class CartMyBatisDAO {

	@Autowired
	SqlSession sqlSession;
	
	/*
	 * public List<ArtsDTO> selectAll (int member_id) { return
	 * sqlSession.selectList("com.shinhan.cart.selectAll", member_id);
	 * 
	 * }
	 */
	
	
	public int insertCart(CartsDTO cartsDTO) {
		return sqlSession.insert("com.shinhan.cart.insertCart", cartsDTO);
	}

	public int delete(int member_id, int art_id) {
		Map<String, Object> params = new HashMap<>();
		params.put("member_id", member_id);
		params.put("art_id", art_id);
		return sqlSession.delete("com.shinhan.cart.delete", params);
	
	}

	//장바구니 내 상품 관련 정보 가져오기
	public List<Map<String, Object>> selectCategory(Integer member_id) {
		return sqlSession.selectList("com.shinhan.cart.selectCategory", member_id);
	}
	
	//장바구니 통쨰로 삭제
	public int deleteCarts(int member_id) {
		return sqlSession.delete("com.shinhan.cart.deletecarts", member_id);
	}
	
	public int outOfStock(int art_id) {
		return sqlSession.delete("com.shinhan.cart.outOfStock", art_id);
	
	}
	
	
	
}
