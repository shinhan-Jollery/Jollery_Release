package com.shinhan.art.artId;

import java.io.File;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/test")
public class FileTestController {
	
    private static final String UPLOAD_DIR = "C:/jollery_web/upload/"; // 파일 저장 경로

    @PostMapping("/upload")
    public ResponseEntity<?> uploadFiles(
    		@RequestParam(value = "files", required = false) List<MultipartFile> files,
            @RequestParam(value = "letters", required = false) List<String> letters) {
    		System.out.println("/test/upload 오는중");

        try {
            // 파일이 없을 경우 에러 반환
            if (files == null || files.isEmpty()) {
                return ResponseEntity.badRequest().body("파일이 없습니다.");
            }

            // letters가 없거나 크기가 맞지 않으면 에러 반환
            if (letters == null || letters.size() != files.size()) {
                return ResponseEntity.badRequest().body("파일 순서 정보가 잘못되었습니다.");
            }

            // 업로드된 파일들을 역할별로 저장
            for (int i = 0; i < files.size(); i++) {
                MultipartFile file = files.get(i);
                String role = letters.get(i); // 역할 이름 가져오기

                if (file != null && !file.isEmpty()) {
                    String originalFilename = file.getOriginalFilename();

                    // 저장할 파일 경로 생성
                    File destinationFile = new File(UPLOAD_DIR, role + "_" + originalFilename);

                    // 파일 저장
                    file.transferTo(destinationFile);
                    System.out.println(role + " 저장 완료: " + destinationFile.getAbsolutePath());
                }
            }

            return ResponseEntity.ok("파일 업로드 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("파일 업로드 실패");
        }
    }
}

