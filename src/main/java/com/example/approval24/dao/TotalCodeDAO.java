package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.TotalCodeDTO;

@Mapper
public interface TotalCodeDAO {
	// 코드 목록
	public List<TotalCodeDTO> getAllTotalCode();
	
	// 코드 상세
	public TotalCodeDTO TotalCodeInfo(String codeId);
	
	// 코드 수정, 삭제
	public int TotalCodeUpd(TotalCodeDTO codeDTO);
	
	// 코드 등록
	public int TotalCodeInsert(TotalCodeDTO codeDTO);
}
