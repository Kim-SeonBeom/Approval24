package com.example.approval24.service;

import com.example.approval24.dao.AlarmDAO;
import com.example.approval24.domain.AlarmDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AlarmService {

    @Autowired
    private AlarmDAO alarmDAO;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Transactional
    public void sendAlarm(AlarmDTO alarm) {
        
        if (alarm == null) {
            throw new IllegalArgumentException("알람 정보가 없습니다.");
        }
        if (alarm.getReceiverId() == null) {
            throw new IllegalArgumentException("받는 사람 ID가 필요합니다.");
        }
        if (alarm.getMessage() == null || alarm.getMessage().isEmpty()) {
            throw new IllegalArgumentException("메시지가 비어있습니다.");
        }

        alarmDAO.insertAlarm(alarm); 

        Long receiverId = alarm.getReceiverId();
        
        messagingTemplate.convertAndSend("/topic/notification-events", "NEW_ALARM_FOR_USER:" + receiverId);
        
    }

    
    public List<AlarmDTO> getRecentAlarms(Long receiverId) {
        if (receiverId == null) {
            throw new IllegalArgumentException("받는 사람 ID가 필요합니다.");
        }
        return alarmDAO.selectRecentAlarmsByReceiver(receiverId);
    }

    
    @Transactional
    public void markAsRead(Long seqNo, Long accessorId) {
        if (seqNo == null) {
            throw new IllegalArgumentException("알람 시퀀스 번호가 필요합니다.");
        }
        if (accessorId == null) {
            throw new SecurityException("사용자 식별 정보가 없습니다.");
        }

        alarmDAO.markAsRead(seqNo);
        
        messagingTemplate.convertAndSend("/topic/notification-events", "READ_ALARM_FOR_USER:" + accessorId);
    }

    public int countUnreadAlarms(Long receiverId) {
        if (receiverId == null) {
            throw new IllegalArgumentException("받는 사람 ID가 필요합니다.");
        }
        return alarmDAO.countUnreadAlarms(receiverId);
    }
}