package com.shinhan.art.artId;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.CategoriesDTO;
import com.shinhan.VO.MembersDTO;
import com.shinhan.VO.MiniCategoriesDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ArtDAOMybatis {
	@Autowired
	SqlSession sqlSession;

	String namespace = "com.shinhan.art.";
	
	// ��� ��ȸ
	public MembersDTO selectByMemberID(int MemberID) {
		MembersDTO member = sqlSession.selectOne(namespace + "selectByMemberID", MemberID);
		return member;
	}

	// Ư�� �̴� ī�װ��� ��з� ��ȸ
	public MiniCategoriesDTO selectArtCategoryID(int MiniCategoryID) {
		MiniCategoriesDTO category = sqlSession.selectOne(namespace + "selectArtCategoryID", MiniCategoryID);
		return category;
	}
	
	// ī�װ� Ÿ�� �ҷ�����
	public CategoriesDTO selectArtCategoryType(int CategoryID) {
		CategoriesDTO category = sqlSession.selectOne(namespace + "selectArtCategoryType", CategoryID);
		return category;
	}

	// ī�װ� ��ȸ
	public List<CategoriesDTO> selectAllCategory() {
		List<CategoriesDTO> categorylist = sqlSession.selectList("com.shinhan.category.selectAllCategory");
		return categorylist;
	}

	// �̴� ī�װ� ��ȸ
	public List<MiniCategoriesDTO> selectAllMiniCategory(int categoryId) {
		List<MiniCategoriesDTO> minicategorylist = sqlSession
				.selectList("com.shinhan.miniCategory.selectAllMiniCategory", categoryId);
		return minicategorylist;
	}

	// ��ǰ ���
	public int insert(ArtsDTO art) {
		int result = sqlSession.insert(namespace + "insert", art);
		log.info(result + "�� �Էµ�");
		return result;
	}

	// ��ǰ ����
	public int update(ArtsDTO art) {
		int result = sqlSession.update(namespace + "update", art);
		log.info(result + "�� ������");
		return result;
	}
	// plus view count 
	public int viewplus(ArtsDTO art) {
		int result = sqlSession.update(namespace + "viewplus", art);
		log.info(result + "�� ������");
		return result;
	}

	// ��ǰ ����
	public int delete(int art_id) {
		int result = sqlSession.delete(namespace + "delete", art_id);
		log.info(result + "�� ������");
		return result;
	}

	// ��ǰ ��
	public ArtsDTO selectByArtId(int art_id) {
		ArtsDTO art = sqlSession.selectOne(namespace + "selectByArtId", art_id);

		return art;
	}

	public int updateIsExist(int art_id) {
		return sqlSession.update(namespace + "updateIsExist", art_id);
	}

}
