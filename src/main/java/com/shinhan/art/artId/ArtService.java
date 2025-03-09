package com.shinhan.art.artId;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.CategoriesDTO;
import com.shinhan.VO.MembersDTO;
import com.shinhan.VO.MiniCategoriesDTO;

@Service
public class ArtService {

	@Autowired
	ArtDAOMybatis artDAO;
	
	public MembersDTO selectByMemberIdService(int member_id) {
		return artDAO.selectByMemberID(member_id);
	}

	public ArtsDTO selectByArtIdService(int art_id) {
		return artDAO.selectByArtId(art_id);
	}

	public List<CategoriesDTO> selectAllCategoryService() {
		System.out.println("���Ͷ�" + artDAO.selectAllCategory().toString());
		return artDAO.selectAllCategory();
	}

	public List<MiniCategoriesDTO> selectAllMiniCategoryService(int categoryId) {
		System.out.println("�̴Ϲ̴Ͼ�" + artDAO.selectAllMiniCategory(categoryId).toString());
		return artDAO.selectAllMiniCategory(categoryId);
	}

	// Ư�� miniī�װ��� ��з� ��ȸ
	public MiniCategoriesDTO selectArtCategoryIDService(int mini_category_id) {
		return artDAO.selectArtCategoryID(mini_category_id);
	}

	// ī�װ� Ÿ�� �ҷ�����
	public CategoriesDTO selectArtCategoryType(int category_id) {
		return artDAO.selectArtCategoryType(category_id);
	}

	public int insertService(ArtsDTO art) {
		return artDAO.insert(art);
	}

	public int updateService(ArtsDTO art) {
		return artDAO.update(art);
	}
	//when get view detail page 
	public int viewplus(ArtsDTO art) {
		return artDAO.viewplus(art);
	}
	
	
	public int deleteService(int art_id) {
		return artDAO.delete(art_id);
	}
	
	public int updateIsExist(int art_id) {
		return artDAO.updateIsExist(art_id);
	}
}
