package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.EM1DTO;

@Mapper
public interface EM1DAO {
	public EM1DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(EM1DTO em1dto); 
	
	public int insertInfo(EM1DTO em1dto);
	
}
 