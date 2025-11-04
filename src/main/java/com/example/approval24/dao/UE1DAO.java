package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.UE1DTO;

@Mapper
public interface UE1DAO {
	public UE1DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(UE1DTO ue1dto); 
	
	public int insertInfo(UE1DTO ue1dto);
	
}
 