package com.shinhan.cart;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.CartsDTO;
import com.shinhan.art.artId.ArtService;

@RestController
@RequestMapping("/cart")
public class CartRestController {
	@Autowired
	CartService cartService;
	@Autowired
	ArtService artService;
	
	// 카트 추가
    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addToCart(@RequestBody CartsDTO cartsDTO) {
        Map<String, Object> response = new HashMap<>();
        try {
        	Integer member_id = cartsDTO.getMember_id();
        	Integer art_id = cartsDTO.getArt_id();
        	ArtsDTO artsDTO = artService.selectByArtIdService(art_id);
        	if(artsDTO.getMember_id() == member_id) {
                response.put("success", false);
                response.put("message", "본인의 상품은 장바구니에 담으실 수 없습니다.");
                
                return ResponseEntity.ok(response);
        	}
        	System.out.println(artsDTO.getArt_status());
        	if(!artsDTO.getArt_status().equals("판매중")) {
        		
        		response.put("success", false);
        		response.put("message", "이미 판매된 상품입니다.");
        		
        		return ResponseEntity.ok(response);
        	}
            int affectedRow = cartService.insertCart(cartsDTO);
            if (affectedRow>0) {
                response.put("success", true);
                response.put("message", "장바구니 추가 성공");
                return ResponseEntity.ok(response);
            }
            else {
                response.put("success", false);
                response.put("message", "이미 장바구니에 담긴 상품입니다.");
                return ResponseEntity.ok(response);
            }

            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "장바구니 추가 실패: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}
