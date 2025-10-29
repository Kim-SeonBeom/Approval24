package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.ComplainRegDTO;

@Mapper
public interface ComplainUserDAO {
	
	public int countByResidentNo(String ResidentNo);
	
	public void updateUserInfo(ComplainRegDTO dto);
	
	public void registUserInfo(ComplainRegDTO dto);
	
	public int findByResidentNo(String ResidentNo);

}
