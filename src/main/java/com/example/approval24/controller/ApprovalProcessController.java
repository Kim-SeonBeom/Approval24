package com.example.approval24.controller;

import com.example.approval24.domain.ApprovalCreationRequestVO;
import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.service.ApprovalHistoryService;
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

        // 권한 체크 
        if (!loggedInUserId.equals(approvalData.getAccountId())) {
            response.put("success", false);
            response.put("message", "해당 결재를 처리할 권한이 없습니다.");
            return ResponseEntity.status(403).body(response);
        }
        
        // 서비스 로직 호출 및 예외 처리
        try {
            historyService.processApprovalHistory(approvalData);
            
            response.put("success", true);
            response.put("message", "결재 처리가 성공적으로 완료되었습니다.");
            return ResponseEntity.ok(response);

        } catch (IllegalArgumentException e) {
            // 결재 이미 처리됨, 잘못된 상태값 등의 비즈니스 로직 오류
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
}