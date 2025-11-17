package com.example.approval24.controller;

import com.example.approval24.domain.ApprovalCreationRequestVO;
import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.ComplainService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@RestController 
@RequestMapping("/api/approval") 
public class ApprovalProcessController {

    @Autowired
    private ApprovalHistoryService historyService;
    
    @Autowired
    private ComplainService complainService;
    

    @PostMapping("/create")
    public ResponseEntity<Map<String, Object>> createNewApproval(
            @RequestBody ApprovalCreationRequestVO creationRequestVO, 
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        //로그인 사용자 ID 확인
        Long loggedInUserId = (Long) session.getAttribute("user");
        if (loggedInUserId == null) { 
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        // 필수 데이터 추출 및 검증
        Long complainId = creationRequestVO.getComplainId();
        String url = creationRequestVO.getContextUrl();
        List<ApprovalHistoryDTO> approvalLine = creationRequestVO.getApprovalLineData();
        
        if (complainId == null || approvalLine == null || approvalLine.isEmpty() || url == null) {
            response.put("success", false);
            response.put("message", "민원 ID 또는 결재 라인 정보 또는 url이 누락되었습니다.");
            return ResponseEntity.status(400).body(response);
        }
        
		boolean check = historyService.checkHistoryManager(complainId,loggedInUserId);
		
		if(check) {
			response.put("success", false);
	        response.put("message", "결재 중에는 결재선을 추가할 수 없습니다.");
	        return ResponseEntity.status(400).body(response);
		}
        
        try {

            historyService.createApprovalLine(loggedInUserId, complainId, url, approvalLine);
            
            // 4. 성공 응답
            response.put("success", true);
            response.put("message", "새 결재 라인 등록이 성공적으로 완료되었습니다.");
            return ResponseEntity.ok(response);

        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(400).body(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "결재 생성 중 알 수 없는 서버 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    // 결재 진행
    @PostMapping("/process")
    public ResponseEntity<Map<String, Object>> processApproval(
            @RequestBody ApprovalHistoryDTO approvalData, 
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();

        // 로그인 사용자 ID 확인
        Long loggedInUserId = (Long) session.getAttribute("user");
        if (loggedInUserId == null) { 
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response);
        }

        // 필수 데이터 검증
        if (approvalData.getAccountId() == null || approvalData.getComplainId() == null) {
            response.put("success", false);
            response.put("message", "필수 결재 정보(ComplainID 또는 AccountID)가 누락되었습니다.");
            return ResponseEntity.status(400).body(response);
        }
        
        // 서비스 로직 호출 및 예외 처리
        try {
            historyService.processApprovalHistory(approvalData,loggedInUserId);
            
            response.put("success", true);
            response.put("message", "결재 처리가 성공적으로 완료되었습니다.");
            return ResponseEntity.ok(response);

        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", "결재 처리 중 오류: " + e.getMessage());
            return ResponseEntity.status(400).body(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "결재 처리 중 알 수 없는 서버 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    // 내역 조회
    @GetMapping("/line")
    public ResponseEntity<?> getApprovalLine(@RequestParam Long complainId) {

        if (complainId == null) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "민원 ID(complainId)가 누락되었습니다.");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }

        try {
            List<ApprovalHistoryDTO> approvalHistoryList = historyService.getApprovalHistoryByComplainId(complainId);
            return ResponseEntity.ok(approvalHistoryList);

        } catch (IllegalArgumentException e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "데이터 조회 중 오류: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "결재 라인 조회 중 알 수 없는 서버 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(errorResponse);
        }
    }
    
    @PostMapping("/complain/reject") //반려
    public ResponseEntity<Map<String, Object>> complainReject(
    		@RequestParam Long complainId,
            HttpSession session) {
    	
        Map<String, Object> response = new HashMap<>(); 
        
        
        // 로그인 사용자 확인 및 권한 검증 
        Long loggedInUserId = (Long) session.getAttribute("user");
        if (loggedInUserId == null) { 
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response); 
        }

        // 요청 데이터 유효성 검증
        if (complainId == null) {
            response.put("success", false);
            response.put("message", "민원 ID는 필수 항목입니다.");
            return ResponseEntity.badRequest().body(response); 
        }
        
        ComplainDTO dto = complainService.getComplainInfo(complainId);
        
        switch (dto.getComplainStatusCd()) {
        case "D001":
            response.put("success", false);
            response.put("message", "접수중입니다. 민원 내용을 서식을 통해 채워주세요.");
            return ResponseEntity.status(403).body(response);
        case "D004":
            response.put("success", false);
            response.put("message", "이미 취하된 민원입니다.");
            return ResponseEntity.status(403).body(response);
        case "D005":
            response.put("success", false);
            response.put("message", "이미 반려된 민원입니다.");
            return ResponseEntity.status(403).body(response);
        case "D006":
            response.put("success", false);
            response.put("message", "이미 승인된 민원입니다.");
            return ResponseEntity.status(403).body(response);
            }
        
        //담당자 체크
        if (!loggedInUserId.equals((Long)dto.getAccountId()) ) {
            response.put("success", false);
            response.put("message", "해당 민원을 처리할 담당자가 아닙니다.");
            return ResponseEntity.status(403).body(response);
        }
        try {
        	complainService.setComplainStatus(complainId,"D005");
        	response.put("success", true);
        	response.put("message", "민원 상태가 성공적으로 변경되었습니다.");
        	return ResponseEntity.ok(response);
            
        } catch (Exception e) {       
        	response.put("success", false);
        	response.put("message", "민원 상태 변경 중 오류가 발생했습니다: " + e.getMessage()); 
        	return ResponseEntity.internalServerError().body(response); 
        }
    }
    
    @PostMapping("/complain/cancel") //취하
    public ResponseEntity<Map<String, Object>> complainCancel(
    		@RequestParam Long complainId,
            HttpSession session) {
    	
        Map<String, Object> response = new HashMap<>(); 
        
        
        // 로그인 사용자 확인 및 권한 검증 
        Long loggedInUserId = (Long) session.getAttribute("user");
        if (loggedInUserId == null) { 
            response.put("success", false);
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(401).body(response); 
        }

        // 요청 데이터 유효성 검증
        if (complainId == null) {
            response.put("success", false);
            response.put("message", "민원 ID는 필수 항목입니다.");
            return ResponseEntity.badRequest().body(response); 
        }
        
        ComplainDTO dto = complainService.getComplainInfo(complainId);
        
        switch (dto.getComplainStatusCd()) {
        case "D001":
            response.put("success", false);
            response.put("message", "접수중입니다. 민원 내용을 서식을 통해 채워주세요.");
            return ResponseEntity.status(403).body(response);
        case "D004":
            response.put("success", false);
            response.put("message", "이미 취하된 민원입니다.");
            return ResponseEntity.status(403).body(response);
        case "D005":
            response.put("success", false);
            response.put("message", "이미 반려된 민원입니다.");
            return ResponseEntity.status(403).body(response);
        case "D006":
            response.put("success", false);
            response.put("message", "이미 승인된 민원입니다.");
            return ResponseEntity.status(403).body(response);
            }
        
        
        
        //담당자 체크
        if (!loggedInUserId.equals((Long)dto.getAccountId())) {
            response.put("success", false);
            response.put("message", "해당 민원을 처리할 담당자가 아닙니다.");
            return ResponseEntity.status(403).body(response);
        }
        try {
        	complainService.setComplainStatus(complainId,"D004");
        	response.put("success", true);
        	response.put("message", "민원 상태가 성공적으로 변경되었습니다.");
        	return ResponseEntity.ok(response);
            
        } catch (Exception e) {       
        	response.put("success", false);
        	response.put("message", "민원 상태 변경 중 오류가 발생했습니다: " + e.getMessage()); 
        	return ResponseEntity.internalServerError().body(response); 
        }
    }
}
        	
        	
        

    