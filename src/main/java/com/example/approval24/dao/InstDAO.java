package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.InstDTO;

@Mapper
public interface InstDAO {
	public List<InstDTO> getAllInst();
	
	public int insertInst(InstDTO instDTO);
	
	public int updateInst(InstDTO instDTO);
	
	public int deleteInst(long instId);
	
	public InstDTO getInstById(long instId);
	
	// 기관명 리스트
	public List<InstDTO> getAllInstName();
	
	// 검색에 해당되는 목록 개수
	public int countByFilter(InstDTO filter);
	
	// 검색 조건
	public List<InstDTO> findByFilter(InstDTO filter);
}
