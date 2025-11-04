package com.example.approval24.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.example.approval24.dao.NoticeDAO;
import com.example.approval24.domain.NoticeDTO;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	
	// 공지사항 목록 조회
	public List<NoticeDTO> noticeList(){
		return noticeDAO.noticeList();
	}
	
	// 공지사항 등록
	public int saveNotice(NoticeDTO noticeDTO) {
		System.out.println("등록 서비스 시작");
		int result = noticeDAO.saveNotice(noticeDTO);
		System.out.println("등록 서비스 끝");
		return result;
	}
	// 공지사항 수정
	public int updateNotice(NoticeDTO noticeDTO) {
		int result = noticeDAO.updateNotice(noticeDTO);
		return result;
	}
	
	// 공지사항 디테일
	public NoticeDTO getnoticeDetail(Long noticeId) {
		System.out.println("서비스 시작");
		NoticeDTO dto = noticeDAO.getnoticeDetail(noticeId);
		System.out.println(dto.toString());
		System.out.println("서비스 끝");
		return noticeDAO.getnoticeDetail(noticeId);
	}
	
	// 공지사항 삭제
	public int deleteNotice(NoticeDTO noticeDTO) {
		int result = noticeDAO.deleteNotice(noticeDTO);
		return result;
	}
	
	// 공지사항 조회수 증가
	public void increaseViewCount(Long noticeId) {
		noticeDAO.increaseViewCount(noticeId);
	}

}
