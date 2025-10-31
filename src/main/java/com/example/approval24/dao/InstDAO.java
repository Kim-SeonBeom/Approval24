package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.InstDTO;

@Mapper
public interface InstDAO {
	public List<InstDTO> getAllInst();
	
	public int insertInst(InstDTO instDTO);
	
	public int updateInst(InstDTO instDTO);
	
	public int deleteInst(int instId);
	
	public InstDTO getInstById(int instId);
	
	// 기관명 리스트
	public List<InstDTO> getAllInstName();
}
