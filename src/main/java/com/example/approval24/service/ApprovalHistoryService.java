package com.example.approval24.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.approval24.dao.ApprovalHistoryDAO;
import com.example.approval24.dao.ComplainDAO;
import com.example.approval24.domain.AlarmDTO;
import com.example.approval24.domain.ApprovalCreationRequestVO;
import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.ComplainDTO;

@Service
public class ApprovalHistoryService {

    @Autowired
    private ApprovalHistoryDAO approvalHistoryDAO;
    
    @Autowired
    private ComplainDAO complainDAO;
    
    @Autowired
    private AlarmService alarmService;

    @Transactional(readOnly = true) 
    public List<ApprovalHistoryDTO> getMyApprovalHistoryList(Map<String, Object> filterMap) {
        return approvalHistoryDAO.selectMyApprovalHistoryList(filterMap);
    }
    
    // 결재 진행
    @Transactional
    public int processApprovalHistory(ApprovalHistoryDTO approvalData, Long loggedInUserId) {
        
        // 필수 값 및 SEQ_NO 체크
        if (approvalData.getApprovalStatusCd() == null || approvalData.getComplainId() == null) {
            throw new IllegalArgumentException("필수 결재 정보(상태 코드 또는 민원 ID)가 누락되었습니다.");
        }
        if (approvalData.getSeqNo() == null) {
            throw new IllegalArgumentException("결재시도는 SEQ_NO가 필수입니다.");
        }

        Long nextSeq = approvalData.getSeqNo() + 1;
        Long complainId = approvalData.getComplainId();
        String codeId = approvalData.getApprovalStatusCd();
        
        // 권한 및 위임자 확인
        Long delegateId = approvalHistoryDAO.getProxyIdByAccountAndComplainId(complainId, approvalData.getSeqNo());
        
        boolean isOriginalApprover = approvalData.getAccountId().equals(loggedInUserId);
        boolean isDelegateApprover = delegateId != null && delegateId.equals(loggedInUserId);

        if (!isOriginalApprover && !isDelegateApprover) {
            throw new IllegalArgumentException("결재 권한이 존재하지 않습니다.");
        }

        // 공통 필드 설정 (처리 시각 및 위임 여부)
        approvalData.setProcessDt(new Date());
        approvalData.setApprovalTypeCd("H001"); // 기본 일반 결재
        
        if (isDelegateApprover) {
            approvalData.setDelegateId(delegateId);
            approvalData.setApprovalTypeCd("H002"); // 위임 결재
        }
        
        // 다음 결재자 DTO 조회
        ApprovalHistoryDTO nextApprovalData = approvalHistoryDAO.getHistoryIdByComplainIdAndSeqNo(
                complainId, nextSeq);
        
        
        // 결재 상태 코드별 로직 
        int result = 0;
        
        // 알람용 데이터 준비
        AlarmDTO alarmDTO = new AlarmDTO();
        alarmDTO.setSenderId(loggedInUserId);
        String message = "";
        ApprovalHistoryDTO managerDTO = approvalHistoryDAO.getComplainManager(complainId);
        Long managerId = managerDTO.getAccountId();
        ComplainDTO complainDTO = complainDAO.findById(complainId);
        String categoryName = complainDTO.getCategoryName();
        
        
        if ("E002".equals(codeId)) { // 승인 로직
            result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData); // 현재 결재 이력 승인 처리
            if (nextApprovalData == null) {
                // 마지막 결재자 승인
                // 현재 결재자가 승인자(F004)인지 확인 필요.
                if (!"F004".equals(approvalData.getApproverTypeCd())) {
                    throw new IllegalArgumentException("최종 승인자는 승인자 유형(F004)이어야 합니다.");
                }
                // 최종 승인 시 민원 상태를 D006으로 업데이트
                complainDAO.updateStatusByComplainId(complainId, "D006"); 
                // 담당자에게 알람
                alarmDTO.setReceiverId(managerId);
                message = categoryName + "(민원 번호: " + complainId + ") 민원 승인";
                alarmDTO.setMessage(message);
                alarmDTO.setUrl(approvalData.getUrl());
                alarmService.sendAlarm(alarmDTO);
                
            } else {
                // 중간 결재자 승인 -> 다음 결재자 상태를 E001(결재 대기)로 변경
                nextApprovalData.setApprovalStatusCd("E001"); 
                approvalHistoryDAO.updateApprovalHistoryStatus(nextApprovalData);
                
                // 민원 상태를 D003(결재중)으로 업데이트 (최초 승인 시 이미 D003일 수 있으므로 중복 실행되어도 무방)
                complainDAO.updateStatusByComplainId(complainId, "D003");
                
                // 다음 결재자에게 알림
                alarmDTO.setReceiverId(nextApprovalData.getAccountId());
                message = categoryName + "(민원 번호: " + complainId + ") 결재 요청";
                alarmDTO.setMessage(message);
                alarmDTO.setUrl(approvalData.getUrl());
                alarmService.sendAlarm(alarmDTO);
            }
            return result;
            
        } else if ("E003".equals(codeId)) { //반려 로직
            // 중간 결재자가 반려해도 민원 상태를 바꾸지 않음. (담당자가 재결정)
            // 현재 이력만 E003(반려)로 업데이트
            result = approvalHistoryDAO.updateApprovalHistoryStatus(approvalData);
            
            // 담당자에게 반려 알림 전송 로직 
            alarmDTO.setReceiverId(managerId);
            message = categoryName + "(민원 번호: " + complainId + ") 결재 반려";
            alarmDTO.setMessage(message);
            alarmDTO.setUrl(approvalData.getUrl());
            alarmService.sendAlarm(alarmDTO);
            return result;
            
        } else if ("E005".equals(codeId)) { 
            throw new IllegalArgumentException("취하는 담당자만 가능합니다. (이 메서드에서는 처리 불가)");
            
        } else {
            throw new IllegalArgumentException("처리할 수 없는 결재 상태 코드입니다: " + codeId);
        }
    }


    // 결재선 지정 + 승인 처리
    @Transactional  
    public void createApprovalLine(Long loginId, Long complainId,String url, List<ApprovalHistoryDTO> approvalLine) {
        
        if (complainId == null || approvalLine == null || approvalLine.isEmpty()) {
            throw new IllegalArgumentException("민원 ID 또는 결재 라인 정보가 유효하지 않습니다.");
        }
        
		ComplainDTO complainDto = complainDAO.findById(complainId);
		
		if (complainDto == null) {
		    throw new IllegalArgumentException("해당 민원이 존재하지 않습니다.");
		}
		
		if(!loginId.equals((Long)complainDto.getAccountId())) {
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
		
		int newApproversCount = (int) approvalLine.stream().filter(dto -> dto.getSeqNo() == null).count();
		if (newApproversCount < 3) {
			throw new IllegalArgumentException("새 결재선은 본인(담당자) 포함 최소 3명 이상이어야 합니다.");
		}
        
		// 알람용 데이터 준비
		AlarmDTO alarmDTO = new AlarmDTO();
		alarmDTO.setSenderId(loginId);
		String message = "";
		ComplainDTO complainDTO = complainDAO.findById(complainId);
        String categoryName = complainDTO.getCategoryName();
		
		int cnt = 0;
        
        for (int i = 0; i < approvalLine.size(); i++) {
        	
            ApprovalHistoryDTO dto = approvalLine.get(i);

            dto.setComplainId(complainId); 
            if (dto.getAccountId() == null) {
                 throw new IllegalArgumentException((i + 1) + "번째 결재 단계의 **계정 ID**가 누락되었습니다.");
            }
            
            if(dto.getSeqNo() != null) continue;
            
            if (cnt == 0) {
            	if(!loginId.equals(dto.getAccountId()))
            	{
            		throw new IllegalArgumentException("결재 시작이 본인 계정이 아닙니다.");
            	}
            	dto.setApprovalStatusCd("E002");  // 승인
            	dto.setApprovalTypeCd("H001");  // 일반 결재
            	dto.setProcessDt(new Date());
            	dto.setApproverTypeCd("F002"); //담당자
            	
            } 
            else if(cnt == 1) {
            	dto.setApprovalStatusCd("E001");  
            	dto.setApproverTypeCd("F003");
            	
            	// 결재 단계임. 따라서 알람을 보냄.
            	alarmDTO.setReceiverId(dto.getAccountId());
            	message = categoryName + "(민원 번호: " + complainId + ") 결재 요청";
            	alarmDTO.setUrl(url);
            	alarmDTO.setMessage(message);
            	alarmService.sendAlarm(alarmDTO);
            }
            else if(newApproversCount - 1 == cnt) {
            	dto.setApprovalStatusCd("E004");  // 대기
            	dto.setApproverTypeCd("F004");  //승인자
            }
            else {
            	dto.setApprovalStatusCd("E004");  // 대기
            	dto.setApproverTypeCd("F003");  //검토자
            }
            
            dto.setUrl(url);
            approvalHistoryDAO.insertApprovalHistory(dto);
            cnt++;
        }
        complainDAO.updateStatusByComplainId(complainId, "D003");
    }


    // 특정 민원에 대한 결재내역
	public List<ApprovalHistoryDTO> getApprovalHistoryByComplainId(Long complainId) {
		List<ApprovalHistoryDTO> approvalLine = approvalHistoryDAO.getHistoryIdByComplainId(complainId);
		for (int i = 0; i < approvalLine.size(); i++) {
            ApprovalHistoryDTO dto = approvalLine.get(i);
            dto.setComplainId(complainId); 
		}
		return approvalHistoryDAO.getHistoryIdByComplainId(complainId);
	}
	
	
	public int countMyApprovalHistoryList(Map<String, Object> filterMap) {

		return approvalHistoryDAO.countMyApprovalHistoryList(filterMap);
	}
	

	// 현재 결재중인가? 체크 
	public boolean checkHistoryIng(long complainId, Long userId) {
	    List<ApprovalHistoryDTO> list = approvalHistoryDAO.getHistoryIdByComplainId(complainId);
	    if (list == null || list.isEmpty()) return false;

	    for (ApprovalHistoryDTO dto : list) {
	        if ("E001".equals(dto.getApprovalStatusCd()) && !dto.getAccountId().equals(userId)) 
	        	return true;
	    }
	    return false;
	}

	// 담당자 반려,취하
	public void managerApproval(ApprovalCreationRequestVO requestVO, Long loggedInUserId) {
		// 필수 데이터 검증 및 추출
        if (requestVO.getApprovalLineData() == null || requestVO.getApprovalLineData().isEmpty()) {
            throw new IllegalArgumentException("처리할 결재 데이터가 누락되었습니다.");
        }
        
        ApprovalHistoryDTO managerActionDto = requestVO.getApprovalLineData().get(0);
        
        Long complainId = managerActionDto.getComplainId();
        String statusCd = managerActionDto.getApprovalStatusCd(); 
        String comment = managerActionDto.getApprovalComment();
        
        if (complainId == null || statusCd == null) {
            throw new IllegalArgumentException("필수 정보(민원 ID 또는 상태 코드)가 누락되었습니다.");
        }
        

        
        // AccountID 설정: 현재 로그인 사용자가 곧 담당자
        managerActionDto.setAccountId(loggedInUserId);        
        // 처리 상태, 유형 및 일자 설정
        managerActionDto.setApprovalStatusCd(statusCd); 
        managerActionDto.setApproverTypeCd("F002");   
        managerActionDto.setApprovalTypeCd("H001");   
        managerActionDto.setProcessDt(new Date());    
        managerActionDto.setApprovalComment(comment); 
        managerActionDto.setUrl(requestVO.getContextUrl()); 
        
        
        // 결재 이력 테이블에 단건 INSERT 
        int insertResult = approvalHistoryDAO.insertApprovalHistory(managerActionDto);
        
        if (insertResult != 1) {
            throw new RuntimeException("결재 이력 기록 중 오류가 발생했습니다.");
        }

        // 민원 상태 업데이트
        String complainStatusToUpdate;
        if ("E003".equals(statusCd)) {
            complainStatusToUpdate = "D005"; 
        } else if ("E005".equals(statusCd)) {
            complainStatusToUpdate = "D004"; 
        } else {
            throw new IllegalArgumentException("결재 코드가 이상함 확인필요.");
        }
        
        complainDAO.updateStatusByComplainId(complainId, complainStatusToUpdate);
        
        // 후속 알림 로직 (TODO: 알림 Service 호출 등)
		
	}
}