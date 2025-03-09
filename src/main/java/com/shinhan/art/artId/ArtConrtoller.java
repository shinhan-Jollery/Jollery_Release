package com.shinhan.art.artId;

import java.text.NumberFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.CategoriesDTO;
import com.shinhan.VO.MembersDTO;
import com.shinhan.VO.MiniCategoriesDTO;
import com.shinhan.auth.AuthInfoUpdateService;

//@RestController
@Controller
@RequestMapping("/art")
public class ArtConrtoller {

	@Autowired
	ArtService artService;

	@Autowired
	AuthInfoUpdateService authService;

	@GetMapping(value = "/insert")
	public String insertPage(HttpServletRequest request, Model model) {

		Integer userId = (Integer) request.getAttribute("userId");
		String memberName = (String) request.getAttribute("Member_name");
		String isArtist = (String) request.getAttribute("isArtist");
		model.addAttribute("userId", userId);
		model.addAttribute("isArtist", isArtist);
		model.addAttribute("memberName", memberName);

		List<CategoriesDTO> categories = artService.selectAllCategoryService();
		System.out.println(categories);
		model.addAttribute("categories", categories);
		return "art/artInsert";
	}

	@GetMapping(value = "/test")
	public String test() {
		return "art/test";
	}

	@GetMapping(value = "/{art_id}/update")
	public String updatePage(@PathVariable int art_id, Model model, HttpServletRequest request) {

		Integer userId = (Integer) request.getAttribute("userId");
		String memberName = (String) request.getAttribute("Member_name");
		String isArtist = (String) request.getAttribute("isArtist");
		model.addAttribute("userId", userId);
		model.addAttribute("isArtist", isArtist);
		model.addAttribute("memberName", memberName);

		ArtsDTO artsDTO = artService.selectByArtIdService(art_id);
		System.out.println("작품 정보 업데이트");
		model.addAttribute("artInfo", artsDTO);

		// art_id로 artDTO에서 member_id를 접근
		// 그 멤버id가 user_id와 다르면 접근을 막기(main으로 보내거나 허용되지 않는 접근입니다.)
		/*
		 * int member_id = artsDTO.getMember_id(); if (member_id == userId) {
		 * 
		 * return "main/main"; }
		 */

		MiniCategoriesDTO minicategoryDTO = artService.selectArtCategoryIDService(artsDTO.getMini_category_id());
		model.addAttribute("minicategoryDTO", minicategoryDTO);

		CategoriesDTO categoryDTO = artService.selectArtCategoryType(minicategoryDTO.getCategory_id());
		model.addAttribute("categoryDTO", categoryDTO);
		ArtsDTO mini_category = new ArtsDTO();
		List<CategoriesDTO> categories = artService.selectAllCategoryService();
		model.addAttribute("categories", categories);
		System.out.println();
		return "art/artUpdate";
	}

	@GetMapping(value = "/detail/{art_id}")
	public String detailPage(@PathVariable int art_id, Model model, HttpServletRequest request) {
		
		Integer userId = (Integer) request.getAttribute("userId");
		String memberName = (String) request.getAttribute("Member_name");
		String isArtist = (String) request.getAttribute("isArtist");
		model.addAttribute("userId", userId);
		model.addAttribute("isArtist", isArtist);
		model.addAttribute("memberName", memberName);
		ArtsDTO artsDTO = artService.selectByArtIdService(art_id);
		MembersDTO memberDTO = authService.getMemberInfo(artsDTO.getMember_id());

		if (userId != null && userId.equals(artsDTO.getMember_id())) {
		    System.out.println("내꺼야!");
		    model.addAttribute("owner", "true");
		}

		//조회수 올리기
		artService.viewplus(artsDTO);
		model.addAttribute("art_id", art_id);
		model.addAttribute("artsDTO", artsDTO);

		MiniCategoriesDTO minicategoryDTO = artService.selectArtCategoryIDService(artsDTO.getMini_category_id());
		model.addAttribute("minicategoryDTO", minicategoryDTO);

		CategoriesDTO categoryDTO = artService.selectArtCategoryType(minicategoryDTO.getCategory_id());
		model.addAttribute("categoryDTO", categoryDTO);

		// member_id�� ���� members ���̺��� member_name ��������

		model.addAttribute("member_name", memberDTO.getMember_name());

		NumberFormat numberFormat = NumberFormat.getInstance();
		String formattedPrice = numberFormat.format(artsDTO.getArt_price());
		model.addAttribute("formattedPrice", formattedPrice);

		return "art/artDetail";
	}

}
