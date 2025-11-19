package com.example.approval24.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController; // @Controller 대신 RestController 사용 권장

@RestController // 💡 @ResponseBody를 포함하는 RESTful 컨트롤러
@RequestMapping("/api/event") // 💡 좀 더 명확한 API 경로 설정
public class EventController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // POST 요청으로 메시지를 트리거하고, 특정 유저에게 개인 알림을 보냅니다.
    @PostMapping("/notify-user")
    public ResponseEntity<String> triggerUserNotification(@RequestParam String message) {
        // 💡 전송 대상 유저 ID (현재는 하드코딩된 '103')
        final String userId = "103";
        
        System.out.println("--- API Trigger: 개인 알림 전송 시도 (Target: " + userId + ") ---");
        
        try {
            // 이 호출이 성공하려면, Principal이 STOMP 세션에 '103'으로 등록되어 있어야 합니다.
            // 클라이언트는 '/user/queue/alerts'를 구독해야 합니다.
            messagingTemplate.convertAndSendToUser(userId, "/queue/alerts", message);
            
            System.out.println("✅ 알림 전송 메서드 호출 완료 (Target: " + userId + ")");
            
            // 성공 시 200 OK와 함께 메시지를 반환
            return new ResponseEntity<>("유저 " + userId + "에게 알림 전송 호출 완료.", HttpStatus.OK);
            
        } catch (Exception e) {
            System.err.println("❌ 알림 전송 중 예외 발생: " + e.getMessage());
            e.printStackTrace();
            
            // 실패 시 500 Internal Server Error와 함께 에러 메시지 반환
            return new ResponseEntity<>("알림 전송 실패: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}