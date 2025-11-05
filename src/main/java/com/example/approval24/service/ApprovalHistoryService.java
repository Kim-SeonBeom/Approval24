package com.example.approval24.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.ApprovalHistoryDAO;
import com.example.approval24.domain.ApprovalHistoryDTO;

@Service
public class ApprovalHistoryService {

    @Autowired
    private  ApprovalHistoryDAO approvalHistoryDAO;

    @Transactional(readOnly = true) 
    public List<ApprovalHistoryDTO> getMyApprovalHistoryList(
            Long accountId, 
            Map<String, Object> filterMap) {
        return approvalHistoryDAO.selectMyApprovalHistoryList(accountId, filterMap);
    }
    

    @Transactional
    public int processApprovalHistory(ApprovalHistoryDTO approvalData) {
        
        // 1. 비즈니스 로직 (필수 값 체크)
        if (approvalData.getComplainId() == null || approvalData.getApprovalStatusCd() == null) {
            throw new IllegalArgumentException("필수 결재 정보가 누락되었습니다.");
        }
        
        int result = 0;
        
        // 2. SEQ_NO의 유무로 삽입 또는 갱신 결정
        if (approvalData.getSeqNo() == null) {
            // 최초 결재 등록 시, 민원(COMPLAIN) 테이블의 상태도 업데이트
            
            result = approvalHistoryDAO.insertApprovalHistory(approvalData); 
            
        } else {
            if (approvalData.getSeqNo() == null) {
                throw new IllegalArgumentException("기존 이력 갱신 시에는 SEQ_NO가 필수입니다.");
            }
            result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
            
            // 최종 승인/반려 시, 민원(COMPLAIN) 테이블의 최종 상태를 업데이트
        }
        
        return result;
    }


    @Transactional 
    public void createApprovalLine(Long loginId, Long complainId,String url, List<ApprovalHistoryDTO> approvalLine) {
        
        if (complainId == null || approvalLine == null || approvalLine.isEmpty()) {
            throw new IllegalArgumentException("민원 ID 또는 결재 라인 정보가 유효하지 않습니다.");
        }
        
        
        for (int i = 0; i < approvalLine.size(); i++) {
            ApprovalHistoryDTO dto = approvalLine.get(i);

            dto.setComplainId(complainId); 
            if (dto.getAccountId() == null) {
                 throw new IllegalArgumentException((i + 1) + "번째 결재 단계의 **계정 ID**가 누락되었습니다.");
            }

            String approvalStatusCd;
            if (i == 0) {
            	if(loginId != dto.getAccountId())
            	{
            		throw new IllegalArgumentException("결재 시작이 본인 계정이 아닙니다.");
            	}
                approvalStatusCd = "E002";  //승인
            } else if (i == 1) {
                approvalStatusCd = "E001"; // 결재
            }
            else {
            	approvalStatusCd = "E004"; // 대기
            }
            dto.setApprovalStatusCd(approvalStatusCd);
            dto.setUrl(url);
            
            // approverTypeCd (검토자/승인자) 체크 
            if (dto.getApproverTypeCd() == null || (!dto.getApproverTypeCd().equals("F001") && 
            		!dto.getApproverTypeCd().equals("F002") && !dto.getApproverTypeCd().equals("F003")
            		&& !dto.getApproverTypeCd().equals("F004"))) {
                 throw new IllegalArgumentException((i + 1) + "번째 결재 단계의 **승인자 유형 코드**가 누락되었거나 잘못되었습니다.");
            }
            
            approvalHistoryDAO.insertApprovalHistory(dto);
        }
    }
    
}