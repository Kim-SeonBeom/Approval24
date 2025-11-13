package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.DelegateDTO;

@Mapper
public interface DelegateDAO {

	public List<DelegateDTO> findByAbsId(@Param("accuontId") long accountId);
	
	public int insertDelegate(DelegateDTO delegateDTO);
	
	public DelegateDTO findBySeqNo(long seqNo);

	public int updateDelegate(DelegateDTO delegateDTO);

	public int deleteDelegate(long seqNo);
	
	// 검색에 해당되는 목록 개수
	public int countByFilter(DelegateDTO filter);
	
	// 검색 조건
	public List<DelegateDTO> findByFilter(DelegateDTO filter);

}
