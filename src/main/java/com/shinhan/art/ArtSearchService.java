package com.shinhan.art;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.ArtsDTO;

@Service
public class ArtSearchService {
	@Autowired
	ArtSearchDAO artSearchDAO;


	public List<ArtsDTO> selectByMiniCategoryId(int minicategoryId){
		return artSearchDAO.selectByMiniCategoryId(minicategoryId);
	}
	
	public List<ArtsDTO> selectByArtTitle(String artTitle){
		return artSearchDAO.selectByArtTitle(artTitle);
	}
	
	public List<ArtsDTO> selectByMemberName(String memberName){
		return artSearchDAO.selectByMemberName(memberName);
	}
	
	public List<ArtsDTO> getArtByRecent(){
		return artSearchDAO.getArtByRecent();
	}
	
	public List<ArtsDTO> getArtByVeiw(){
		return artSearchDAO.getArtByVeiw();
	}
	
	public List<ArtsDTO> getArtByLike(){
		return artSearchDAO.getArtByLike();
	}
	
	public List<ArtsDTO> getArtByPriceASC(){
		return artSearchDAO.getArtByPriceASC();
	}
	
	public List<ArtsDTO> getArtByPriceDESC(){
		return artSearchDAO.getArtByPriceDESC();
	}
	
	public List<ArtsDTO> getArtByPriceRange(int minPrice, int maxPrice){
		return artSearchDAO.getArtByPriceRange(minPrice, maxPrice);
	}
}
