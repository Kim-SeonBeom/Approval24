package com.example.approval24.controller;

import com.example.approval24.domain.ApprovalCreationRequestVO;
import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.service.ApprovalHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
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
        
        try {

            historyService.createApprovalLine(loggedInUserId, complainId,url, approvalLine);
            
            // 4. 성공 응답
            response.put("success", true);
            response.put("message", "새 결재 라인 등록이 성공적으로 완료되었습니다.");
            return ResponseEntity.ok(response);

        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", "데이터 처리 중 오류: " + e.getMessage());
            return ResponseEntity.status(400).body(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "결재 생성 중 알 수 없는 서버 오류가 발생했습니다.");
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * POST /api/approval/process (승인/반려 처리)
     */
    @PostMapping("/process")
    public ResponseEntity<Map<String, Object>> processApproval(
            @RequestBody ApprovalHistoryDTO approvalData, 
            HttpSession session) {
        
    	
    	
        // 이전에 논의했던 승인/반려 로직이 여기에 들어갑니다.
        // 1. 권한 체크 (세션 user == approvalData.getAccountId)
        // 2. historyService.processApprovalHistory(approvalData) 호출
        return null;
        //return ResponseEntity.ok(Map.of("success", true, "message", "처리 로직 구현 필요."));
    }
    
}