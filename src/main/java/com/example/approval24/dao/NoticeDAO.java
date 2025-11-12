package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.NoticeDTO;
import com.example.approval24.domain.NoticeFilterDTO;

@Mapper
public interface NoticeDAO {
	public List<NoticeDTO> noticeList();
	
	public List<NoticeDTO> noticeFilterList(NoticeFilterDTO filter);
	
	public int noticeCountFilter(NoticeFilterDTO filter);
	
	public int saveNotice(NoticeDTO noticeDTO);
	
	public int updateNotice(NoticeDTO noticeDTO);
	
	public int deleteNotice(NoticeDTO noticeDTO);
	
	public NoticeDTO getnoticeDetail(@Param("noticeId") long noticeId);
	
	public void increaseViewCount(Long noticeId);
}
