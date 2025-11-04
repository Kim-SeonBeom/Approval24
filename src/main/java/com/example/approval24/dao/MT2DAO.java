package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.MT2DTO;

@Mapper
public interface MT2DAO {
	public MT2DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(MT2DTO mt2dto); 
	
	public int insertInfo(MT2DTO mt2dto);
	
}
 