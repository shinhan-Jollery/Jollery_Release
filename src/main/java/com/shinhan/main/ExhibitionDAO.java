package com.shinhan.main;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.VO.ExhibitionsDTO;
@Repository
public class ExhibitionDAO {
	@Autowired
	SqlSession sqlSession;
	
	public List<ExhibitionsDTO> selectAllExhibition(){
		
		return sqlSession.selectList("com.shinhan.exhibition.selectAllExhibition");
	}
}
