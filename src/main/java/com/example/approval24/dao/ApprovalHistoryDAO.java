package com.example.approval24.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.approval24.domain.ApprovalHistoryDTO;

@Mapper
public interface ApprovalHistoryDAO {
	List<ApprovalHistoryDTO> selectMyApprovalHistoryList(Map<String, Object> filterMap);
	
	int updateApprovalHistoryStatus(ApprovalHistoryDTO approvalHistoryDTO);
	
	int insertApprovalHistory(ApprovalHistoryDTO approvalHistoryDTO);
	
	ApprovalHistoryDTO getHistoryIdByComplainIdAndSeqNo(
            @Param("complainId") Long complainId,
            @Param("seqNo") Long seqNo);
	ApprovalHistoryDTO getComplainManager(Long complainId);
	
	List<ApprovalHistoryDTO> getHistoryIdByComplainId(Long complainId);
	
	int countMyApprovalHistoryList(Map<String, Object> filterMap);
}
