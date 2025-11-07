package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.ComplainDTO;

@Mapper
public interface ComplainDAO {
	public List<ComplainDTO> getMyWorks(long accountId);
	
	public int registComplain(ComplainDTO complainDTO);

	public List<ComplainDTO> findByDeptOfAccountId(long accountId);
	
	public ComplainDTO findById(long complainId);

	public List<ComplainDTO> findByCategoryId(long complainCategoryId);
	
	public int updateStatusByComplainId(@Param("complainID") long complainId, @Param("codeId") String codeId);
	
}
