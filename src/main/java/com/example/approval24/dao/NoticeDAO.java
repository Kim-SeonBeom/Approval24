package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.NoticeDTO;

@Mapper
public interface NoticeDAO {
	public List<NoticeDTO> noticeList();
	
	public int saveNotice(NoticeDTO noticeDTO);
	
	public NoticeDTO getnoticeDetail(@Param("noticeId") Long notideId);
}
