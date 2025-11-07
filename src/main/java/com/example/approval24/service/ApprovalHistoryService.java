package com.example.approval24.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.ApprovalHistoryDAO;
import com.example.approval24.dao.ComplainDAO;
import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.ComplainDTO;

@Service
public class ApprovalHistoryService {

    @Autowired
    private ApprovalHistoryDAO approvalHistoryDAO;
    
    @Autowired
    private ComplainDAO complainDAO;

    @Transactional(readOnly = true) 
    public List<ApprovalHistoryDTO> getMyApprovalHistoryList(
            Long accountId, 
            Map<String, Object> filterMap) {
        return approvalHistoryDAO.selectMyApprovalHistoryList(accountId, filterMap);
    }
    

    @Transactional
    public int processApprovalHistory(ApprovalHistoryDTO approvalData) {
        // 필수 값 체크
        if (approvalData.getApprovalStatusCd() == null) {
            throw new IllegalArgumentException("필수 결재 정보가 누락되었습니다.");
        }
        
        int result = 0;
        
        if (approvalData.getSeqNo() == null) {
        	throw new IllegalArgumentException("기존 이력 갱신 시에는 SEQ_NO가 필수입니다.");
        }
        
        Long nextSeq = approvalData.getSeqNo() + 1;
        Long complainId = approvalData.getComplainId();
        String codeId = approvalData.getApprovalStatusCd();
        // 다음 결재자 가져오기
        ApprovalHistoryDTO nextApprovalData = approvalHistoryDAO.getHistoryIdByComplainIdAndSeqNo(
        		complainId, nextSeq);
        if ("E002".equals(codeId)) { // 승인 로직
        	result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        	if(nextApprovalData == null) {
        		ComplainDTO complainDTO = complainDAO.findById(complainId);
        		complainDTO.setComplainStatusCd("D003"); //민원 처리 완료
        		complainDAO.updateStatusByComplainId(complainId, codeId);
        	}
        	else {
        		nextApprovalData.setApprovalStatusCd("E001"); // 결재
        		approvalHistoryDAO.updateApprovalHistoryStatus(nextApprovalData);
        	}
        	return result;
        } 
        else if ("E003".equals(codeId)) { // 반려 로직
        	result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        	nextApprovalData = approvalHistoryDAO.getComplainManager(complainId);
        	nextApprovalData.setApprovalStatusCd("E001"); // 결재
        	approvalHistoryDAO.insertApprovalHistory(nextApprovalData);
        	ComplainDTO complainDTO = complainDAO.findById(complainId);
    		complainDTO.setComplainStatusCd("D005"); //반려
    		complainDAO.updateStatusByComplainId(complainId, codeId);
        	return result;
        } 
        else {
            throw new IllegalArgumentException("처리할 수 없는 결재 상태 코드입니다: " + codeId);
        }
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


	public List<ApprovalHistoryDTO> getApprovalHistoryByComplainId(Long complainId) {
		return approvalHistoryDAO.getHistoryIdByComplainId(complainId);
	}
    
}