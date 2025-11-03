package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.UE2DTO;

@Mapper
public interface UE2DAO {
	public UE2DTO findByComplainId(long complainId);

	public int existByComplainId(long complainId);

	public int updateInfo(UE2DTO ue2dto); 
	
	public int insertInfo(UE2DTO ue2dto);
	
}
 