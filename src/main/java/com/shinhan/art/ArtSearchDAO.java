package com.shinhan.art;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.ArtsDTO;

@Repository
public class ArtSearchDAO {
	@Autowired
	SqlSession sqlSession;
	private static final String namespace = "com.shinhan.artSearch.";
	
	public List<ArtsDTO> selectByMiniCategoryId(Integer minicategoryId){
		return sqlSession.selectList(namespace + "selectByMiniCategoryId", minicategoryId);
	}
	
	public List<ArtsDTO> selectByArtTitle(String artTitle){
		return sqlSession.selectList(namespace + "selectByArtTitle" , artTitle);
	}
	
	public List<ArtsDTO> selectByMemberName(String memberName){
		return sqlSession.selectList(namespace + "selectByMemberName", memberName);
	}
	
	public List<ArtsDTO> getArtByRecent(){
		return sqlSession.selectList(namespace + "getArtByRecent");
	}
	
	public List<ArtsDTO> getArtByVeiw(){
		return sqlSession.selectList(namespace + "getArtByVeiw");
	}
	
	public List<ArtsDTO> getArtByLike(){
		return sqlSession.selectList(namespace + "getArtByLike");
	}
	
	public List<ArtsDTO> getArtByPriceASC(){
		return sqlSession.selectList(namespace + "getArtByPriceASC");
	}
	
	public List<ArtsDTO> getArtByPriceDESC(){
		return sqlSession.selectList(namespace + "getArtByPriceDESC");
	}
	
	public List<ArtsDTO> getArtByPriceRange(int minPrice, int maxPrice){
		 // Map 객체로 파라미터 묶기
        Map<String, Integer> params = new HashMap<>();
        params.put("minPrice", minPrice);
        params.put("maxPrice", maxPrice);

		return sqlSession.selectList(namespace + "getArtByPriceRange", params);
	}
}
