package com.example.approval24.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import com.example.approval24.dao.NoticeDAO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.domain.NoticeFilterDTO;

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
		int result = noticeDAO.saveNotice(noticeDTO);
		return result;
	}
	// 공지사항 수정
	public int updateNotice(NoticeDTO noticeDTO) {
		int result = noticeDAO.updateNotice(noticeDTO);
		return result;
	}
	
	// 공지사항 디테일
	public NoticeDTO getnoticeDetail(Long noticeId) {
		NoticeDTO dto = noticeDAO.getnoticeDetail(noticeId);
		System.out.println(dto.toString());
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
	
	// 공지사항 필터 목록 조회
	public List<NoticeDTO>noticeFilterList(NoticeFilterDTO filter){
		return noticeDAO.noticeFilterList(filter);
	}
	
	// 공지사항 카운트
	public int noticeCountFilter(NoticeFilterDTO dto) {
		return noticeDAO.noticeCountFilter(dto);
	}

}
