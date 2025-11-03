package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.EM3DTO;

@Mapper
public interface EM3DAO {
	public EM3DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(EM3DTO em3dto); 
	
	public int insertInfo(EM3DTO em3dto);
	
}
 