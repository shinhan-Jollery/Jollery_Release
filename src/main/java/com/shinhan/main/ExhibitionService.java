package com.shinhan.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.VO.ExhibitionsDTO;

@Service
public class ExhibitionService {
	@Autowired
	private ExhibitionDAO exhibitionDAO;
	
	
	public List<ExhibitionsDTO> selectAllExhibition(){
		return exhibitionDAO.selectAllExhibition();
	}
}
