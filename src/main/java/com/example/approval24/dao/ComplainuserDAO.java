package com.example.approval24.dao;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.ComplainRegDTO;
import com.example.approval24.domain.ComplainuserDTO;

@Mapper 
public interface ComplainuserDAO {
	
	public int countByResidentNo(String ResidentNo);
	
	public void updateUserInfo(ComplainRegDTO dto);
	
	public void registUserInfo(ComplainRegDTO dto);
	
	public int findByResidentNo(String ResidentNo);
	
	public ComplainuserDTO findByComplainuserNo(int complainuserNo);

	public int updateComplainuserInfo(ComplainuserDTO dto);

}
