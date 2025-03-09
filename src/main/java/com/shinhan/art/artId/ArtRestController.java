package com.shinhan.art.artId;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.shinhan.VO.ArtsDTO;
import com.shinhan.VO.MiniCategoriesDTO;
import com.shinhan.util.S3uploadUtil;

@RestController
@RequestMapping("/art")
public class ArtRestController {

	@Autowired
	private S3uploadUtil s3uploadUtil;
	@Autowired
	private ArtService artService;

	@PostMapping("/insert")
	public ResponseEntity<?> insertArt(@RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "subcategory", required = false) String subcategory,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "price", required = false) Integer price,
			@RequestParam(value = "size", required = false) String size,
			@RequestParam(value = "smartEditorContent", required = false) String smartEditorContent,
			@RequestParam(value = "files", required = false) List<MultipartFile> files,
			@RequestParam(value = "letters", required = false) List<String> letters,
			@RequestParam(value = "userId", required = false) int userId) {

		System.out.println("/jollery/art/insert 요청 처리 중");

		try {
			// 작품 정보 처리
			ArtsDTO artDTO = ArtsDTO.builder().mini_category_id(Integer.parseInt(subcategory)).art_title(title)
					.art_price(price).art_size(size).member_id(userId).art_description(smartEditorContent)
					.art_status("판매 중") // 기본 상태 설정
					.build();
	        System.out.println(files);
	        System.out.println("입력 요청 데이터: " + artDTO);
			if (files != null && letters != null && files.size() == letters.size()) {
				List<String> uploadedUrls = new ArrayList<>();

				for (int i = 0; i < files.size(); i++) {
					MultipartFile file = files.get(i);
					String role = letters.get(i); // 역할 이름 가져오기

					if (file != null && !file.isEmpty()) {
						UUID uuid = UUID.randomUUID();
						String originalFilename = file.getOriginalFilename();
						String s3FileName = role + "_" + uuid + originalFilename;

						// S3에 파일 업로드
						String s3Url = s3uploadUtil.uploadToS3(file, s3FileName);
						uploadedUrls.add(s3Url); // 업로드된 URL 저장

						// 역할에 따라 DTO 필드 업데이트
						switch (role) {
						case "썸네일":
							artDTO.setArt_thumbnail_image(s3Url);
							break;
						case "썸네일2":
							artDTO.setArt_hovering_image(s3Url);
							break;
						case "이미지1":
							artDTO.setArt_image2(s3Url);
							break;
						case "이미지2":
							artDTO.setArt_image3(s3Url);
							break;
						case "이미지3":
							artDTO.setArt_image4(s3Url);
							break;
						case "이미지4":
							artDTO.setArt_image5(s3Url);
							break;
						default:
							System.out.println("알 수 없는 역할: " + role);
						}
					}
				}

				// DB에 저장 (업로드된 URL 수만큼만)
				int result = artService.insertService(artDTO); // insert 후 성공 여부 반환
				System.out.println("DB 저장 결과: " + result);

				if (result > 0) { // 성공적으로 저장된 경우
					return ResponseEntity.ok(Map.of("status", "success", "message", "작품 등록 및 파일 업로드 성공"));
				}
			} else { // 실패한 경우
				return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 등록 실패"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 등록 중 오류 발생"));
		}
		return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 등록 실패"));
	}

	@PostMapping("/{art_id}/update")
	public ResponseEntity<?> updateArt(
	        @PathVariable int art_id,
	        @RequestParam(value = "category", required = false) String category,
			@RequestParam(value = "subcategory", required = false) String subcategory,
			@RequestParam(value = "title", required = false) String title,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "price", required = false) Integer price,
			@RequestParam(value = "size", required = false) String size,
			@RequestParam(value = "smartEditorContent", required = false) String smartEditorContent,
			@RequestParam(value = "files", required = false) List<MultipartFile> files,
			@RequestParam(value = "letters", required = false) List<String> letters,
			@RequestParam(value = "userId", required = false) Integer userId) {

	    System.out.println("/jollery/art/update 요청 처리 중");
	    

	    try {
	        ArtsDTO artDTO = ArtsDTO.builder()
	                .art_id(art_id)
	                .mini_category_id(Integer.parseInt(subcategory))
	                .art_title(title)
	                .art_price(price)
	                .art_size(size)
	                .art_description(smartEditorContent)
	                .art_status(status)
	                .build();
	        System.out.println(files);
	        System.out.println("업데이트 요청 데이터: " + artDTO);
	        if (files != null && letters != null && files.size() == letters.size()) {
				List<String> uploadedUrls = new ArrayList<>();
				for (int i = 0; i < files.size(); i++) {
					MultipartFile file = files.get(i);
					String role = letters.get(i); // 역할 이름 가져오기

					if (file != null && !file.isEmpty()) {
						UUID uuid = UUID.randomUUID();
						String originalFilename = file.getOriginalFilename();
						String s3FileName = role + "_" + uuid + originalFilename;

						// S3에 파일 업로드
						String s3Url = s3uploadUtil.uploadToS3(file, s3FileName);
						uploadedUrls.add(s3Url); // 업로드된 URL 저장

						// 역할에 따라 DTO 필드 업데이트
						switch (role) {
						case "썸네일":
							artDTO.setArt_thumbnail_image(s3Url);
							break;
						case "썸네일2":
							artDTO.setArt_hovering_image(s3Url);
							break;
						case "이미지1":
							artDTO.setArt_image2(s3Url);
							break;
						case "이미지2":
							artDTO.setArt_image3(s3Url);
							break;
						case "이미지3":
							artDTO.setArt_image4(s3Url);
							break;
						case "이미지4":
							artDTO.setArt_image5(s3Url);
							break;
						default:
							System.out.println("알 수 없는 역할: " + role);
						}
					}
				}

	        // 서비스 호출
	        int result = artService.updateService(artDTO);
	        System.out.println("DB 업데이트 결과: " + result);

	        if (result > 0) { // 성공적으로 저장된 경우
				return ResponseEntity.ok(Map.of("status", "success", "message", "작품 수정 성공"));
			}
		} else { // 실패한 경우
			return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 수정 실패"));
		}
	} catch (Exception e) {
		e.printStackTrace();
		return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 수정 중 오류 발생"));
	}
	return ResponseEntity.status(500).body(Map.of("status", "error", "message", "작품 수정 실패"));
}
	
	
	@GetMapping(value = "/api/insert")
	public List<MiniCategoriesDTO> selectmini(Integer category_id) {
		// int categoryId =Integer.parseInt(request.get("category_id"));
		return artService.selectAllMiniCategoryService(category_id);
	}

	@PutMapping("/delete/{art_id}")
	public ResponseEntity<Map<String, String>> deleteArt(@PathVariable int art_id) {
		Map<String, String> response = new HashMap<>();

		try {
			int result = artService.updateIsExist(art_id);

			if (result > 0) {
				response.put("status", "success");
				response.put("message", "삭제성공.");
			} else {
				response.put("status", "failure");
				response.put("message", "삭제실패.");
			}

			return ResponseEntity.ok(response);
		} catch (Exception e) {
			response.put("status", "error");
			response.put("message", "An error occurred while deleting the artwork.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

//	@GetMapping("/getdetail/{art_id}")
//	public ResponseEntity<ArtsDTO> detail(@PathVariable int art_id) {
//		ArtsDTO art = artService.selectByArtIdService(art_id);
//		if (art != null) {
//			return ResponseEntity.ok(art);
//		} else {
//			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
//		}
//
//	}
}
