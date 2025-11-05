package com.example.approval24.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.approval24.domain.DelegateDTO;

@Mapper
public interface DelegateDAO {

	public List<DelegateDTO> findByAbsId(long accountId);
	
	public int insertDelegate(DelegateDTO delegateDTO);
	
	public DelegateDTO findBySeqNo(long seqNo);

	public int updateDelegate(DelegateDTO delegateDTO);

	public int deleteDelegate(long seqNo);

}
