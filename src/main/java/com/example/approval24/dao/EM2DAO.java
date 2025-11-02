package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.EM2DTO;

@Mapper
public interface EM2DAO {
	public EM2DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(EM2DTO em2dto); 
	
	public int insertInfo(EM2DTO em2dto);
	
}
 