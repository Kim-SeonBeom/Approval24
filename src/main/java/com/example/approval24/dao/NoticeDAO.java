package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.noticeDTO;

@Mapper
public interface NoticeDAO {
	public List<noticeDTO> noticeList();
	
}
