package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.AlarmDTO;

@Mapper
public interface AlarmDAO {
	
    // 알람 저장
    void insertAlarm(AlarmDTO alarm);

    // 특정 사용자 최근 3일 알람 조회
    List<AlarmDTO> selectRecentAlarmsByReceiver(Long receiverId);

    // 읽음 처리
    void markAsRead(Long seqNo);

    // 안 읽은 알람 개수
    int countUnreadAlarms(Long receiverId);
}
