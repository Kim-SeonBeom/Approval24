package com.example.approval24.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.approval24.domain.ApprovalHistoryDTO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.TotalCodeService;

@Controller
@RequestMapping("/ApprovalHistory")
public class ApprovalHistoryController {
	@Autowired
	private ApprovalHistoryService historyService;
	
	@Autowired
	private TotalCodeService codeService;
	
	@GetMapping("/list")
    public String getApprovalHistory(
            HttpSession session,
            Model model,
            @RequestParam Map<String, Object> filterMap) {

        Long userId = (Long) session.getAttribute("user");
        if (userId == null) {
            return "redirect:/login"; 
        }
        
        try {
            List<ApprovalHistoryDTO> historyList = 
                historyService.getMyApprovalHistoryList(userId, filterMap);
            
            model.addAttribute("historyList", historyList);
            model.addAttribute("filterMap", filterMap);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "결재 이력 조회 중 오류가 발생했습니다.");
            return "error/errorPage"; 
        }
        
        List<TotalCodeDTO> statusCodeList = codeService.getTotalCodeByGroupId("E0");
        List<TotalCodeDTO> categoryCodeList = codeService.getTotalCodeByGroupId("G0");
        model.addAttribute("categoryCodeList",categoryCodeList);
        model.addAttribute("statusCodeList", statusCodeList);
        
        return "D/AppList"; 
    }
}
