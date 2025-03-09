package com.shinhan.pay;

import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Map;

@Service
public class PayService {

    private static final String API_URL = "https://api.tosspayments.com/v1/payments/orders/";
    private static final String SECRET_KEY = "test_sk_zXLkKEypNArWmo50nX3lmeaxYG5R";

    public Map<String, Object> getPayment(String orderId) {
        HttpURLConnection connection = null;
        BufferedReader reader = null;

        try {
            // API URL 생성
            URL url = new URL(API_URL + orderId);

            // 인증 헤더 생성
            String encodedKey = Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes());

            // HttpURLConnection 설정
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Authorization", "Basic " + encodedKey);
            connection.setRequestProperty("Content-Type", "application/json");

            // 응답 코드 확인
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 200 OK
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder response = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }

                // JSON 응답을 Map으로 변환
                ObjectMapper objectMapper = new ObjectMapper();
                return objectMapper.readValue(response.toString(), Map.class);
            } else {
                throw new RuntimeException("API 호출 실패: HTTP 응답 코드 " + responseCode);
            }

        } catch (Exception e) {
            throw new RuntimeException("결제 정보를 가져오는 도중 오류 발생: " + e.getMessage(), e);
        } finally {
            try {
                if (reader != null) reader.close();
                if (connection != null) connection.disconnect();
            } catch (Exception e) {
                throw new RuntimeException("리소스 해제 중 오류 발생: " + e.getMessage(), e);
            }
        }
    }
}
