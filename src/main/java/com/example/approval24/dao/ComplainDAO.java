package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.ComplainDTO;

@Mapper
public interface ComplainDAO {
	public List<ComplainDTO> getMyWorks(int accountId);
	
	public int registComplain(ComplainDTO complainDTO);
	
	
}
