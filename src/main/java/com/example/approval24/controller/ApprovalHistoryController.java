package com.example.approval24.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.ComplainDTO;
import com.example.approval24.domain.PageInfoVO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.TotalCodeService;

@Controller
@RequestMapping("/history")
public class ApprovalHistoryController {
    
    @Autowired
    private ApprovalHistoryService historyService;
    
    @Autowired
    private TotalCodeService codeService;
    
    @GetMapping("/list")
    public String getApprovalHistory(
            HttpSession session,
            Model model,
            @RequestParam Map<String, Object> filterMap,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        Long userId = (Long) session.getAttribute("user");
        if (userId == null) {
            return "redirect:/login"; 
        }
        
        filterMap.put("accountId", userId);
        
        filterMap.entrySet().removeIf(e ->
        e.getValue() == null ||
        (e.getValue() instanceof String && ((String) e.getValue()).trim().isEmpty())
        		);


        try {
            // 1. 전체 데이터 수 조회
            int totalCount = historyService.countMyApprovalHistoryList(filterMap);

            // 2. PageInfoVO 생성 (startRow, endRow 계산 포함)
            PageInfoVO pageInfo = new PageInfoVO(page, pageSize, totalCount);

            // 3. startRow / endRow를 filterMap에 추가
            filterMap.put("startRow", pageInfo.getStartRow());
            filterMap.put("endRow", pageInfo.getEndRow());

            // 4. 페이징 적용된 목록 조회
            List<ApprovalHistoryDTO> historyList = 
                historyService.getMyApprovalHistoryList(filterMap);

            // 5. 모델에 전달
            model.addAttribute("historyList", historyList);
            model.addAttribute("filterMap", filterMap);
            model.addAttribute("pageInfo", pageInfo);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "결재 이력 조회 중 오류가 발생했습니다.");
            return "error/errorPage"; 
        }
        
        List<TotalCodeDTO> statusCodeList = codeService.getTotalCodeByGroupId("E0");
        List<TotalCodeDTO> categoryCodeList = codeService.getTotalCodeByGroupId("G0");
        model.addAttribute("categoryCodeList", categoryCodeList);
        model.addAttribute("statusCodeList", statusCodeList);

        return "D/approvalLineList"; 
    }
}
