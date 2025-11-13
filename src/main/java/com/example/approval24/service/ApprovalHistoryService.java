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
import com.example.approval24.domain.ComplainFilterDTO;

@Service
public class ApprovalHistoryService {

    @Autowired
    private ApprovalHistoryDAO approvalHistoryDAO;
    
    @Autowired
    private ComplainDAO complainDAO;

    @Transactional(readOnly = true) 
    public List<ApprovalHistoryDTO> getMyApprovalHistoryList(Map<String, Object> filterMap) {
        return approvalHistoryDAO.selectMyApprovalHistoryList(filterMap);
    }
    

    @Transactional
    public int processApprovalHistory(ApprovalHistoryDTO approvalData) {
        // 필수 값 체크
        if (approvalData.getApprovalStatusCd() == null) {
            throw new IllegalArgumentException("필수 결재 정보가 누락되었습니다.");
        }
        
        int result = 0;
        
        if (approvalData.getSeqNo() == null) {
        	throw new IllegalArgumentException("결재시도는 SEQ_NO가 필수입니다.");
        }
        
        Long nextSeq = approvalData.getSeqNo() + 1;
        Long complainId = approvalData.getComplainId();
        String codeId = approvalData.getApprovalStatusCd();
        ComplainDTO complainDTO = complainDAO.findById(complainId);
        String complain_cd = complainDTO.getComplainStatusCd();
        ApprovalHistoryDTO nextApprovalData = approvalHistoryDAO.getHistoryIdByComplainIdAndSeqNo(
        		complainId, nextSeq);
        
        if(!complain_cd.equals("D002")) {
        	throw new IllegalArgumentException("민원 등록 상태가 아닙니다. 민원 상태 코드: " + complain_cd);
        }
        
        if ("E002".equals(codeId)) { // 승인 로직
  
        	if(nextApprovalData == null) {
        		if(approvalData.getApproverTypeCd().equals("F004")) { // 승인자
        			result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        			complainDAO.updateStatusByComplainId(complainId, "D006"); // 민원 승인
        		}
        		else if(approvalData.getApproverTypeCd().equals("F002")) { // 담당자면
        			throw new IllegalArgumentException("결재선을 지정하고 시도하세요.");
        		}
        		else {
        			throw new IllegalArgumentException("승인자가 아닙니다.");
        		}
        	}
        	else if(approvalData.getApproverTypeCd().equals("F002")) { // 담당자면
        		result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
    			complainDAO.updateStatusByComplainId(complainId, "D003"); // 결재중
        		nextApprovalData.setApprovalStatusCd("E001"); // 결재
        		approvalHistoryDAO.updateApprovalHistoryStatus(nextApprovalData);
        	}
        	else {
        		result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        		nextApprovalData.setApprovalStatusCd("E001"); // 결재
        		approvalHistoryDAO.updateApprovalHistoryStatus(nextApprovalData);
        	}
        	return result;
        } 
        
        else if ("E003".equals(codeId)) { // 반려 로직
        	if(approvalData.getApproverTypeCd().equals("F002")) { // 담당자면
        		result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        		complainDAO.updateStatusByComplainId(complainId, "D005"); // 민원 반려
        	}
        	else { // 검토자나 승인자가 반려하는 경우 
        		result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        	}
        	return result;
        } 
        
        else if ("E005".equals(codeId)) { // 취하 로직
        	if(approvalData.getApproverTypeCd().equals("F002")) { //담당자면
        		result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
        		complainDAO.updateStatusByComplainId(complainId, "D004"); // 민원 취하
        		return result;
        	}
        	else {
        		throw new IllegalArgumentException("취하는 담당자만 가능합니다.");
        	}
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
        
        List<ApprovalHistoryDTO> checkList = approvalHistoryDAO.getHistoryIdByComplainId(complainId);
		ComplainDTO complainDto = complainDAO.findById(complainId);
		ApprovalHistoryDTO managerDTO = approvalHistoryDAO.getComplainManager(complainId);
		
		if (complainDto == null) {
		    throw new IllegalArgumentException("해당 민원이 존재하지 않습니다.");
		}
		
		if(loginId.equals((Long)complainDto.getAccountId())) {
			throw new IllegalArgumentException("담당자 계정이 아닙니다.");
		}
		
		if (complainDto.getComplainStatusCd().equals("D004")) {
        	throw new IllegalArgumentException("이미 취하한 민원입니다.");
        }
        else if (complainDto.getComplainStatusCd().equals("D005")) {
        	throw new IllegalArgumentException("이미 반려된 민원입니다.");
        }
        else if (complainDto.getComplainStatusCd().equals("D006")) {
        	throw new IllegalArgumentException("이미 승인된 민원입니다.");
        }
        
        
        for (int i = 0; i < approvalLine.size(); i++) {
            ApprovalHistoryDTO dto = approvalLine.get(i);

            dto.setComplainId(complainId); 
            if (dto.getAccountId() == null) {
                 throw new IllegalArgumentException((i + 1) + "번째 결재 단계의 **계정 ID**가 누락되었습니다.");
            }

            String approvalStatusCd;
            if (i == 0) {
            	if(!loginId.equals(dto.getAccountId()))
            	{
            		System.out.println("로그인id");
            		System.out.println(loginId);
            		System.out.println("dtogetid");
            		System.out.println(dto.getAccountId());
            		throw new IllegalArgumentException("결재 시작이 본인 계정이 아닙니다.");
            	}
            	if(checkList != null) {
            		continue;
            	}
                approvalStatusCd = "E001";  // 결재
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
	
	
	public int countMyApprovalHistoryList(Map<String, Object> filterMap) {

		return approvalHistoryDAO.countMyApprovalHistoryList(filterMap);
	}


	public boolean checkHistoryManager(long complainId, Long userId) {
	    List<ApprovalHistoryDTO> list = approvalHistoryDAO.getHistoryIdByComplainId(complainId);
	    if (list == null || list.isEmpty()) return false;

	    boolean hasUserE001 = false;  // 본인 E001 존재 여부
	    boolean hasOtherE001 = false; // 다른 사람 E001 존재 여부

	    for (ApprovalHistoryDTO dto : list) {
	        if ("E001".equals(dto.getApprovalStatusCd())) {
	            if (dto.getAccountId().equals(userId)) {
	                hasUserE001 = true;   
	            } else {
	                hasOtherE001 = true;  
	            }
	        }
	    }
	    return hasUserE001 || !hasOtherE001;
	}
}