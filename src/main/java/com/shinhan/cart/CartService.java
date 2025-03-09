package com.shinhan.cart;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.CartsDTO;

@Service
public class CartService {

	@Autowired
	CartMyBatisDAO cartDAO;
	
	/*
	 * public List<ArtsDTO> selectAll (int member_id) {
	 * 
	 * return cartDAO.selectAll(member_id); }
	 */
	
	public int insertCart(CartsDTO cartsDTO) {
		return cartDAO.insertCart(cartsDTO);
	}

	public int deleteService(int member_id, int art_id) {
		return cartDAO.delete(member_id, art_id);
	}
	public int outOfStock( int art_id) {
		return cartDAO.outOfStock(art_id);
	}
	public int deleteCarts(int member_id) {
		return cartDAO.deleteCarts(member_id);
	}

	public List<Map<String,Object>> selectCategory(Integer member_id) {
		return cartDAO.selectCategory(member_id);
	}
	
}
