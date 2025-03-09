package com.shinhan.util;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;
@Component
public class S3uploadUtil {

    private static final String BUCKET_NAME = "jollerys3";


    @Autowired
    private S3Client s3Client; 


    public String uploadToS3(MultipartFile file, String fileName) throws IOException {
        String key = "uploads/" + fileName;

        try {
            byte[] fileBytes = file.getBytes();

            s3Client.putObject(
                PutObjectRequest.builder()
                    .bucket(BUCKET_NAME)
                    .key(key)
                    .build(),
                RequestBody.fromBytes(fileBytes)
            );

            return String.format("https://%s.s3.amazonaws.com/%s", BUCKET_NAME, key);
        } catch (S3Exception e) {
            throw new RuntimeException("S3 업로드 중 오류 발생: " + e.awsErrorDetails().errorMessage(), e);
        }
    }
}

