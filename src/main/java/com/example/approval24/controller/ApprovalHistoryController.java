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
import com.example.approval24.domain.DeptWorkDTO;
import com.example.approval24.domain.PageInfoVO;
import com.example.approval24.domain.TotalCodeDTO;
import com.example.approval24.service.AccountService;
import com.example.approval24.service.ApprovalHistoryService;
import com.example.approval24.service.CategoryService;
import com.example.approval24.service.ComplainService;
import com.example.approval24.service.TotalCodeService;

@Controller
@RequestMapping("/history")
public class ApprovalHistoryController {
	
	@Autowired
	private AccountService accountService;
    
    @Autowired
    private ApprovalHistoryService historyService;
    
    @Autowired
    private TotalCodeService codeService;
    
    @Autowired
    private CategoryService categoryService;
    
    @GetMapping("")
    public String Defalt(Model model) {
    	model.asMap().remove("logininstName");
        model.asMap().remove("loginuserName");
        model.asMap().remove("logindeptName");
    	return "redirect:/history/list";
    }
    
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
        
        Long deptId = accountService.findDeptIdByAccountId(userId);
        
        filterMap.put("accountId", userId);
        filterMap.entrySet().removeIf(e ->
        e.getValue() == null ||
        (e.getValue() instanceof String && ((String) e.getValue()).trim().isEmpty())
        		);


        try {
            
            int totalCount = historyService.countMyApprovalHistoryList(filterMap);

            
            PageInfoVO pageInfo = new PageInfoVO(page, pageSize, totalCount);

            
            filterMap.put("startRow", pageInfo.getStartRow());
            filterMap.put("endRow", pageInfo.getEndRow());

            
            List<ApprovalHistoryDTO> historyList = 
                historyService.getMyApprovalHistoryList(filterMap);

            
            model.addAttribute("historyList", historyList);
            model.addAttribute("filterMap", filterMap);
            model.addAttribute("pageInfo", pageInfo);

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "결재 이력 조회 중 오류가 발생했습니다.");
            return "error/errorPage"; 
        }
        
        List<TotalCodeDTO> statusCodeList = codeService.getTotalCodeByGroupId("E0");
        List<DeptWorkDTO> categoryList = categoryService.categoryByDept(deptId);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("statusCodeList", statusCodeList);

        return "D/approvalLineList"; 
    }
}
