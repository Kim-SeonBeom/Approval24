package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.MT1DTO;

@Mapper
public interface MT1DAO {
	public MT1DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(MT1DTO mt1dto); 
	
	public int insertInfo(MT1DTO mt1dto);
	
}
 