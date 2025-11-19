package com.example.approval24.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.approval24.domain.AlarmDTO;
import com.example.approval24.service.AlarmService;


@RestController
@RequestMapping("/api/notification")
public class NotificationApiController {

    @Autowired
    private AlarmService alarmService;

    private static final String USER_ID_SESSION_KEY = "user"; 

    private Long getUserIdFromSession(HttpSession session) {
        Object userIdObj = session.getAttribute(USER_ID_SESSION_KEY);
        if (userIdObj == null) {
            return null;
        }
        
        if (userIdObj instanceof Long) {
            return (Long) userIdObj;
        }
        
        try {
            return Long.parseLong(String.valueOf(userIdObj));
        } catch (NumberFormatException e) {
            System.err.println("세션 사용자 ID 포맷 오류: " + userIdObj);
            return null;
        }
    }


    @GetMapping("/unread-count")
    public int getUnreadCount(HttpSession session) {
        Long receiverId = getUserIdFromSession(session);
        
        if (receiverId == null) {
            return 0; 
        }
        return alarmService.countUnreadAlarms(receiverId);
    }


    @GetMapping("/recent")
    public List<AlarmDTO> getRecentAlarms(HttpSession session) {
        Long receiverId = getUserIdFromSession(session);
        
        if (receiverId == null) {
            return null;
        }
        // Long을 String으로 변환하여 Service에 전달
        return alarmService.getRecentAlarms(receiverId);
    }

    // =========================================================================
    // 3. 알람 읽음 처리
    // =========================================================================
    @PostMapping("/read/{seqNo}")
    public ResponseEntity<String> markNotificationAsRead(@PathVariable Long seqNo, HttpSession session) {
        // 알람 시퀀스 번호 (seqNo)는 이미 Long으로 자동 바인딩됩니다.
        Long accessorId = getUserIdFromSession(session);
        
        if (accessorId == null) {
            return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
        }
        

        try {
            alarmService.markAsRead(seqNo, accessorId);
            return new ResponseEntity<>("알람 읽음 처리 및 갱신 신호 발송 완료.", HttpStatus.OK);
            
        } catch (SecurityException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.FORBIDDEN);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>("서버 오류로 읽음 처리 실패.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}