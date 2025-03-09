package com.shinhan.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker // STOMP 프로토콜
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// WebSocket 엔드포인트 설정
		registry.addEndpoint("/ws") // WebSocket 연결을 위한 엔드포인트 정의
		.setAllowedOrigins("http://192.168.0.*") // 허용할 출처(도메인) 설정
		.withSockJS(); // SockJS 프로토콜을 사용하여 웹소켓이 지원되지 않는 브라우저에서도 동작하도록 설정
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// 메시지 브로커 설정
		config.enableSimpleBroker("/topic"); // 클라이언트에게 메시지를 전달할 경로 설정
		config.setApplicationDestinationPrefixes("/app"); // 클라이언트가 보낸 메시지 경로에서 사용할 접두사 설정
	}
	
}
